import 'dart:async';
import 'dart:io';
import 'package:mysql_client_plus/mysql_client_plus.dart';

/// Database connection exception.
class DbConnectionException implements Exception {
  /// Creates a database connection exception.
  DbConnectionException(this.message, [this.cause]);

  /// The error message describing what went wrong.
  final String message;

  /// The underlying cause of this exception, if any.
  final Object? cause;
  @override
  String toString() =>
      'DbConnectionException: $message${cause != null ? ' (cause: $cause)' : ''}';
}

/// Database connection pool singleton.
class DbPool {
  DbPool._();

  static MySQLConnectionPool? _pool;
  static Completer<MySQLConnectionPool>? _initCompleter;
  static DateTime? _lastPingOkAt;

  /// Gets or creates a ready-to-use database connection pool.
  static Future<MySQLConnectionPool> ensureReady({
    bool forcePing = false,
  }) async {
    final existing = _pool;
    final now = DateTime.now();
    if (existing != null) {
      final sinceOk =
          _lastPingOkAt == null ? null : now.difference(_lastPingOkAt!);
      if (!forcePing &&
          sinceOk != null &&
          sinceOk < const Duration(seconds: 30)) {
        return existing;
      }
      await _ping(existing);
      return existing;
    }

    if (_initCompleter != null) {
      try {
        return await _initCompleter!.future;
      } catch (e) {
        throw DbConnectionException('Failed to initialize DB (concurrent)', e);
      }
    }

    _initCompleter = Completer<MySQLConnectionPool>();
    try {
      final pool = _createPool();
      await _ping(pool, first: true);
      _pool = pool;
      _initCompleter!.complete(pool);
      return pool;
    } catch (e) {
      _initCompleter!.completeError(e);
      rethrow;
    } finally {
      scheduleMicrotask(() {
        _initCompleter = null;
      });
    }
  }

  static MySQLConnectionPool _createPool() {
    final host = _env('DB_HOST', '127.0.0.1');
    final port = int.tryParse(_env('DB_PORT', '3306')) ?? 3306;
    final user = _env('DB_USER', 'sik');
    final password = _env('DB_PASS', 'sik');
    final database = _env('DB_NAME', 'sik');
    final maxConn = int.tryParse(_env('DB_MAX_CONNECTIONS', '10')) ?? 10;
    final timeoutMs = int.tryParse(_env('DB_TIMEOUT_MS', '10000')) ?? 10000;
    final collation = _env('DB_COLLATION', 'utf8mb4_general_ci');
    final secure = _env('DB_SECURE', 'false').toLowerCase() == 'true';

    return MySQLConnectionPool(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: database,
      maxConnections: maxConn,
      secure: secure,
      timeoutMs: timeoutMs,
      collation: collation,
    );
  }

  static Future<void> _ping(
    MySQLConnectionPool pool, {
    bool first = false,
  }) async {
    try {
      await pool.execute('SELECT 1');
      _lastPingOkAt = DateTime.now();
    } catch (e) {
      if (first) {
        throw DbConnectionException('Initial database connectivity failed', e);
      } else {
        throw DbConnectionException('Database ping failed', e);
      }
    }
  }

  static String _env(String key, String fallback) {
    final value = Platform.environment[key];
    return (value != null && value.isNotEmpty) ? value : fallback;
  }
}
