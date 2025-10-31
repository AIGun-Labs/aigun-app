// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'urls.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenDetailUrls _$TokenDetailUrlsFromJson(Map<String, dynamic> json) {
  return _TokenDetailUrls.fromJson(json);
}

/// @nodoc
mixin _$TokenDetailUrls {
  @JsonKey(name: "twitter")
  String? get twitter => throw _privateConstructorUsedError;
  @JsonKey(name: "discord")
  String? get discord => throw _privateConstructorUsedError;
  @JsonKey(name: "telegram")
  String? get telegram => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenDetailUrlsCopyWith<TokenDetailUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDetailUrlsCopyWith<$Res> {
  factory $TokenDetailUrlsCopyWith(
          TokenDetailUrls value, $Res Function(TokenDetailUrls) then) =
      _$TokenDetailUrlsCopyWithImpl<$Res, TokenDetailUrls>;
  @useResult
  $Res call(
      {@JsonKey(name: "twitter") String? twitter,
      @JsonKey(name: "discord") String? discord,
      @JsonKey(name: "telegram") String? telegram});
}

/// @nodoc
class _$TokenDetailUrlsCopyWithImpl<$Res, $Val extends TokenDetailUrls>
    implements $TokenDetailUrlsCopyWith<$Res> {
  _$TokenDetailUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? twitter = freezed,
    Object? discord = freezed,
    Object? telegram = freezed,
  }) {
    return _then(_value.copyWith(
      twitter: freezed == twitter
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      discord: freezed == discord
          ? _value.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as String?,
      telegram: freezed == telegram
          ? _value.telegram
          : telegram // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenDetailUrlsImplCopyWith<$Res>
    implements $TokenDetailUrlsCopyWith<$Res> {
  factory _$$TokenDetailUrlsImplCopyWith(_$TokenDetailUrlsImpl value,
          $Res Function(_$TokenDetailUrlsImpl) then) =
      __$$TokenDetailUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "twitter") String? twitter,
      @JsonKey(name: "discord") String? discord,
      @JsonKey(name: "telegram") String? telegram});
}

/// @nodoc
class __$$TokenDetailUrlsImplCopyWithImpl<$Res>
    extends _$TokenDetailUrlsCopyWithImpl<$Res, _$TokenDetailUrlsImpl>
    implements _$$TokenDetailUrlsImplCopyWith<$Res> {
  __$$TokenDetailUrlsImplCopyWithImpl(
      _$TokenDetailUrlsImpl _value, $Res Function(_$TokenDetailUrlsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? twitter = freezed,
    Object? discord = freezed,
    Object? telegram = freezed,
  }) {
    return _then(_$TokenDetailUrlsImpl(
      twitter: freezed == twitter
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      discord: freezed == discord
          ? _value.discord
          : discord // ignore: cast_nullable_to_non_nullable
              as String?,
      telegram: freezed == telegram
          ? _value.telegram
          : telegram // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenDetailUrlsImpl implements _TokenDetailUrls {
  const _$TokenDetailUrlsImpl(
      {@JsonKey(name: "twitter") this.twitter,
      @JsonKey(name: "discord") this.discord,
      @JsonKey(name: "telegram") this.telegram});

  factory _$TokenDetailUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenDetailUrlsImplFromJson(json);

  @override
  @JsonKey(name: "twitter")
  final String? twitter;
  @override
  @JsonKey(name: "discord")
  final String? discord;
  @override
  @JsonKey(name: "telegram")
  final String? telegram;

  @override
  String toString() {
    return 'TokenDetailUrls(twitter: $twitter, discord: $discord, telegram: $telegram)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenDetailUrlsImpl &&
            (identical(other.twitter, twitter) || other.twitter == twitter) &&
            (identical(other.discord, discord) || other.discord == discord) &&
            (identical(other.telegram, telegram) ||
                other.telegram == telegram));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, twitter, discord, telegram);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenDetailUrlsImplCopyWith<_$TokenDetailUrlsImpl> get copyWith =>
      __$$TokenDetailUrlsImplCopyWithImpl<_$TokenDetailUrlsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenDetailUrlsImplToJson(
      this,
    );
  }
}

abstract class _TokenDetailUrls implements TokenDetailUrls {
  const factory _TokenDetailUrls(
          {@JsonKey(name: "twitter") final String? twitter,
          @JsonKey(name: "discord") final String? discord,
          @JsonKey(name: "telegram") final String? telegram}) =
      _$TokenDetailUrlsImpl;

  factory _TokenDetailUrls.fromJson(Map<String, dynamic> json) =
      _$TokenDetailUrlsImpl.fromJson;

  @override
  @JsonKey(name: "twitter")
  String? get twitter;
  @override
  @JsonKey(name: "discord")
  String? get discord;
  @override
  @JsonKey(name: "telegram")
  String? get telegram;
  @override
  @JsonKey(ignore: true)
  _$$TokenDetailUrlsImplCopyWith<_$TokenDetailUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
