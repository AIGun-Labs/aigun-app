// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captcha.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Captcha _$CaptchaFromJson(Map<String, dynamic> json) {
  return _Captcha.fromJson(json);
}

/// @nodoc
mixin _$Captcha {
  @JsonKey(name: "key")
  String get key => throw _privateConstructorUsedError;
  @JsonKey(name: "master_image")
  String get masterImage => throw _privateConstructorUsedError;
  @JsonKey(name: "thumb_image")
  String get thumbImage => throw _privateConstructorUsedError;

  /// Serializes this Captcha to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Captcha
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaptchaCopyWith<Captcha> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaptchaCopyWith<$Res> {
  factory $CaptchaCopyWith(Captcha value, $Res Function(Captcha) then) =
      _$CaptchaCopyWithImpl<$Res, Captcha>;
  @useResult
  $Res call(
      {@JsonKey(name: "key") String key,
      @JsonKey(name: "master_image") String masterImage,
      @JsonKey(name: "thumb_image") String thumbImage});
}

/// @nodoc
class _$CaptchaCopyWithImpl<$Res, $Val extends Captcha>
    implements $CaptchaCopyWith<$Res> {
  _$CaptchaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Captcha
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? masterImage = null,
    Object? thumbImage = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      masterImage: null == masterImage
          ? _value.masterImage
          : masterImage // ignore: cast_nullable_to_non_nullable
              as String,
      thumbImage: null == thumbImage
          ? _value.thumbImage
          : thumbImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CaptchaImplCopyWith<$Res> implements $CaptchaCopyWith<$Res> {
  factory _$$CaptchaImplCopyWith(
          _$CaptchaImpl value, $Res Function(_$CaptchaImpl) then) =
      __$$CaptchaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "key") String key,
      @JsonKey(name: "master_image") String masterImage,
      @JsonKey(name: "thumb_image") String thumbImage});
}

/// @nodoc
class __$$CaptchaImplCopyWithImpl<$Res>
    extends _$CaptchaCopyWithImpl<$Res, _$CaptchaImpl>
    implements _$$CaptchaImplCopyWith<$Res> {
  __$$CaptchaImplCopyWithImpl(
      _$CaptchaImpl _value, $Res Function(_$CaptchaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Captcha
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? masterImage = null,
    Object? thumbImage = null,
  }) {
    return _then(_$CaptchaImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      masterImage: null == masterImage
          ? _value.masterImage
          : masterImage // ignore: cast_nullable_to_non_nullable
              as String,
      thumbImage: null == thumbImage
          ? _value.thumbImage
          : thumbImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CaptchaImpl implements _Captcha {
  const _$CaptchaImpl(
      {@JsonKey(name: "key") required this.key,
      @JsonKey(name: "master_image") required this.masterImage,
      @JsonKey(name: "thumb_image") required this.thumbImage});

  factory _$CaptchaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaptchaImplFromJson(json);

  @override
  @JsonKey(name: "key")
  final String key;
  @override
  @JsonKey(name: "master_image")
  final String masterImage;
  @override
  @JsonKey(name: "thumb_image")
  final String thumbImage;

  @override
  String toString() {
    return 'Captcha(key: $key, masterImage: $masterImage, thumbImage: $thumbImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaptchaImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.masterImage, masterImage) ||
                other.masterImage == masterImage) &&
            (identical(other.thumbImage, thumbImage) ||
                other.thumbImage == thumbImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, masterImage, thumbImage);

  /// Create a copy of Captcha
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaptchaImplCopyWith<_$CaptchaImpl> get copyWith =>
      __$$CaptchaImplCopyWithImpl<_$CaptchaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaptchaImplToJson(
      this,
    );
  }
}

abstract class _Captcha implements Captcha {
  const factory _Captcha(
          {@JsonKey(name: "key") required final String key,
          @JsonKey(name: "master_image") required final String masterImage,
          @JsonKey(name: "thumb_image") required final String thumbImage}) =
      _$CaptchaImpl;

  factory _Captcha.fromJson(Map<String, dynamic> json) = _$CaptchaImpl.fromJson;

  @override
  @JsonKey(name: "key")
  String get key;
  @override
  @JsonKey(name: "master_image")
  String get masterImage;
  @override
  @JsonKey(name: "thumb_image")
  String get thumbImage;

  /// Create a copy of Captcha
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaptchaImplCopyWith<_$CaptchaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
