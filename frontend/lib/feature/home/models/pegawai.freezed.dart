// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pegawai.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PegawaiResponse _$PegawaiResponseFromJson(Map<String, dynamic> json) {
  return _PegawaiResponse.fromJson(json);
}

/// @nodoc
mixin _$PegawaiResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  PegawaiData get data => throw _privateConstructorUsedError;

  /// Serializes this PegawaiResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PegawaiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PegawaiResponseCopyWith<PegawaiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PegawaiResponseCopyWith<$Res> {
  factory $PegawaiResponseCopyWith(
    PegawaiResponse value,
    $Res Function(PegawaiResponse) then,
  ) = _$PegawaiResponseCopyWithImpl<$Res, PegawaiResponse>;
  @useResult
  $Res call({bool success, String message, PegawaiData data});

  $PegawaiDataCopyWith<$Res> get data;
}

/// @nodoc
class _$PegawaiResponseCopyWithImpl<$Res, $Val extends PegawaiResponse>
    implements $PegawaiResponseCopyWith<$Res> {
  _$PegawaiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PegawaiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as PegawaiData,
          )
          as $Val,
    );
  }

  /// Create a copy of PegawaiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PegawaiDataCopyWith<$Res> get data {
    return $PegawaiDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PegawaiResponseImplCopyWith<$Res>
    implements $PegawaiResponseCopyWith<$Res> {
  factory _$$PegawaiResponseImplCopyWith(
    _$PegawaiResponseImpl value,
    $Res Function(_$PegawaiResponseImpl) then,
  ) = __$$PegawaiResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, PegawaiData data});

  @override
  $PegawaiDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$PegawaiResponseImplCopyWithImpl<$Res>
    extends _$PegawaiResponseCopyWithImpl<$Res, _$PegawaiResponseImpl>
    implements _$$PegawaiResponseImplCopyWith<$Res> {
  __$$PegawaiResponseImplCopyWithImpl(
    _$PegawaiResponseImpl _value,
    $Res Function(_$PegawaiResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PegawaiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$PegawaiResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as PegawaiData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PegawaiResponseImpl implements _PegawaiResponse {
  const _$PegawaiResponseImpl({
    required this.success,
    required this.message,
    required this.data,
  });

  factory _$PegawaiResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PegawaiResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final PegawaiData data;

  @override
  String toString() {
    return 'PegawaiResponse(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PegawaiResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  /// Create a copy of PegawaiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PegawaiResponseImplCopyWith<_$PegawaiResponseImpl> get copyWith =>
      __$$PegawaiResponseImplCopyWithImpl<_$PegawaiResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PegawaiResponseImplToJson(this);
  }
}

abstract class _PegawaiResponse implements PegawaiResponse {
  const factory _PegawaiResponse({
    required final bool success,
    required final String message,
    required final PegawaiData data,
  }) = _$PegawaiResponseImpl;

  factory _PegawaiResponse.fromJson(Map<String, dynamic> json) =
      _$PegawaiResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  PegawaiData get data;

  /// Create a copy of PegawaiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PegawaiResponseImplCopyWith<_$PegawaiResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PegawaiData _$PegawaiDataFromJson(Map<String, dynamic> json) {
  return _PegawaiData.fromJson(json);
}

/// @nodoc
mixin _$PegawaiData {
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'nama_pegawai')
  String get namaPegawai => throw _privateConstructorUsedError;
  String get departemen => throw _privateConstructorUsedError;
  List<ShiftKerja> get shifts => throw _privateConstructorUsedError;
  @JsonKey(name: 'sudah_absensi')
  bool get sudahAbsensi => throw _privateConstructorUsedError;
  @JsonKey(name: 'presensi_aktif')
  PresensiAktif? get presensiAktif => throw _privateConstructorUsedError;
  String get endpoint => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this PegawaiData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PegawaiData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PegawaiDataCopyWith<PegawaiData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PegawaiDataCopyWith<$Res> {
  factory $PegawaiDataCopyWith(
    PegawaiData value,
    $Res Function(PegawaiData) then,
  ) = _$PegawaiDataCopyWithImpl<$Res, PegawaiData>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'nama_pegawai') String namaPegawai,
    String departemen,
    List<ShiftKerja> shifts,
    @JsonKey(name: 'sudah_absensi') bool sudahAbsensi,
    @JsonKey(name: 'presensi_aktif') PresensiAktif? presensiAktif,
    String endpoint,
    DateTime timestamp,
  });

  $PresensiAktifCopyWith<$Res>? get presensiAktif;
}

/// @nodoc
class _$PegawaiDataCopyWithImpl<$Res, $Val extends PegawaiData>
    implements $PegawaiDataCopyWith<$Res> {
  _$PegawaiDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PegawaiData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? namaPegawai = null,
    Object? departemen = null,
    Object? shifts = null,
    Object? sudahAbsensi = null,
    Object? presensiAktif = freezed,
    Object? endpoint = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            namaPegawai: null == namaPegawai
                ? _value.namaPegawai
                : namaPegawai // ignore: cast_nullable_to_non_nullable
                      as String,
            departemen: null == departemen
                ? _value.departemen
                : departemen // ignore: cast_nullable_to_non_nullable
                      as String,
            shifts: null == shifts
                ? _value.shifts
                : shifts // ignore: cast_nullable_to_non_nullable
                      as List<ShiftKerja>,
            sudahAbsensi: null == sudahAbsensi
                ? _value.sudahAbsensi
                : sudahAbsensi // ignore: cast_nullable_to_non_nullable
                      as bool,
            presensiAktif: freezed == presensiAktif
                ? _value.presensiAktif
                : presensiAktif // ignore: cast_nullable_to_non_nullable
                      as PresensiAktif?,
            endpoint: null == endpoint
                ? _value.endpoint
                : endpoint // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of PegawaiData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresensiAktifCopyWith<$Res>? get presensiAktif {
    if (_value.presensiAktif == null) {
      return null;
    }

    return $PresensiAktifCopyWith<$Res>(_value.presensiAktif!, (value) {
      return _then(_value.copyWith(presensiAktif: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PegawaiDataImplCopyWith<$Res>
    implements $PegawaiDataCopyWith<$Res> {
  factory _$$PegawaiDataImplCopyWith(
    _$PegawaiDataImpl value,
    $Res Function(_$PegawaiDataImpl) then,
  ) = __$$PegawaiDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'nama_pegawai') String namaPegawai,
    String departemen,
    List<ShiftKerja> shifts,
    @JsonKey(name: 'sudah_absensi') bool sudahAbsensi,
    @JsonKey(name: 'presensi_aktif') PresensiAktif? presensiAktif,
    String endpoint,
    DateTime timestamp,
  });

  @override
  $PresensiAktifCopyWith<$Res>? get presensiAktif;
}

/// @nodoc
class __$$PegawaiDataImplCopyWithImpl<$Res>
    extends _$PegawaiDataCopyWithImpl<$Res, _$PegawaiDataImpl>
    implements _$$PegawaiDataImplCopyWith<$Res> {
  __$$PegawaiDataImplCopyWithImpl(
    _$PegawaiDataImpl _value,
    $Res Function(_$PegawaiDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PegawaiData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? namaPegawai = null,
    Object? departemen = null,
    Object? shifts = null,
    Object? sudahAbsensi = null,
    Object? presensiAktif = freezed,
    Object? endpoint = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$PegawaiDataImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        namaPegawai: null == namaPegawai
            ? _value.namaPegawai
            : namaPegawai // ignore: cast_nullable_to_non_nullable
                  as String,
        departemen: null == departemen
            ? _value.departemen
            : departemen // ignore: cast_nullable_to_non_nullable
                  as String,
        shifts: null == shifts
            ? _value._shifts
            : shifts // ignore: cast_nullable_to_non_nullable
                  as List<ShiftKerja>,
        sudahAbsensi: null == sudahAbsensi
            ? _value.sudahAbsensi
            : sudahAbsensi // ignore: cast_nullable_to_non_nullable
                  as bool,
        presensiAktif: freezed == presensiAktif
            ? _value.presensiAktif
            : presensiAktif // ignore: cast_nullable_to_non_nullable
                  as PresensiAktif?,
        endpoint: null == endpoint
            ? _value.endpoint
            : endpoint // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PegawaiDataImpl implements _PegawaiData {
  const _$PegawaiDataImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'nama_pegawai') required this.namaPegawai,
    required this.departemen,
    required final List<ShiftKerja> shifts,
    @JsonKey(name: 'sudah_absensi') required this.sudahAbsensi,
    @JsonKey(name: 'presensi_aktif') this.presensiAktif,
    required this.endpoint,
    required this.timestamp,
  }) : _shifts = shifts;

  factory _$PegawaiDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PegawaiDataImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'nama_pegawai')
  final String namaPegawai;
  @override
  final String departemen;
  final List<ShiftKerja> _shifts;
  @override
  List<ShiftKerja> get shifts {
    if (_shifts is EqualUnmodifiableListView) return _shifts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shifts);
  }

  @override
  @JsonKey(name: 'sudah_absensi')
  final bool sudahAbsensi;
  @override
  @JsonKey(name: 'presensi_aktif')
  final PresensiAktif? presensiAktif;
  @override
  final String endpoint;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'PegawaiData(userId: $userId, namaPegawai: $namaPegawai, departemen: $departemen, shifts: $shifts, sudahAbsensi: $sudahAbsensi, presensiAktif: $presensiAktif, endpoint: $endpoint, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PegawaiDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.namaPegawai, namaPegawai) ||
                other.namaPegawai == namaPegawai) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            const DeepCollectionEquality().equals(other._shifts, _shifts) &&
            (identical(other.sudahAbsensi, sudahAbsensi) ||
                other.sudahAbsensi == sudahAbsensi) &&
            (identical(other.presensiAktif, presensiAktif) ||
                other.presensiAktif == presensiAktif) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    namaPegawai,
    departemen,
    const DeepCollectionEquality().hash(_shifts),
    sudahAbsensi,
    presensiAktif,
    endpoint,
    timestamp,
  );

  /// Create a copy of PegawaiData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PegawaiDataImplCopyWith<_$PegawaiDataImpl> get copyWith =>
      __$$PegawaiDataImplCopyWithImpl<_$PegawaiDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PegawaiDataImplToJson(this);
  }
}

abstract class _PegawaiData implements PegawaiData {
  const factory _PegawaiData({
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'nama_pegawai') required final String namaPegawai,
    required final String departemen,
    required final List<ShiftKerja> shifts,
    @JsonKey(name: 'sudah_absensi') required final bool sudahAbsensi,
    @JsonKey(name: 'presensi_aktif') final PresensiAktif? presensiAktif,
    required final String endpoint,
    required final DateTime timestamp,
  }) = _$PegawaiDataImpl;

  factory _PegawaiData.fromJson(Map<String, dynamic> json) =
      _$PegawaiDataImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'nama_pegawai')
  String get namaPegawai;
  @override
  String get departemen;
  @override
  List<ShiftKerja> get shifts;
  @override
  @JsonKey(name: 'sudah_absensi')
  bool get sudahAbsensi;
  @override
  @JsonKey(name: 'presensi_aktif')
  PresensiAktif? get presensiAktif;
  @override
  String get endpoint;
  @override
  DateTime get timestamp;

  /// Create a copy of PegawaiData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PegawaiDataImplCopyWith<_$PegawaiDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftKerja _$ShiftKerjaFromJson(Map<String, dynamic> json) {
  return _ShiftKerja.fromJson(json);
}

/// @nodoc
mixin _$ShiftKerja {
  String get shift => throw _privateConstructorUsedError;
  @JsonKey(name: 'jam_masuk')
  String get jamMasuk => throw _privateConstructorUsedError;
  @JsonKey(name: 'jam_pulang')
  String get jamPulang => throw _privateConstructorUsedError;

  /// Serializes this ShiftKerja to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftKerja
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftKerjaCopyWith<ShiftKerja> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftKerjaCopyWith<$Res> {
  factory $ShiftKerjaCopyWith(
    ShiftKerja value,
    $Res Function(ShiftKerja) then,
  ) = _$ShiftKerjaCopyWithImpl<$Res, ShiftKerja>;
  @useResult
  $Res call({
    String shift,
    @JsonKey(name: 'jam_masuk') String jamMasuk,
    @JsonKey(name: 'jam_pulang') String jamPulang,
  });
}

/// @nodoc
class _$ShiftKerjaCopyWithImpl<$Res, $Val extends ShiftKerja>
    implements $ShiftKerjaCopyWith<$Res> {
  _$ShiftKerjaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftKerja
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shift = null,
    Object? jamMasuk = null,
    Object? jamPulang = null,
  }) {
    return _then(
      _value.copyWith(
            shift: null == shift
                ? _value.shift
                : shift // ignore: cast_nullable_to_non_nullable
                      as String,
            jamMasuk: null == jamMasuk
                ? _value.jamMasuk
                : jamMasuk // ignore: cast_nullable_to_non_nullable
                      as String,
            jamPulang: null == jamPulang
                ? _value.jamPulang
                : jamPulang // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShiftKerjaImplCopyWith<$Res>
    implements $ShiftKerjaCopyWith<$Res> {
  factory _$$ShiftKerjaImplCopyWith(
    _$ShiftKerjaImpl value,
    $Res Function(_$ShiftKerjaImpl) then,
  ) = __$$ShiftKerjaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String shift,
    @JsonKey(name: 'jam_masuk') String jamMasuk,
    @JsonKey(name: 'jam_pulang') String jamPulang,
  });
}

/// @nodoc
class __$$ShiftKerjaImplCopyWithImpl<$Res>
    extends _$ShiftKerjaCopyWithImpl<$Res, _$ShiftKerjaImpl>
    implements _$$ShiftKerjaImplCopyWith<$Res> {
  __$$ShiftKerjaImplCopyWithImpl(
    _$ShiftKerjaImpl _value,
    $Res Function(_$ShiftKerjaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShiftKerja
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shift = null,
    Object? jamMasuk = null,
    Object? jamPulang = null,
  }) {
    return _then(
      _$ShiftKerjaImpl(
        shift: null == shift
            ? _value.shift
            : shift // ignore: cast_nullable_to_non_nullable
                  as String,
        jamMasuk: null == jamMasuk
            ? _value.jamMasuk
            : jamMasuk // ignore: cast_nullable_to_non_nullable
                  as String,
        jamPulang: null == jamPulang
            ? _value.jamPulang
            : jamPulang // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftKerjaImpl implements _ShiftKerja {
  const _$ShiftKerjaImpl({
    required this.shift,
    @JsonKey(name: 'jam_masuk') required this.jamMasuk,
    @JsonKey(name: 'jam_pulang') required this.jamPulang,
  });

  factory _$ShiftKerjaImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftKerjaImplFromJson(json);

  @override
  final String shift;
  @override
  @JsonKey(name: 'jam_masuk')
  final String jamMasuk;
  @override
  @JsonKey(name: 'jam_pulang')
  final String jamPulang;

  @override
  String toString() {
    return 'ShiftKerja(shift: $shift, jamMasuk: $jamMasuk, jamPulang: $jamPulang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftKerjaImpl &&
            (identical(other.shift, shift) || other.shift == shift) &&
            (identical(other.jamMasuk, jamMasuk) ||
                other.jamMasuk == jamMasuk) &&
            (identical(other.jamPulang, jamPulang) ||
                other.jamPulang == jamPulang));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shift, jamMasuk, jamPulang);

  /// Create a copy of ShiftKerja
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftKerjaImplCopyWith<_$ShiftKerjaImpl> get copyWith =>
      __$$ShiftKerjaImplCopyWithImpl<_$ShiftKerjaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftKerjaImplToJson(this);
  }
}

abstract class _ShiftKerja implements ShiftKerja {
  const factory _ShiftKerja({
    required final String shift,
    @JsonKey(name: 'jam_masuk') required final String jamMasuk,
    @JsonKey(name: 'jam_pulang') required final String jamPulang,
  }) = _$ShiftKerjaImpl;

  factory _ShiftKerja.fromJson(Map<String, dynamic> json) =
      _$ShiftKerjaImpl.fromJson;

  @override
  String get shift;
  @override
  @JsonKey(name: 'jam_masuk')
  String get jamMasuk;
  @override
  @JsonKey(name: 'jam_pulang')
  String get jamPulang;

  /// Create a copy of ShiftKerja
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftKerjaImplCopyWith<_$ShiftKerjaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PresensiAktif _$PresensiAktifFromJson(Map<String, dynamic> json) {
  return _PresensiAktif.fromJson(json);
}

/// @nodoc
mixin _$PresensiAktif {
  @JsonKey(name: 'jam_datang')
  String get jamDatang => throw _privateConstructorUsedError;
  @JsonKey(name: 'jam_pulang')
  String get jamPulang => throw _privateConstructorUsedError;
  String get shift => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  /// Serializes this PresensiAktif to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresensiAktif
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresensiAktifCopyWith<PresensiAktif> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresensiAktifCopyWith<$Res> {
  factory $PresensiAktifCopyWith(
    PresensiAktif value,
    $Res Function(PresensiAktif) then,
  ) = _$PresensiAktifCopyWithImpl<$Res, PresensiAktif>;
  @useResult
  $Res call({
    @JsonKey(name: 'jam_datang') String jamDatang,
    @JsonKey(name: 'jam_pulang') String jamPulang,
    String shift,
    String status,
    String? source,
  });
}

/// @nodoc
class _$PresensiAktifCopyWithImpl<$Res, $Val extends PresensiAktif>
    implements $PresensiAktifCopyWith<$Res> {
  _$PresensiAktifCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresensiAktif
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jamDatang = null,
    Object? jamPulang = null,
    Object? shift = null,
    Object? status = null,
    Object? source = freezed,
  }) {
    return _then(
      _value.copyWith(
            jamDatang: null == jamDatang
                ? _value.jamDatang
                : jamDatang // ignore: cast_nullable_to_non_nullable
                      as String,
            jamPulang: null == jamPulang
                ? _value.jamPulang
                : jamPulang // ignore: cast_nullable_to_non_nullable
                      as String,
            shift: null == shift
                ? _value.shift
                : shift // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PresensiAktifImplCopyWith<$Res>
    implements $PresensiAktifCopyWith<$Res> {
  factory _$$PresensiAktifImplCopyWith(
    _$PresensiAktifImpl value,
    $Res Function(_$PresensiAktifImpl) then,
  ) = __$$PresensiAktifImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'jam_datang') String jamDatang,
    @JsonKey(name: 'jam_pulang') String jamPulang,
    String shift,
    String status,
    String? source,
  });
}

/// @nodoc
class __$$PresensiAktifImplCopyWithImpl<$Res>
    extends _$PresensiAktifCopyWithImpl<$Res, _$PresensiAktifImpl>
    implements _$$PresensiAktifImplCopyWith<$Res> {
  __$$PresensiAktifImplCopyWithImpl(
    _$PresensiAktifImpl _value,
    $Res Function(_$PresensiAktifImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PresensiAktif
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jamDatang = null,
    Object? jamPulang = null,
    Object? shift = null,
    Object? status = null,
    Object? source = freezed,
  }) {
    return _then(
      _$PresensiAktifImpl(
        jamDatang: null == jamDatang
            ? _value.jamDatang
            : jamDatang // ignore: cast_nullable_to_non_nullable
                  as String,
        jamPulang: null == jamPulang
            ? _value.jamPulang
            : jamPulang // ignore: cast_nullable_to_non_nullable
                  as String,
        shift: null == shift
            ? _value.shift
            : shift // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PresensiAktifImpl implements _PresensiAktif {
  const _$PresensiAktifImpl({
    @JsonKey(name: 'jam_datang') required this.jamDatang,
    @JsonKey(name: 'jam_pulang') required this.jamPulang,
    required this.shift,
    required this.status,
    this.source,
  });

  factory _$PresensiAktifImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresensiAktifImplFromJson(json);

  @override
  @JsonKey(name: 'jam_datang')
  final String jamDatang;
  @override
  @JsonKey(name: 'jam_pulang')
  final String jamPulang;
  @override
  final String shift;
  @override
  final String status;
  @override
  final String? source;

  @override
  String toString() {
    return 'PresensiAktif(jamDatang: $jamDatang, jamPulang: $jamPulang, shift: $shift, status: $status, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresensiAktifImpl &&
            (identical(other.jamDatang, jamDatang) ||
                other.jamDatang == jamDatang) &&
            (identical(other.jamPulang, jamPulang) ||
                other.jamPulang == jamPulang) &&
            (identical(other.shift, shift) || other.shift == shift) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, jamDatang, jamPulang, shift, status, source);

  /// Create a copy of PresensiAktif
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresensiAktifImplCopyWith<_$PresensiAktifImpl> get copyWith =>
      __$$PresensiAktifImplCopyWithImpl<_$PresensiAktifImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresensiAktifImplToJson(this);
  }
}

abstract class _PresensiAktif implements PresensiAktif {
  const factory _PresensiAktif({
    @JsonKey(name: 'jam_datang') required final String jamDatang,
    @JsonKey(name: 'jam_pulang') required final String jamPulang,
    required final String shift,
    required final String status,
    final String? source,
  }) = _$PresensiAktifImpl;

  factory _PresensiAktif.fromJson(Map<String, dynamic> json) =
      _$PresensiAktifImpl.fromJson;

  @override
  @JsonKey(name: 'jam_datang')
  String get jamDatang;
  @override
  @JsonKey(name: 'jam_pulang')
  String get jamPulang;
  @override
  String get shift;
  @override
  String get status;
  @override
  String? get source;

  /// Create a copy of PresensiAktif
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresensiAktifImplCopyWith<_$PresensiAktifImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
