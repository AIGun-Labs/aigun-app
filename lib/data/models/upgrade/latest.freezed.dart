// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Latest _$LatestFromJson(Map<String, dynamic> json) {
  return _Latest.fromJson(json);
}

/// @nodoc
mixin _$Latest {
  String get app => throw _privateConstructorUsedError;
  String get build => throw _privateConstructorUsedError;
  String get latest => throw _privateConstructorUsedError;
  @JsonKey(name: "min_version")
  String get minVersion => throw _privateConstructorUsedError;
  List<String> get notes => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get sha256 => throw _privateConstructorUsedError;
  bool get force => throw _privateConstructorUsedError;

  /// Serializes this Latest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Latest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LatestCopyWith<Latest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestCopyWith<$Res> {
  factory $LatestCopyWith(Latest value, $Res Function(Latest) then) =
      _$LatestCopyWithImpl<$Res, Latest>;
  @useResult
  $Res call(
      {String app,
      String build,
      String latest,
      @JsonKey(name: "min_version") String minVersion,
      List<String> notes,
      String url,
      String sha256,
      bool force});
}

/// @nodoc
class _$LatestCopyWithImpl<$Res, $Val extends Latest>
    implements $LatestCopyWith<$Res> {
  _$LatestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Latest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
    Object? build = null,
    Object? latest = null,
    Object? minVersion = null,
    Object? notes = null,
    Object? url = null,
    Object? sha256 = null,
    Object? force = null,
  }) {
    return _then(_value.copyWith(
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String,
      build: null == build
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as String,
      latest: null == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as String,
      minVersion: null == minVersion
          ? _value.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LatestImplCopyWith<$Res> implements $LatestCopyWith<$Res> {
  factory _$$LatestImplCopyWith(
          _$LatestImpl value, $Res Function(_$LatestImpl) then) =
      __$$LatestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String app,
      String build,
      String latest,
      @JsonKey(name: "min_version") String minVersion,
      List<String> notes,
      String url,
      String sha256,
      bool force});
}

/// @nodoc
class __$$LatestImplCopyWithImpl<$Res>
    extends _$LatestCopyWithImpl<$Res, _$LatestImpl>
    implements _$$LatestImplCopyWith<$Res> {
  __$$LatestImplCopyWithImpl(
      _$LatestImpl _value, $Res Function(_$LatestImpl) _then)
      : super(_value, _then);

  /// Create a copy of Latest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? app = null,
    Object? build = null,
    Object? latest = null,
    Object? minVersion = null,
    Object? notes = null,
    Object? url = null,
    Object? sha256 = null,
    Object? force = null,
  }) {
    return _then(_$LatestImpl(
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String,
      build: null == build
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as String,
      latest: null == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as String,
      minVersion: null == minVersion
          ? _value.minVersion
          : minVersion // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LatestImpl implements _Latest {
  const _$LatestImpl(
      {required this.app,
      required this.build,
      required this.latest,
      @JsonKey(name: "min_version") required this.minVersion,
      required final List<String> notes,
      required this.url,
      required this.sha256,
      required this.force})
      : _notes = notes;

  factory _$LatestImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatestImplFromJson(json);

  @override
  final String app;
  @override
  final String build;
  @override
  final String latest;
  @override
  @JsonKey(name: "min_version")
  final String minVersion;
  final List<String> _notes;
  @override
  List<String> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  final String url;
  @override
  final String sha256;
  @override
  final bool force;

  @override
  String toString() {
    return 'Latest(app: $app, build: $build, latest: $latest, minVersion: $minVersion, notes: $notes, url: $url, sha256: $sha256, force: $force)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatestImpl &&
            (identical(other.app, app) || other.app == app) &&
            (identical(other.build, build) || other.build == build) &&
            (identical(other.latest, latest) || other.latest == latest) &&
            (identical(other.minVersion, minVersion) ||
                other.minVersion == minVersion) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sha256, sha256) || other.sha256 == sha256) &&
            (identical(other.force, force) || other.force == force));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, app, build, latest, minVersion,
      const DeepCollectionEquality().hash(_notes), url, sha256, force);

  /// Create a copy of Latest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LatestImplCopyWith<_$LatestImpl> get copyWith =>
      __$$LatestImplCopyWithImpl<_$LatestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatestImplToJson(
      this,
    );
  }
}

abstract class _Latest implements Latest {
  const factory _Latest(
      {required final String app,
      required final String build,
      required final String latest,
      @JsonKey(name: "min_version") required final String minVersion,
      required final List<String> notes,
      required final String url,
      required final String sha256,
      required final bool force}) = _$LatestImpl;

  factory _Latest.fromJson(Map<String, dynamic> json) = _$LatestImpl.fromJson;

  @override
  String get app;
  @override
  String get build;
  @override
  String get latest;
  @override
  @JsonKey(name: "min_version")
  String get minVersion;
  @override
  List<String> get notes;
  @override
  String get url;
  @override
  String get sha256;
  @override
  bool get force;

  /// Create a copy of Latest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LatestImplCopyWith<_$LatestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
