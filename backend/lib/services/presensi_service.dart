import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:hospital_attendance_system/database/db_pool.dart';

/// Presensi service for handling employee attendance system
/// Translated from PHP sample.php logic
class PresensiService {
  // ===== MAIN API ENDPOINTS =====

  /// Process attendance submission (check-in or check-out)
  static Future<Response> processAttendance(Request request) async {
    try {
      final body = await request.json() as Map<String, dynamic>;

      final jamMasuk = body['jam_masuk'] as String?;
      final barcode = body['barcode'] as String?;
      final imageBase64 = body['image'] as String?;

      // Validate input
      final validation = _validateInput(jamMasuk, barcode, imageBase64);
      if (validation != null) {
        return Response.json(body: {'error': validation}, statusCode: 400);
      }

      // Get employee ID from barcode
      final employeeId = await getEmployeeIdFromBarcode(barcode!);
      if (employeeId == null) {
        return Response.json(
          body: {'error': 'Nomor kartu tidak valid'},
          statusCode: 400,
        );
      }

      // Get shift and department info
      final shiftInfo = await getShiftInfo(jamMasuk!, employeeId);
      if (shiftInfo == null) {
        return Response.json(
          body: {
            'error':
                'ID Pegawai atau Jam Masuk ada yang salah, Silahkan pilih berdasarkan shift departemen anda'
          },
          statusCode: 400,
        );
      }

      final shift = shiftInfo['shift']!;
      final today = DateTime.now().toIso8601String().split('T')[0];

      // Check if already attended today
      final alreadyAttended =
          await checkTodayAttendance(employeeId, shift, today);
      if (alreadyAttended) {
        return Response.json(
          body: {
            'error': 'Anda sudah presensi untuk tanggal $today',
            'redirect_delay': 5,
          },
          statusCode: 400,
        );
      }

      // Save photo
      final fileName =
          await saveAttendancePhoto(imageBase64!, today, shift, employeeId);

      // Check if in temporary attendance (for check-out)
      final tempAttendance = await getTemporaryAttendance(employeeId);

      if (tempAttendance == null) {
        // Process check-in
        await processCheckIn(employeeId, shift, jamMasuk, fileName);
        return Response.json(
          body: {
            'message': 'Presensi Masuk berhasil',
            'type': 'check_in',
            'jam_masuk': jamMasuk,
            'redirect_delay': 3,
          },
        );
      } else {
        // Process check-out
        await processCheckOut(employeeId, shift, fileName);
        return Response.json(
          body: {
            'message': 'Presensi Pulang berhasil',
            'type': 'check_out',
            'redirect_delay': 3,
          },
        );
      }
    } catch (e) {
      return Response.json(
        body: {'error': 'Terjadi kesalahan sistem: ${e.toString()}'},
        statusCode: 500,
      );
    }
  }

  /// Get available shift times for dropdown
  static Future<Response> getAvailableShifts() async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute(
        'SELECT jam_masuk FROM jam_jaga GROUP BY jam_masuk ORDER BY jam_masuk',
      );

      final shifts = <String>[];
      for (final row in results.rows) {
        final jamMasuk = row.colAt(0);
        if (jamMasuk != null) {
          shifts.add(jamMasuk.toString());
        }
      }

      return Response.json(body: {'shifts': shifts});
    } catch (e) {
      return Response.json(
        body: {'error': 'Gagal mengambil data shift: ${e.toString()}'},
        statusCode: 500,
      );
    }
  }

  /// Get attendance history for employee
  static Future<Response> getAttendanceHistory(String employeeId,
      {int limit = 20}) async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute(
        '''SELECT id, shift, jam_datang, jam_pulang, status, keterlambatan, durasi, photo 
           FROM rekap_presensi 
           WHERE id = ? 
           ORDER BY jam_datang DESC 
           LIMIT ?''',
        {'employeeId': employeeId, 'limit': limit},
      );

      final history = <Map<String, dynamic>>[];
      for (final row in results.rows) {
        history.add({
          'id': row.colAt(0)?.toString(),
          'shift': row.colAt(1)?.toString(),
          'jam_datang': row.colAt(2)?.toString(),
          'jam_pulang': row.colAt(3)?.toString(),
          'status': row.colAt(4)?.toString(),
          'keterlambatan': row.colAt(5)?.toString(),
          'durasi': row.colAt(6)?.toString(),
          'photo': row.colAt(7)?.toString(),
        });
      }

      return Response.json(body: {'history': history});
    } catch (e) {
      return Response.json(
        body: {'error': 'Gagal mengambil riwayat: ${e.toString()}'},
        statusCode: 500,
      );
    }
  }

  // ===== VALIDATION FUNCTIONS =====

  /// Validate input parameters
  static String? _validateInput(
      String? jamMasuk, String? barcode, String? image) {
    if (jamMasuk == null || jamMasuk.isEmpty) {
      return 'Jam masuk harus dipilih';
    }
    if (barcode == null || barcode.isEmpty) {
      return 'Nomor kartu harus diisi';
    }
    if (image == null || image.isEmpty) {
      return 'Pilih shift dulu !!!!!!!';
    }
    return null;
  }

  // ===== DATABASE QUERY FUNCTIONS =====

  /// Get employee ID from barcode
  static Future<String?> getEmployeeIdFromBarcode(String barcode) async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute(
        'SELECT id FROM barcode WHERE barcode = ?',
        {'barcode': barcode},
      );

      if (results.rows.isEmpty) return null;
      return results.rows.first.colAt(0)?.toString();
    } catch (e) {
      return null;
    }
  }

  /// Get shift information for employee and time
  static Future<Map<String, String>?> getShiftInfo(
      String jamMasuk, String employeeId) async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute(
        '''SELECT jam_jaga.shift, CURRENT_DATE() as hariini, pegawai.departemen 
           FROM jam_jaga 
           INNER JOIN pegawai ON pegawai.departemen = jam_jaga.dep_id 
           WHERE jam_jaga.jam_masuk = ? AND pegawai.id = ?''',
        {'jamMasuk': jamMasuk, 'employeeId': employeeId},
      );

      if (results.rows.isEmpty) return null;

      final row = results.rows.first;
      return {
        'shift': row.colAt(0)?.toString() ?? '',
        'hariini': row.colAt(1)?.toString() ?? '',
        'departemen': row.colAt(2)?.toString() ?? '',
      };
    } catch (e) {
      return null;
    }
  }

  /// Check if employee already attended today
  static Future<bool> checkTodayAttendance(
      String employeeId, String shift, String today) async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute(
        'SELECT id FROM rekap_presensi WHERE id = ? AND shift = ? AND jam_datang LIKE ?',
        {'employeeId': employeeId, 'shift': shift, 'datePattern': '$today%'},
      );

      return results.rows.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get tardiness settings
  static Future<Map<String, int>> getTardinessSettings() async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute('SELECT * FROM set_keterlambatan');

      if (results.rows.isEmpty) {
        return {'toleransi': 15, 'terlambat1': 30, 'terlambat2': 60};
      }

      final row = results.rows.first;
      return {
        'toleransi': int.tryParse(row.colAt(0)?.toString() ?? '15') ?? 15,
        'terlambat1': int.tryParse(row.colAt(1)?.toString() ?? '30') ?? 30,
        'terlambat2': int.tryParse(row.colAt(2)?.toString() ?? '60') ?? 60,
      };
    } catch (e) {
      return {'toleransi': 15, 'terlambat1': 30, 'terlambat2': 60};
    }
  }

  /// Get temporary attendance record
  static Future<Map<String, String>?> getTemporaryAttendance(
      String employeeId) async {
    try {
      final pool = await DbPool.ensureReady();
      final results = await pool.execute(
        'SELECT id, shift, jam_datang, jam_pulang, status, keterlambatan, durasi, photo FROM temporary_presensi WHERE id = ?',
        {'employeeId': employeeId},
      );

      if (results.rows.isEmpty) return null;

      final row = results.rows.first;
      return {
        'id': row.colAt(0)?.toString() ?? '',
        'shift': row.colAt(1)?.toString() ?? '',
        'jam_datang': row.colAt(2)?.toString() ?? '',
        'jam_pulang': row.colAt(3)?.toString() ?? '',
        'status': row.colAt(4)?.toString() ?? '',
        'keterlambatan': row.colAt(5)?.toString() ?? '',
        'durasi': row.colAt(6)?.toString() ?? '',
        'photo': row.colAt(7)?.toString() ?? '',
      };
    } catch (e) {
      return null;
    }
  }

  // ===== FILE HANDLING FUNCTIONS =====

  /// Save attendance photo from base64
  static Future<String> saveAttendancePhoto(
      String imageBase64, String today, String shift, String employeeId) async {
    final fileName = '$today$shift$employeeId.jpeg';
    final filePath = 'uploads/presensi/$fileName';

    try {
      // Parse base64 image
      final imageParts = imageBase64.split(';base64,');
      if (imageParts.length != 2) {
        throw Exception('Invalid image format');
      }

      final imageBytes = base64Decode(imageParts[1]);
      final file = File(filePath);

      // Create directory if not exists
      await file.parent.create(recursive: true);

      // Delete existing file if exists
      if (await file.exists()) {
        await file.delete();
      }

      // Save new file
      await file.writeAsBytes(imageBytes);

      return fileName;
    } catch (e) {
      throw Exception('Gagal menyimpan foto: ${e.toString()}');
    }
  }

  // ===== ATTENDANCE PROCESSING FUNCTIONS =====

  /// Process check-in attendance
  static Future<void> processCheckIn(
      String employeeId, String shift, String jamMasuk, String fileName) async {
    final pool = await DbPool.ensureReady();
    final settings = await getTardinessSettings();

    // Calculate status and lateness
    final status = await _calculateAttendanceStatus(jamMasuk, settings);
    final keterlambatan = await _calculateLateness(jamMasuk, settings);

    await pool.execute(
      '''INSERT INTO temporary_presensi (id, shift, jam_datang, jam_pulang, status, keterlambatan, durasi, photo)
         VALUES (?, ?, NOW(), NULL, ?, ?, '', ?)''',
      {
        'id': employeeId,
        'shift': shift,
        'status': status,
        'keterlambatan': keterlambatan,
        'photo': fileName,
      },
    );
  }

  /// Calculate attendance status based on arrival time
  static Future<String> _calculateAttendanceStatus(
      String jamMasuk, Map<String, int> settings) async {
    try {
      final now = DateTime.now();
      final expectedTime =
          DateTime.parse('${now.toIso8601String().split('T')[0]} $jamMasuk:00');
      final diffMinutes = now.difference(expectedTime).inMinutes;

      final toleransi = settings['toleransi']!;
      final terlambat1 = settings['terlambat1']!;
      final terlambat2 = settings['terlambat2']!;

      if (diffMinutes <= toleransi) {
        return 'Tepat Waktu';
      } else if (diffMinutes <= terlambat1) {
        return 'Terlambat Toleransi';
      } else if (diffMinutes <= terlambat2) {
        return 'Terlambat I';
      } else {
        return 'Terlambat II';
      }
    } catch (e) {
      return 'Tepat Waktu';
    }
  }

  /// Calculate lateness duration
  static Future<String> _calculateLateness(
      String jamMasuk, Map<String, int> settings) async {
    try {
      final now = DateTime.now();
      final expectedTime =
          DateTime.parse('${now.toIso8601String().split('T')[0]} $jamMasuk:00');
      final diffMinutes = now.difference(expectedTime).inMinutes;

      final toleransi = settings['toleransi']!;

      if (diffMinutes > toleransi) {
        final hours = diffMinutes ~/ 60;
        final minutes = diffMinutes % 60;
        return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  /// Process check-out attendance
  static Future<void> processCheckOut(
      String employeeId, String shift, String fileName) async {
    final pool = await DbPool.ensureReady();

    // Get shift end time
    await pool.execute(
      '''SELECT jam_jaga.jam_pulang 
         FROM jam_jaga 
         INNER JOIN pegawai ON pegawai.departemen = jam_jaga.dep_id 
         WHERE jam_jaga.shift = ? AND pegawai.id = ?''',
      {'shift': shift, 'employeeId': employeeId},
    );

    // Update temporary attendance - simplified status calculation
    final tempAttendance = await getTemporaryAttendance(employeeId);
    if (tempAttendance != null) {
      final currentStatus = tempAttendance['status'] ?? 'Tepat Waktu';

      // Check if leaving early (simplified PSW check)
      final now = DateTime.now();
      final currentHour = now.hour;
      String finalStatus = currentStatus;

      // Simple PSW check - if leaving before 2 PM, add PSW
      if (currentHour < 14) {
        finalStatus += ' & PSW';
      }

      await pool.execute(
        '''UPDATE temporary_presensi 
           SET 
             jam_pulang = NOW(),
             status = ?,
             durasi = TIME_FORMAT(TIMEDIFF(NOW(), jam_datang), '%H:%i:%s')
           WHERE id = ?''',
        {'status': finalStatus, 'employeeId': employeeId},
      );
    }

    // Transfer to final attendance record
    await transferToFinalAttendance(employeeId);
  }

  /// Transfer from temporary to final attendance record
  static Future<void> transferToFinalAttendance(String employeeId) async {
    final pool = await DbPool.ensureReady();

    // Get updated temporary record
    final tempRecord = await getTemporaryAttendance(employeeId);
    if (tempRecord != null) {
      // Insert into final attendance
      await pool.execute(
        '''INSERT INTO rekap_presensi (id, shift, jam_datang, jam_pulang, status, keterlambatan, durasi, keterangan, photo)
           VALUES (?, ?, ?, ?, ?, ?, ?, '', ?)''',
        {
          'id': tempRecord['id'],
          'shift': tempRecord['shift'],
          'jam_datang': tempRecord['jam_datang'],
          'jam_pulang': tempRecord['jam_pulang'],
          'status': tempRecord['status'],
          'keterlambatan': tempRecord['keterlambatan'],
          'durasi': tempRecord['durasi'],
          'photo': tempRecord['photo'],
        },
      );

      // Delete from temporary
      await pool.execute(
        'DELETE FROM temporary_presensi WHERE id = ?',
        {'employeeId': employeeId},
      );
    }
  }
}
