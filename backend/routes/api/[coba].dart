import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context, String coba) async {
  final request = context.request;
  final method = request.method;

  // Get request body if available
  String? requestBody;
  try {
    if (method == HttpMethod.post ||
        method == HttpMethod.put ||
        method == HttpMethod.patch) {
      requestBody = await request.body();
    }
  } catch (e) {
    requestBody = 'Error reading body: $e';
  }

  // Helper function to safely get header value
  String? getHeader(String key) {
    final value = request.headers[key.toLowerCase()];
    return value;
  }

  // Build comprehensive request information
  final basicInfo = {
    'method': method.value,
    'url': request.url.toString(),
    'path': request.url.path,
    'path_parameter_coba': coba,
  };

  final connectionInfo = {
    'local_port': request.connectionInfo.localPort,
    'remote_address': request.connectionInfo.remoteAddress.address,
    'remote_port': request.connectionInfo.remotePort,
  };

  final headers = <String, String>{
    for (final header in request.headers.entries) header.key: header.value,
  };

  final queryParams = <String, String>{
    for (final param in request.url.queryParameters.entries)
      param.key: param.value,
  };

  final bodyInfo = {
    'content': requestBody,
    'content_length': getHeader('content-length'),
    'content_type': getHeader('content-type'),
  };

  final timestamp = DateTime.now().toIso8601String();
  final userAgent = getHeader('user-agent') ?? 'Unknown';
  final host = getHeader('host') ?? 'Unknown';
  final accept = getHeader('accept') ?? 'Unknown';

  // Format response based on Accept header
  final acceptHeader = getHeader('accept') ?? '';

  if (acceptHeader.contains('application/json')) {
    return Response.json(
      body: {
        'message': 'Hospital Attendance System API - Request Context',
        'status': 'success',
        'data': {
          'basic_info': basicInfo,
          'connection_info': connectionInfo,
          'headers': headers,
          'query_parameters': queryParams,
          'body': bodyInfo,
          'timestamp': timestamp,
          'user_agent': userAgent,
          'host': host,
          'accept': accept,
        },
      },
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods':
            'GET, POST, PUT, DELETE, PATCH, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
    );
  } else {
    // Return formatted text response
    final buffer = StringBuffer()
      ..writeln('🏥 Hospital Attendance System API - Request Context')
      ..writeln('=' * 60)
      ..writeln()
      ..writeln('📋 BASIC INFO:')
      ..writeln('  Method: ${basicInfo['method']}')
      ..writeln('  URL: ${basicInfo['url']}')
      ..writeln('  Path: ${basicInfo['path']}')
      ..writeln('  Path Parameter [coba]: ${basicInfo['path_parameter_coba']}')
      ..writeln()
      ..writeln('🌐 CONNECTION INFO:')
      ..writeln('  Local Port: ${connectionInfo['local_port']}')
      ..writeln('  Remote Address: ${connectionInfo['remote_address']}')
      ..writeln('  Remote Port: ${connectionInfo['remote_port']}')
      ..writeln()
      ..writeln('📤 HEADERS:');
    if (headers.isEmpty) {
      buffer.writeln('  No headers');
    } else {
      for (final header in headers.entries) {
        buffer.writeln('  ${header.key}: ${header.value}');
      }
    }
    buffer
      ..writeln()
      ..writeln('🔍 QUERY PARAMETERS:');
    if (queryParams.isEmpty) {
      buffer.writeln('  No query parameters');
    } else {
      for (final param in queryParams.entries) {
        buffer.writeln('  ${param.key}: ${param.value}');
      }
    }
    buffer
      ..writeln()
      ..writeln('📦 REQUEST BODY:')
      ..writeln(
        '  Content Type: ${bodyInfo['content_type'] ?? 'Not specified'}',
      )
      ..writeln(
        '  Content Length: ${bodyInfo['content_length'] ?? 'Not specified'}',
      )
      ..writeln(
        '  Content: ${bodyInfo['content'] ?? 'No body or body is empty'}',
      )
      ..writeln()
      ..writeln('🕐 METADATA:')
      ..writeln('  Timestamp: $timestamp')
      ..writeln('  User Agent: $userAgent')
      ..writeln('  Host: $host')
      ..writeln('  Accept: $accept')
      ..writeln()
      ..writeln('=' * 60)
      ..writeln('✅ Request processed successfully');

    return Response(
      body: buffer.toString(),
      headers: {
        'Content-Type': 'text/plain; charset=utf-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods':
            'GET, POST, PUT, DELETE, PATCH, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization',
      },
    );
  }
}
