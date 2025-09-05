import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/pegawai.dart';

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

  /// Mengambil data pegawai dari backend
  /// [userId] - ID user yang akan diambil datanya
  /// Returns [PegawaiResponse] jika berhasil
  /// Throws [Exception] jika gagal
  static Future<PegawaiResponse> getPegawaiData(int userId) async {
    try {
      final url = Uri.parse('$baseUrl/v1/home?user=$userId');
      print('🌐 Trying to connect to: $url'); // Debug info

      final response = await http
          .get(url, headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 10));

      print('📡 Response status: ${response.statusCode}'); // Debug info

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('✅ Response data: $jsonData'); // Debug info
        return PegawaiResponse.fromJson(jsonData);
      } else {
        throw Exception({
          'Server error': response.statusCode,
          'Message': response.body,
        });
      }
    } catch (e) {
      print('❌ Error occurred: $e'); // Debug info
      if (e.toString().contains('Connection refused')) {
        throw Exception(
          'Backend tidak dapat diakses. Pastikan backend berjalan di $baseUrl',
        );
      }
      throw Exception('Network error: ${e.toString()}');
    }
  }

  /// Test koneksi ke backend
  /// Returns [bool] true jika backend accessible
  static Future<bool> testConnection() async {
    try {
      final url = Uri.parse('$baseUrl/v1/home?user=1');
      print('🔍 Testing connection to: $url'); // Debug info
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      print('🔍 Test response: ${response.statusCode}'); // Debug info
      return response.statusCode == 200;
    } catch (e) {
      print('❌ Connection test failed: $e'); // Debug info
      return false;
    }
  }
}
