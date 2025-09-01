// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sms _$SmsFromJson(Map<String, dynamic> json) {
  return _Sms.fromJson(json);
}

/// @nodoc
mixin _$Sms {
  @JsonKey(name: "email")
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: "ttl")
  int? get ttl => throw _privateConstructorUsedError;
  @JsonKey(name: "content")
  String? get content => throw _privateConstructorUsedError;

  /// Serializes this Sms to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sms
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsCopyWith<Sms> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsCopyWith<$Res> {
  factory $SmsCopyWith(Sms value, $Res Function(Sms) then) =
      _$SmsCopyWithImpl<$Res, Sms>;
  @useResult
  $Res call(
      {@JsonKey(name: "email") String? email,
      @JsonKey(name: "ttl") int? ttl,
      @JsonKey(name: "content") String? content});
}

/// @nodoc
class _$SmsCopyWithImpl<$Res, $Val extends Sms> implements $SmsCopyWith<$Res> {
  _$SmsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sms
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? ttl = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      ttl: freezed == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmsImplCopyWith<$Res> implements $SmsCopyWith<$Res> {
  factory _$$SmsImplCopyWith(_$SmsImpl value, $Res Function(_$SmsImpl) then) =
      __$$SmsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "email") String? email,
      @JsonKey(name: "ttl") int? ttl,
      @JsonKey(name: "content") String? content});
}

/// @nodoc
class __$$SmsImplCopyWithImpl<$Res> extends _$SmsCopyWithImpl<$Res, _$SmsImpl>
    implements _$$SmsImplCopyWith<$Res> {
  __$$SmsImplCopyWithImpl(_$SmsImpl _value, $Res Function(_$SmsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sms
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? ttl = freezed,
    Object? content = freezed,
  }) {
    return _then(_$SmsImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      ttl: freezed == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsImpl implements _Sms {
  const _$SmsImpl(
      {@JsonKey(name: "email") this.email,
      @JsonKey(name: "ttl") this.ttl,
      @JsonKey(name: "content") this.content});

  factory _$SmsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsImplFromJson(json);

  @override
  @JsonKey(name: "email")
  final String? email;
  @override
  @JsonKey(name: "ttl")
  final int? ttl;
  @override
  @JsonKey(name: "content")
  final String? content;

  @override
  String toString() {
    return 'Sms(email: $email, ttl: $ttl, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, ttl, content);

  /// Create a copy of Sms
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsImplCopyWith<_$SmsImpl> get copyWith =>
      __$$SmsImplCopyWithImpl<_$SmsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsImplToJson(
      this,
    );
  }
}

abstract class _Sms implements Sms {
  const factory _Sms(
      {@JsonKey(name: "email") final String? email,
      @JsonKey(name: "ttl") final int? ttl,
      @JsonKey(name: "content") final String? content}) = _$SmsImpl;

  factory _Sms.fromJson(Map<String, dynamic> json) = _$SmsImpl.fromJson;

  @override
  @JsonKey(name: "email")
  String? get email;
  @override
  @JsonKey(name: "ttl")
  int? get ttl;
  @override
  @JsonKey(name: "content")
  String? get content;

  /// Create a copy of Sms
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsImplCopyWith<_$SmsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
