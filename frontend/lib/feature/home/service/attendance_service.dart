import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../core/resource/data_home.dart';
import '../data/home_online_data_source.dart';

/// Main attendance service that provides hybrid data source functionality
class AttendanceService {
  static AttendanceService? _instance;
  static AttendanceService get instance => _instance ??= AttendanceService._();

  AttendanceService._();

  /// Get attendance data based on environment
  /// In debug mode: uses dummy data
  /// In release mode: uses online data from HomeDataOnline
  Future<AttendanceData> getAttendanceData({int? userId}) async {
    if (kDebugMode) {
      return _getDummyAttendanceData();
    } else {
      return _getOnlineAttendanceData(userId ?? 1);
    }
  }

  /// Force get dummy data (for testing)
  Future<AttendanceData> getDummyData() async {
    return _getDummyAttendanceData();
  }

  /// Force get online data (for production testing)
  Future<AttendanceData> getOnlineData(int userId) async {
    return _getOnlineAttendanceData(userId);
  }

  /// Get dummy data from resource file
  Future<AttendanceData> _getDummyAttendanceData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final jsonData = json.decode(dummyDataHome);
    return AttendanceData.fromJson(jsonData);
  }

  /// Get online data from HomeDataOnline and transform to match dummy format
  Future<AttendanceData> _getOnlineAttendanceData(int userId) async {
    try {
      final pegawaiResponse = await HomeDataOnline.getAttendanceData(userId);
      return _transformPegawaiToAttendance(pegawaiResponse);
    } catch (e) {
      throw Exception('Failed to get online attendance data: $e');
    }
  }

  /// Transform PegawaiResponse to AttendanceData format
  AttendanceData _transformPegawaiToAttendance(dynamic pegawaiResponse) {
    final data = pegawaiResponse.data;
    final presensiAktif = data.presensiAktif;

    // Get shift information (use first shift if available)
    final shift = data.shifts.isNotEmpty ? data.shifts.first : null;

    // Create weekly attendance data
    final weeklyAttendance = _generateWeeklyAttendance(presensiAktif);

    return AttendanceData(
      id: data.userId.toString(),
      nama: data.namaPegawai,
      jamMasukShift: shift?.jamMasuk ?? "07:00",
      jamPulangShift: shift?.jamPulang ?? "15:00",
      namaShift: shift?.shift ?? "Pagi",
      jamMasukAktual: presensiAktif?.jamDatangFormatted ?? "07:15",
      jamPulangAktual: presensiAktif?.jamPulangFormatted ?? "15:10",
      totalHadir: _calculateTotalHadir(weeklyAttendance),
      totalIzin: _calculateTotalIzin(weeklyAttendance),
      totalSakit: _calculateTotalSakit(weeklyAttendance),
      totalCuti: _calculateTotalCuti(weeklyAttendance),
      presensiMingguan: weeklyAttendance,
    );
  }

  /// Generate weekly attendance data
  List<DailyAttendance> _generateWeeklyAttendance(dynamic presensiAktif) {
    final today = DateTime.now();
    final weekStart = today.subtract(Duration(days: today.weekday - 1));

    return List.generate(7, (index) {
      final date = weekStart.add(Duration(days: index));
      final dateStr =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      // Use actual attendance data if available for today
      if (index == today.weekday - 1 && presensiAktif != null) {
        return DailyAttendance(
          tanggal: dateStr,
          jamMasuk: presensiAktif.jamDatangFormatted,
          jamPulang: presensiAktif.jamPulangFormatted == "-"
              ? null
              : presensiAktif.jamPulangFormatted,
          status: "hadir",
        );
      }

      // Generate sample data for other days
      return DailyAttendance(
        tanggal: dateStr,
        jamMasuk: index < 5 ? "07:${10 + index * 2}" : null,
        jamPulang: index < 5 ? "15:${10 + index * 2}" : null,
        status: index < 5 ? "hadir" : (index == 5 ? "izin" : "cuti"),
      );
    });
  }

  // Calculate totals from weekly attendance
  int _calculateTotalHadir(List<DailyAttendance> weekly) {
    return weekly.where((day) => day.status == "hadir").length;
  }

  int _calculateTotalIzin(List<DailyAttendance> weekly) {
    return weekly.where((day) => day.status == "izin").length;
  }

  int _calculateTotalSakit(List<DailyAttendance> weekly) {
    return weekly.where((day) => day.status == "sakit").length;
  }

  int _calculateTotalCuti(List<DailyAttendance> weekly) {
    return weekly.where((day) => day.status == "cuti").length;
  }

  /// Test connection to backend (only works in online mode)
  Future<bool> testConnection() async {
    try {
      return await HomeDataOnline.testConnection();
    } catch (e) {
      return false;
    }
  }
}

/// Data model for attendance information (matches dummy data format)
class AttendanceData {
  final String id;
  final String nama;
  final String jamMasukShift;
  final String jamPulangShift;
  final String namaShift;
  final String jamMasukAktual;
  final String jamPulangAktual;
  final int totalHadir;
  final int totalIzin;
  final int totalSakit;
  final int totalCuti;
  final List<DailyAttendance> presensiMingguan;

  AttendanceData({
    required this.id,
    required this.nama,
    required this.jamMasukShift,
    required this.jamPulangShift,
    required this.namaShift,
    required this.jamMasukAktual,
    required this.jamPulangAktual,
    required this.totalHadir,
    required this.totalIzin,
    required this.totalSakit,
    required this.totalCuti,
    required this.presensiMingguan,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'] as String,
      nama: json['nama'] as String,
      jamMasukShift: json['jam_masuk_shift'] as String,
      jamPulangShift: json['jam_pulang_shift'] as String,
      namaShift: json['nama_shift'] as String,
      jamMasukAktual: json['jam_masuk_aktual'] as String,
      jamPulangAktual: json['jam_pulang_aktual'] as String,
      totalHadir: json['total_hadir'] as int,
      totalIzin: json['total_izin'] as int,
      totalSakit: json['total_sakit'] as int,
      totalCuti: json['total_cuti'] as int,
      presensiMingguan: (json['presensi_mingguan'] as List)
          .map((e) => DailyAttendance.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'jam_masuk_shift': jamMasukShift,
      'jam_pulang_shift': jamPulangShift,
      'nama_shift': namaShift,
      'jam_masuk_aktual': jamMasukAktual,
      'jam_pulang_aktual': jamPulangAktual,
      'total_hadir': totalHadir,
      'total_izin': totalIzin,
      'total_sakit': totalSakit,
      'total_cuti': totalCuti,
      'presensi_mingguan': presensiMingguan.map((e) => e.toJson()).toList(),
    };
  }
}

/// Data model for daily attendance
class DailyAttendance {
  final String tanggal;
  final String? jamMasuk;
  final String? jamPulang;
  final String status;

  DailyAttendance({
    required this.tanggal,
    this.jamMasuk,
    this.jamPulang,
    required this.status,
  });

  factory DailyAttendance.fromJson(Map<String, dynamic> json) {
    return DailyAttendance(
      tanggal: json['tanggal'] as String,
      jamMasuk: json['jam_masuk'] as String?,
      jamPulang: json['jam_pulang'] as String?,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'jam_masuk': jamMasuk,
      'jam_pulang': jamPulang,
      'status': status,
    };
  }
}
