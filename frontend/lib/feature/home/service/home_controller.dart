import 'package:flutter/foundation.dart';
import 'attendance_service.dart';

/// Controller service for managing attendance data
/// Provides easy-to-use methods for different scenarios
class HomeController {
  static HomeController? _instance;
  static HomeController get instance => _instance ??= HomeController._();

  HomeController._();

  final AttendanceService _attendanceService = AttendanceService.instance;

  /// Load attendance data with automatic mode detection
  /// Debug mode: uses dummy data
  /// Release mode: uses online data
  Future<AttendanceData> loadAttendanceData({int? userId}) async {
    try {
      return await _attendanceService.getAttendanceData(userId: userId);
    } catch (e) {
      throw Exception('Failed to load attendance data: $e');
    }
  }

  /// Force load dummy data (for testing/development)
  Future<AttendanceData> loadDummyData() async {
    try {
      return await _attendanceService.getDummyData();
    } catch (e) {
      throw Exception('Failed to load dummy data: $e');
    }
  }

  /// Force load online data (for production testing)
  Future<AttendanceData> loadOnlineData(int userId) async {
    try {
      return await _attendanceService.getOnlineData(userId);
    } catch (e) {
      throw Exception('Failed to load online data: $e');
    }
  }

  /// Test backend connection
  Future<bool> testConnection() async {
    return await _attendanceService.testConnection();
  }

  /// Get current mode (debug/release)
  String get currentMode => kDebugMode ? 'dummy' : 'online';

  /// Check if currently using dummy data
  bool get isUsingDummyData => kDebugMode;

  /// Get data source description
  String get dataSourceDescription {
    return kDebugMode
        ? 'Using dummy data from /lib/core/resource/data_home.dart'
        : 'Using online data from HomeDataOnline API';
  }
}

/// Extension for easy access in widgets
extension HomeControllerWidget on HomeController {
  /// Load data with error handling for UI
  Future<AttendanceDataResult> loadDataSafely({int? userId}) async {
    try {
      final data = await loadAttendanceData(userId: userId);
      return AttendanceDataResult.success(data);
    } catch (e) {
      return AttendanceDataResult.error(e.toString());
    }
  }
}

/// Result wrapper for UI handling
class AttendanceDataResult {
  final AttendanceData? data;
  final String? error;
  final bool isSuccess;

  AttendanceDataResult.success(this.data) : error = null, isSuccess = true;

  AttendanceDataResult.error(this.error) : data = null, isSuccess = false;
}
