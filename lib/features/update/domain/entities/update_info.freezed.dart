// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateInfo _$UpdateInfoFromJson(Map<String, dynamic> json) {
  return _UpdateInfo.fromJson(json);
}

/// @nodoc
mixin _$UpdateInfo {
  String get app => throw _privateConstructorUsedError;
  String get latest => throw _privateConstructorUsedError;
  int get build => throw _privateConstructorUsedError;
  @JsonKey(name: "min_version", defaultValue: null)
  String? get minVersion => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get sha256 => throw _privateConstructorUsedError;
  bool get force => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  List<String> get notes => throw _privateConstructorUsedError;
  @JsonKey(name: "multilingual_notes", defaultValue: {})
  Map<String, List<String>>? get multilingualNotes =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateInfoCopyWith<UpdateInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateInfoCopyWith<$Res> {
  factory $UpdateInfoCopyWith(
          UpdateInfo value, $Res Function(UpdateInfo) then) =
      _$UpdateInfoCopyWithImpl<$Res, UpdateInfo>;
  @useResult
  $Res call(
      {String app,
      String latest,
      int build,
      @JsonKey(name: "min_version", defaultValue: null) String? minVersion,
      String url,
      String sha256,
      bool force,
      String filename,
      List<String> notes,
      @JsonKey(name: "multilingual_notes", defaultValue: {})
      Map<String, List<String>>? multilingualNotes});
}

/// @nodoc
class _$UpdateInfoCopyWithImpl<$Res, $Val extends UpdateInfo>
    implements $UpdateInfoCopyWith<$Res> {
  _$UpdateInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
    Object? latest = null,
    Object? build = null,
    Object? minVersion = freezed,
    Object? url = null,
    Object? sha256 = null,
    Object? force = null,
    Object? filename = null,
    Object? notes = null,
    Object? multilingualNotes = freezed,
  }) {
    return _then(_value.copyWith(
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String,
      latest: null == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as String,
      build: null == build
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as int,
      minVersion: freezed == minVersion
          ? _value.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      sha256: null == sha256
          ? _value.sha256
          : sha256 // ignore: cast_nullable_to_non_nullable
              as String,
      force: null == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as bool,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      multilingualNotes: freezed == multilingualNotes
          ? _value.multilingualNotes
          : multilingualNotes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateInfoImplCopyWith<$Res>
    implements $UpdateInfoCopyWith<$Res> {
  factory _$$UpdateInfoImplCopyWith(
          _$UpdateInfoImpl value, $Res Function(_$UpdateInfoImpl) then) =
      __$$UpdateInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String app,
      String latest,
      int build,
      @JsonKey(name: "min_version", defaultValue: null) String? minVersion,
      String url,
      String sha256,
      bool force,
      String filename,
      List<String> notes,
      @JsonKey(name: "multilingual_notes", defaultValue: {})
      Map<String, List<String>>? multilingualNotes});
}

/// @nodoc
class __$$UpdateInfoImplCopyWithImpl<$Res>
    extends _$UpdateInfoCopyWithImpl<$Res, _$UpdateInfoImpl>
    implements _$$UpdateInfoImplCopyWith<$Res> {
  __$$UpdateInfoImplCopyWithImpl(
      _$UpdateInfoImpl _value, $Res Function(_$UpdateInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
    Object? latest = null,
    Object? build = null,
    Object? minVersion = freezed,
    Object? url = null,
    Object? sha256 = null,
    Object? force = null,
    Object? filename = null,
    Object? notes = null,
    Object? multilingualNotes = freezed,
  }) {
    return _then(_$UpdateInfoImpl(
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String,
      latest: null == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as String,
      build: null == build
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as int,
      minVersion: freezed == minVersion
          ? _value.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      sha256: null == sha256
          ? _value.sha256
          : sha256 // ignore: cast_nullable_to_non_nullable
              as String,
      force: null == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as bool,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      multilingualNotes: freezed == multilingualNotes
          ? _value._multilingualNotes
          : multilingualNotes // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateInfoImpl implements _UpdateInfo {
  const _$UpdateInfoImpl(
      {required this.app,
      required this.latest,
      required this.build,
      @JsonKey(name: "min_version", defaultValue: null) this.minVersion,
      required this.url,
      required this.sha256,
      required this.force,
      required this.filename,
      required final List<String> notes,
      @JsonKey(name: "multilingual_notes", defaultValue: {})
      final Map<String, List<String>>? multilingualNotes})
      : _notes = notes,
        _multilingualNotes = multilingualNotes;

  factory _$UpdateInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateInfoImplFromJson(json);

  @override
  final String app;
  @override
  final String latest;
  @override
  final int build;
  @override
  @JsonKey(name: "min_version", defaultValue: null)
  final String? minVersion;
  @override
  final String url;
  @override
  final String sha256;
  @override
  final bool force;
  @override
  final String filename;
  final List<String> _notes;
  @override
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  final Map<String, List<String>>? _multilingualNotes;
  @override
  @JsonKey(name: "multilingual_notes", defaultValue: {})
  Map<String, List<String>>? get multilingualNotes {
    final value = _multilingualNotes;
    if (value == null) return null;
    if (_multilingualNotes is EqualUnmodifiableMapView)
      return _multilingualNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UpdateInfo(app: $app, latest: $latest, build: $build, minVersion: $minVersion, url: $url, sha256: $sha256, force: $force, filename: $filename, notes: $notes, multilingualNotes: $multilingualNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateInfoImpl &&
            (identical(other.app, app) || other.app == app) &&
            (identical(other.latest, latest) || other.latest == latest) &&
            (identical(other.build, build) || other.build == build) &&
            (identical(other.minVersion, minVersion) ||
                other.minVersion == minVersion) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sha256, sha256) || other.sha256 == sha256) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            const DeepCollectionEquality()
                .equals(other._multilingualNotes, _multilingualNotes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      app,
      latest,
      build,
      minVersion,
      url,
      sha256,
      force,
      filename,
      const DeepCollectionEquality().hash(_notes),
      const DeepCollectionEquality().hash(_multilingualNotes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateInfoImplCopyWith<_$UpdateInfoImpl> get copyWith =>
      __$$UpdateInfoImplCopyWithImpl<_$UpdateInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateInfoImplToJson(
      this,
    );
  }
}

abstract class _UpdateInfo implements UpdateInfo {
  const factory _UpdateInfo(
      {required final String app,
      required final String latest,
      required final int build,
      @JsonKey(name: "min_version", defaultValue: null)
      final String? minVersion,
      required final String url,
      required final String sha256,
      required final bool force,
      required final String filename,
      required final List<String> notes,
      @JsonKey(name: "multilingual_notes", defaultValue: {})
      final Map<String, List<String>>? multilingualNotes}) = _$UpdateInfoImpl;

  factory _UpdateInfo.fromJson(Map<String, dynamic> json) =
      _$UpdateInfoImpl.fromJson;

  @override
  String get app;
  @override
  String get latest;
  @override
  int get build;
  @override
  @JsonKey(name: "min_version", defaultValue: null)
  String? get minVersion;
  @override
  String get url;
  @override
  String get sha256;
  @override
  bool get force;
  @override
  String get filename;
  @override
  List<String> get notes;
  @override
  @JsonKey(name: "multilingual_notes", defaultValue: {})
  Map<String, List<String>>? get multilingualNotes;
  @override
  @JsonKey(ignore: true)
  _$$UpdateInfoImplCopyWith<_$UpdateInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
