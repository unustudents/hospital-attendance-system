import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Log level enumeration
enum LogLevel { debug, info, warning, error, critical }

/// Professional logging utility untuk aplikasi hospital attendance
class AppLogger {
  static const String _loggerName = 'HospitalAttendance';

  /// Log dengan level INFO
  static void info(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(LogLevel.info, message, tag: tag, data: data);
  }

  /// Log dengan level DEBUG (hanya tampil di debug mode)
  static void debug(String message, {String? tag, Map<String, dynamic>? data}) {
    if (kDebugMode) {
      _log(LogLevel.debug, message, tag: tag, data: data);
    }
  }

  /// Log dengan level WARNING
  static void warning(
    String message, {
    String? tag,
    Map<String, dynamic>? data,
  }) {
    _log(LogLevel.warning, message, tag: tag, data: data);
  }

  /// Log dengan level ERROR
  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Log dengan level CRITICAL
  static void critical(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    _log(
      LogLevel.critical,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
      data: data,
    );
  }

  /// Internal logging method
  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    final logTag = tag ?? _loggerName;
    final levelIcon = _getLevelIcon(level);
    final levelName = level.name.toUpperCase();

    // Format pesan log
    final logMessage = '$levelIcon [$levelName] [$logTag] $message';

    // Tambahkan data jika ada
    String fullMessage = logMessage;
    if (data != null && data.isNotEmpty) {
      fullMessage += '\n  Data: ${data.toString()}';
    }

    // Log menggunakan dart:developer untuk better debugging
    developer.log(
      fullMessage,
      time: DateTime.now(),
      level: _getDeveloperLogLevel(level),
      name: logTag,
      error: error,
      stackTrace: stackTrace,
    );

    // Untuk production, bisa ditambahkan integration dengan crash reporting
    // seperti Firebase Crashlytics, Sentry, dll
    if (!kDebugMode &&
        (level == LogLevel.error || level == LogLevel.critical)) {
      _logToExternalService(level, message, error, stackTrace, data);
    }
  }

  /// Mendapatkan icon untuk setiap level
  static String _getLevelIcon(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
      case LogLevel.critical:
        return '🚨';
    }
  }

  /// Convert ke dart:developer log level
  static int _getDeveloperLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500; // Fine
      case LogLevel.info:
        return 800; // Info
      case LogLevel.warning:
        return 900; // Warning
      case LogLevel.error:
        return 1000; // Severe
      case LogLevel.critical:
        return 1200; // Shout
    }
  }

  /// Log ke external service (untuk production)
  static void _logToExternalService(
    LogLevel level,
    String message,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  ) {
    // Placeholder untuk future integration dengan external logging services
    // seperti Firebase Crashlytics, Sentry, dll
  }

  /// Utility untuk log API request
  static void logApiRequest(String url, Map<String, String>? headers) {
    info(
      'API Request: $url',
      tag: 'API',
      data: {'url': url, 'headers': headers},
    );
  }

  /// Utility untuk log API response
  static void logApiResponse(int statusCode, String? responseBody) {
    final isSuccess = statusCode >= 200 && statusCode < 300;
    final message = 'API Response: $statusCode';

    if (isSuccess) {
      info(message, tag: 'API', data: {'status_code': statusCode});
    } else {
      error(
        message,
        tag: 'API',
        data: {'status_code': statusCode, 'response': responseBody},
      );
    }
  }
}
