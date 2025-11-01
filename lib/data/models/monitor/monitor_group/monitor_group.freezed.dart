// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monitor_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MonitorGroup _$MonitorGroupFromJson(Map<String, dynamic> json) {
  return _MonitorGroup.fromJson(json);
}

/// @nodoc
mixin _$MonitorGroup {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscriptions_description')
  String? get subDescription => throw _privateConstructorUsedError;

  /// Serializes this MonitorGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonitorGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonitorGroupCopyWith<MonitorGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonitorGroupCopyWith<$Res> {
  factory $MonitorGroupCopyWith(
          MonitorGroup value, $Res Function(MonitorGroup) then) =
      _$MonitorGroupCopyWithImpl<$Res, MonitorGroup>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'subscriptions_description') String? subDescription});
}

/// @nodoc
class _$MonitorGroupCopyWithImpl<$Res, $Val extends MonitorGroup>
    implements $MonitorGroupCopyWith<$Res> {
  _$MonitorGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonitorGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? subDescription = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subDescription: freezed == subDescription
          ? _value.subDescription
          : subDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonitorGroupImplCopyWith<$Res>
    implements $MonitorGroupCopyWith<$Res> {
  factory _$$MonitorGroupImplCopyWith(
          _$MonitorGroupImpl value, $Res Function(_$MonitorGroupImpl) then) =
      __$$MonitorGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'subscriptions_description') String? subDescription});
}

/// @nodoc
class __$$MonitorGroupImplCopyWithImpl<$Res>
    extends _$MonitorGroupCopyWithImpl<$Res, _$MonitorGroupImpl>
    implements _$$MonitorGroupImplCopyWith<$Res> {
  __$$MonitorGroupImplCopyWithImpl(
      _$MonitorGroupImpl _value, $Res Function(_$MonitorGroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonitorGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? subDescription = freezed,
  }) {
    return _then(_$MonitorGroupImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subDescription: freezed == subDescription
          ? _value.subDescription
          : subDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonitorGroupImpl implements _MonitorGroup {
  const _$MonitorGroupImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'subscriptions_description') this.subDescription});

  factory _$MonitorGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonitorGroupImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'subscriptions_description')
  final String? subDescription;

  @override
  String toString() {
    return 'MonitorGroup(id: $id, name: $name, subDescription: $subDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonitorGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subDescription, subDescription) ||
                other.subDescription == subDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, subDescription);

  /// Create a copy of MonitorGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonitorGroupImplCopyWith<_$MonitorGroupImpl> get copyWith =>
      __$$MonitorGroupImplCopyWithImpl<_$MonitorGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonitorGroupImplToJson(
      this,
    );
  }
}

abstract class _MonitorGroup implements MonitorGroup {
  const factory _MonitorGroup(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'name') final String? name,
      @JsonKey(name: 'subscriptions_description')
      final String? subDescription}) = _$MonitorGroupImpl;

  factory _MonitorGroup.fromJson(Map<String, dynamic> json) =
      _$MonitorGroupImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'subscriptions_description')
  String? get subDescription;

  /// Create a copy of MonitorGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonitorGroupImplCopyWith<_$MonitorGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
