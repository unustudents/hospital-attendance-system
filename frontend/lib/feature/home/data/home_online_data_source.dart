import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../service/attendance_service.dart';
import '../../../core/utils/app_logger.dart';

class HomeDataOnline {
  /// Base URL untuk backend - otomatis detect platform
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Android emulator menggunakan 10.0.2.2 untuk akses host machine
      return 'http://10.0.2.2:8080';
    } else if (Platform.isIOS) {
      // iOS simulator bisa menggunakan localhost
      return 'http://localhost:8080';
    } else {
      // Web, desktop, atau platform lain
      return 'http://localhost:8080';
    }
  }

  /// Test koneksi ke backend
  /// Returns [bool] true jika backend accessible
  static Future<bool> testConnection() async {
    try {
      final url = '$baseUrl/v1/attendance?user=1';
      AppLogger.logApiRequest(url, null);
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5));
      AppLogger.logApiResponse(response.statusCode, null);
      return response.statusCode == 200;
    } catch (e) {
      AppLogger.warning('❌ Connection test failed: $e');
      return false;
    }
  }

  /// Mengambil data presensi dalam format dummy data dari backend
  /// [userId] - ID user yang akan diambil datanya
  /// Returns [AttendanceData] dalam format yang sama dengan dummy data
  static Future<AttendanceData> getAttendanceData(int userId) async {
    try {
      final url = Uri.parse('$baseUrl/v1/attendance?user=$userId');
      final headers = {'Content-Type': 'application/json'};

      AppLogger.logApiRequest(url.toString(), headers);

      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: 10));

      AppLogger.logApiResponse(response.statusCode, response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        AppLogger.debug('✅ Data parsing successful', tag: 'API');

        // Validasi format data
        if (jsonData['data'] != null &&
            _isValidAttendanceFormat(jsonData['data'])) {
          return AttendanceData.fromJson(jsonData['data']);
        } else {
          throw Exception('Format data tidak sesuai dengan format dummy');
        }
      } else {
        throw Exception({
          'Server error': response.statusCode,
          'Message': response.body,
        });
      }
    } catch (e) {
      AppLogger.error(
        'API call failed',
        tag: 'API',
        error: e,
        data: {'endpoint': '/v1/attendance', 'userId': userId},
      );

      if (e.toString().contains('Connection refused')) {
        throw Exception(
          'Backend tidak dapat diakses. Pastikan backend berjalan di $baseUrl',
        );
      }
      throw Exception('Gagal mendapatkan data presensi: ${e.toString()}');
    }
  }

  /// Cek apakah data response sudah dalam format AttendanceData yang benar
  static bool _isValidAttendanceFormat(Map<String, dynamic> data) {
    final requiredFields = [
      'id',
      'nama',
      'jam_masuk_shift',
      'jam_pulang_shift',
      'nama_shift',
      'total_hadir',
      'total_izin',
      'total_sakit',
      'total_cuti',
      'presensi_mingguan',
    ];

    // Cek semua field wajib ada
    for (String field in requiredFields) {
      if (!data.containsKey(field)) {
        AppLogger.warning(
          'Missing required field: $field',
          tag: 'DataValidation',
          data: {'availableFields': data.keys.toList()},
        );
        return false;
      }
    }

    // Cek format presensi_mingguan
    if (data['presensi_mingguan'] is! List) {
      AppLogger.warning(
        'Invalid format: presensi_mingguan must be a List',
        tag: 'DataValidation',
        data: {'actualType': data['presensi_mingguan'].runtimeType.toString()},
      );
      return false;
    }

    AppLogger.debug('✅ Data format validation passed', tag: 'DataValidation');
    return true;
  }
}
