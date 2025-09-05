import 'package:hospital_attendance_system/database/db_pool.dart';

/// Service untuk mengelola data pegawai
class PegawaiService {
  /// Mengambil data basic pegawai (nama dan departemen) berdasarkan ID
  static Future<Map<String, dynamic>?> getPegawaiBasic(int id) async {
    try {
      final pool = await DbPool.ensureReady();

      final result = await pool.execute(
        '''
        SELECT nama, departemen
        FROM pegawai
        WHERE id = :id
        ''',
        {'id': id},
      );

      if (result.rows.isEmpty) {
        return null;
      }

      final row = result.rows.first;
      return {
        'nama': row.colByName('nama')?.toString(),
        'departemen': row.colByName('departemen')?.toString(),
      };
    } catch (e) {
      throw Exception('Gagal mengambil data basic pegawai: $e');
    }
  }

  /// Mengambil data shift kerja berdasarkan departemen
  static Future<List<Map<String, dynamic>>> getShiftsByDepartemen(
    String departemen,
  ) async {
    try {
      final pool = await DbPool.ensureReady();

      final result = await pool.execute(
        '''
        SELECT shift, jam_masuk, jam_pulang
        FROM jam_jaga
        WHERE dep_id = :departemen
        ''',
        {'departemen': departemen},
      );

      final shifts = <Map<String, dynamic>>[];
      for (final row in result.rows) {
        final shift = row.colByName('shift')?.toString();
        final jamMasuk = row.colByName('jam_masuk')?.toString();
        final jamPulang = row.colByName('jam_pulang')?.toString();

        if (shift != null && jamMasuk != null && jamPulang != null) {
          shifts.add({
            'shift': shift,
            'jam_masuk': jamMasuk,
            'jam_pulang': jamPulang,
          });
        }
      }

      return shifts;
    } catch (e) {
      throw Exception('Gagal mengambil data shift: $e');
    }
  }

  /// Mengambil data presensi aktif pegawai
  static Future<Map<String, dynamic>?> getPresensiAktif(int pegawaiId) async {
    try {
      final pool = await DbPool.ensureReady();

      final result = await pool.execute(
        '''
        SELECT jam_datang, shift, status
        FROM temporary_presensi
        WHERE id = :id
          AND (
            (shift LIKE '%Malam%' AND DATE(jam_datang) = CURDATE() - 1) OR
            (shift NOT LIKE '%Malam%' AND DATE(jam_datang) = CURDATE())
          )
        ''',
        {'id': pegawaiId},
      );

      if (result.rows.isNotEmpty) {
        final row = result.rows.first;
        return {
          'jam_datang': row.colByName('jam_datang')?.toString(),
          'shift': row.colByName('shift')?.toString(),
          'status': row.colByName('status')?.toString(),
        };
      }

      return null;
    } catch (e) {
      throw Exception('Gagal mengambil data presensi aktif: $e');
    }
  }

  /// Mengambil data lengkap pegawai dengan shift dan presensi
  static Future<Map<String, dynamic>?> getPegawaiDataById(int id) async {
    try {
      // 1. Ambil data basic pegawai
      final pegawaiBasic = await getPegawaiBasic(id);
      if (pegawaiBasic == null) {
        return null;
      }

      // 2. Ambil data shift berdasarkan departemen
      final departemen = pegawaiBasic['departemen'] as String?;
      final shifts = departemen != null
          ? await getShiftsByDepartemen(departemen)
          : <Map<String, dynamic>>[];

      // 3. Ambil data presensi aktif
      final presensiAktif = await getPresensiAktif(id);

      // 4. Combine semua data
      return {
        'nama': pegawaiBasic['nama'],
        'departemen': pegawaiBasic['departemen'],
        'shifts': shifts,
        'sudah_absensi': presensiAktif != null,
        'presensi_aktif': presensiAktif,
      };
    } catch (e) {
      throw Exception('Gagal mengambil data lengkap pegawai: $e');
    }
  }

  // /// Mengambil shift spesifik berdasarkan pegawai ID dan jam masuk (untuk validasi presensi)
  // static Future<Map<String, dynamic>?> getShiftByPegawaiAndJamMasuk(
  //   int pegawaiId,
  //   String jamMasuk,
  // ) async {
  //   try {
  //     final pool = await DbPool.ensureReady();

  //     final result = await pool.execute(
  //       '''
  //       SELECT shift, jam_masuk, jam_pulang, dep_id
  //       FROM jam_jaga
  //       WHERE jam_masuk = :jam_masuk
  //         AND dep_id = (SELECT departemen FROM pegawai WHERE id = :pegawai_id)
  //       ''',
  //       {
  //         'jam_masuk': jamMasuk,
  //         'pegawai_id': pegawaiId,
  //       },
  //     );

  //     if (result.rows.isNotEmpty) {
  //       final row = result.rows.first;
  //       return {
  //         'shift': row.colByName('shift')?.toString(),
  //         'jam_masuk': row.colByName('jam_masuk')?.toString(),
  //         'jam_pulang': row.colByName('jam_pulang')?.toString(),
  //         'dep_id': row.colByName('dep_id'),
  //       };
  //     }

  //     return null;
  //   } catch (e) {
  //     throw Exception('Gagal mengambil data shift validasi: $e');
  //   }
  // }
}
