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
    required String shift,
    required String status,
  }) = _PresensiAktif;

  factory PresensiAktif.fromJson(Map<String, dynamic> json) =>
      _$PresensiAktifFromJson(json);
}
