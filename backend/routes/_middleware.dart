import 'package:dart_frog/dart_frog.dart';
import 'package:hospital_attendance_system/database/db_pool.dart';
import 'package:mysql_client_plus/mysql_client_plus.dart';

// Global middleware chain.
Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(_provideDbPool());
}

// Initialize & inject DB pool; if unavailable respond 503 gracefully.
Middleware _provideDbPool() {
  return (handler) => (context) async {
        try {
          final pool = await DbPool.ensureReady();
          return handler(
            context.provide<MySQLConnectionPool>(() => pool),
          );
        } on DbConnectionException catch (e) {
          return Response.json(
            statusCode: 503,
            body: {
              'error': {
                'code': 'DB_UNAVAILABLE',
                'message': 'Database unavailable',
                'detail': e.message,
              }
            },
          );
        } catch (e) {
          return Response.json(
            statusCode: 500,
            body: {
              'error': {
                'code': 'DB_INIT_FATAL',
                'message': 'Unexpected DB init error',
              }
            },
          );
        }
      };
}
