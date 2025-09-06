import 'package:dart_frog/dart_frog.dart';
import 'package:hospital_attendance_system/services/pegawai_service.dart';
import 'package:hospital_attendance_system/services/presensi_service.dart';

Future<Response> onRequest(RequestContext context) async {
  // Mendapatkan query parameter 'user'
  final userParam = context.request.uri.queryParameters['user'];

  // Validasi parameter user
  if (userParam == null || userParam.isEmpty) {
    return Response.json(
      body: {
        'error': 'Parameter user is required',
        'message':
            'Please provide user parameter in the URL: /v1/home?user=<user_id>',
      },
      statusCode: 400,
    );
  }

  // Validasi bahwa user parameter adalah angka
  final userId = int.tryParse(userParam);
  if (userId == null) {
    return Response.json(
      body: {
        'error': 'Invalid user parameter',
        'message': 'User parameter must be a valid number',
      },
      statusCode: 400,
    );
  }

  try {
    // Mengambil data pegawai (nama dan departemen) dari database
    final dataPegawai = await PegawaiService.getPegawaiDataById(userId);
    final dataPresensi = await PresensiService.getAvailableShifts().toString();

    if (dataPegawai == null) {
      return Response.json(
        body: {
          'error': 'Pegawai not found',
          'message': 'Pegawai dengan ID $userId tidak ditemukan.',
        },
        statusCode: 404,
      );
    }

    // Response sukses dengan data user
    return Response.json(
      body: {
        'success': true,
        'message': 'Data pegawai berhasil',
        'data_lain': dataPresensi,
        'data': {
          'user_id': userId,
          'nama_pegawai': dataPegawai['nama'],
          'departemen': dataPegawai['departemen'],
          'shifts': dataPegawai['shifts'],
          'sudah_absensi': dataPegawai['sudah_absensi'],
          'presensi_aktif': dataPegawai['presensi_aktif'],
          'endpoint': '/v1/home?user=$userId',
          'timestamp': DateTime.now().toIso8601String(),
        },
      },
    );
  } catch (e) {
    return Response.json(
      body: {
        'error': 'Database error',
        'message': 'Terjadi kesalahan saat mengambil data pegawai: $e',
      },
      statusCode: 500,
    );
  }
}
