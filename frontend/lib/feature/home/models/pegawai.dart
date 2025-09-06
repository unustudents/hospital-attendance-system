// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pegawai.freezed.dart';
part 'pegawai.g.dart';

@freezed
class PegawaiResponse with _$PegawaiResponse {
  const factory PegawaiResponse({
    required bool success,
    required String message,
    required PegawaiData data,
  }) = _PegawaiResponse;

  factory PegawaiResponse.fromJson(Map<String, dynamic> json) =>
      _$PegawaiResponseFromJson(json);
}

@freezed
class PegawaiData with _$PegawaiData {
  const factory PegawaiData({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'nama_pegawai') required String namaPegawai,
    required String departemen,
    required List<ShiftKerja> shifts,
    @JsonKey(name: 'sudah_absensi') required bool sudahAbsensi,
    @JsonKey(name: 'presensi_aktif') PresensiAktif? presensiAktif,
    required String endpoint,
    required DateTime timestamp,
  }) = _PegawaiData;

  factory PegawaiData.fromJson(Map<String, dynamic> json) =>
      _$PegawaiDataFromJson(json);
}

@freezed
class ShiftKerja with _$ShiftKerja {
  const factory ShiftKerja({
    required String shift,
    @JsonKey(name: 'jam_masuk') required String jamMasuk,
    @JsonKey(name: 'jam_pulang') required String jamPulang,
  }) = _ShiftKerja;

  factory ShiftKerja.fromJson(Map<String, dynamic> json) =>
      _$ShiftKerjaFromJson(json);
}

@freezed
class PresensiAktif with _$PresensiAktif {
  const factory PresensiAktif({
    @JsonKey(name: 'jam_datang') required String jamDatang,
    @JsonKey(name: 'jam_pulang') required String jamPulang,
    required String shift,
    required String status,
    String? source, // Field baru sesuai dengan response
  }) = _PresensiAktif;

  factory PresensiAktif.fromJson(Map<String, dynamic> json) =>
      _$PresensiAktifFromJson(json);
}

/// Extension untuk memformat waktu dari string datetime ke HH:mm
extension PresensiAktifExtension on PresensiAktif {
  /// Format jam datang menjadi HH:mm (contoh: "20:08")
  String get jamDatangFormatted {
    return _formatTimeString(jamDatang);
  }

  /// Format jam pulang menjadi HH:mm (contoh: "14:44")
  /// Return "-" jika jam pulang kosong atau null
  String get jamPulangFormatted {
    if (jamPulang.isEmpty || jamPulang == 'null') return '-';
    return _formatTimeString(jamPulang);
  }

  /// Helper function untuk memformat string datetime menjadi HH:mm
  String _formatTimeString(String dateTimeString) {
    try {
      // Format: "2025-09-06 20:08:49" -> "20:08"
      if (dateTimeString.contains(' ')) {
        final timePart = dateTimeString.split(' ')[1]; // "20:08:49"
        final timeComponents = timePart.split(':');
        if (timeComponents.length >= 2) {
          return '${timeComponents[0]}:${timeComponents[1]}'; // "20:08"
        }
      }

      // Fallback: coba parse sebagai DateTime
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      // Jika parsing gagal, return string asli atau bagian waktu saja
      return dateTimeString.length > 8
          ? dateTimeString.substring(0, 8)
          : dateTimeString;
    }
  }
}
