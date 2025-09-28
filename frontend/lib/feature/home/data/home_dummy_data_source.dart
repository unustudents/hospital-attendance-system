import 'dart:convert';
import '../../../core/resource/data_home.dart';
import '../service/attendance_service.dart';

/// Sumber data dummy yang membaca dari file resource
class HomeDummyDataSource {
  /// Mendapatkan data presensi dari resource dummy
  static Future<AttendanceData> getAttendanceData() async {
    // Simulasi delay jaringan untuk testing yang realistis
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final jsonData = json.decode(dummyDataHome);
      return AttendanceData.fromJson(jsonData);
    } catch (e) {
      throw Exception('Gagal mengurai data dummy: $e');
    }
  }

  /// Mendapatkan data JSON mentah sebagai Map
  static Future<Map<String, dynamic>> getRawData() async {
    try {
      return json.decode(dummyDataHome);
    } catch (e) {
      throw Exception('Gagal mengurai JSON dummy: $e');
    }
  }
}
