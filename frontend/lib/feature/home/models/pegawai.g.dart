// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pegawai.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PegawaiResponseImpl _$$PegawaiResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PegawaiResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  data: PegawaiData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PegawaiResponseImplToJson(
  _$PegawaiResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_$PegawaiDataImpl _$$PegawaiDataImplFromJson(Map<String, dynamic> json) =>
    _$PegawaiDataImpl(
      userId: (json['user_id'] as num).toInt(),
      namaPegawai: json['nama_pegawai'] as String,
      departemen: json['departemen'] as String,
      shifts: (json['shifts'] as List<dynamic>)
          .map((e) => ShiftKerja.fromJson(e as Map<String, dynamic>))
          .toList(),
      sudahAbsensi: json['sudah_absensi'] as bool,
      presensiAktif: json['presensi_aktif'] == null
          ? null
          : PresensiAktif.fromJson(
              json['presensi_aktif'] as Map<String, dynamic>,
            ),
      endpoint: json['endpoint'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$PegawaiDataImplToJson(_$PegawaiDataImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'nama_pegawai': instance.namaPegawai,
      'departemen': instance.departemen,
      'shifts': instance.shifts,
      'sudah_absensi': instance.sudahAbsensi,
      'presensi_aktif': instance.presensiAktif,
      'endpoint': instance.endpoint,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$ShiftKerjaImpl _$$ShiftKerjaImplFromJson(Map<String, dynamic> json) =>
    _$ShiftKerjaImpl(
      shift: json['shift'] as String,
      jamMasuk: json['jam_masuk'] as String,
      jamPulang: json['jam_pulang'] as String,
    );

Map<String, dynamic> _$$ShiftKerjaImplToJson(_$ShiftKerjaImpl instance) =>
    <String, dynamic>{
      'shift': instance.shift,
      'jam_masuk': instance.jamMasuk,
      'jam_pulang': instance.jamPulang,
    };

_$PresensiAktifImpl _$$PresensiAktifImplFromJson(Map<String, dynamic> json) =>
    _$PresensiAktifImpl(
      jamDatang: json['jam_datang'] as String,
      jamPulang: json['jam_pulang'] as String,
      shift: json['shift'] as String,
      status: json['status'] as String,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$PresensiAktifImplToJson(_$PresensiAktifImpl instance) =>
    <String, dynamic>{
      'jam_datang': instance.jamDatang,
      'jam_pulang': instance.jamPulang,
      'shift': instance.shift,
      'status': instance.status,
      'source': instance.source,
    };
