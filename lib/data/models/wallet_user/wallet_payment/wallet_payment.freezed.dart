// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_payment.dart';

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
  String? get key => throw _privateConstructorUsedError;
  @JsonKey(name: "image_base64")
  String? get imageBase64 => throw _privateConstructorUsedError;
  @JsonKey(name: "thumb_base64")
  String? get thumbBase64 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CaptchaCopyWith<Captcha> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaptchaCopyWith<$Res> {
  factory $CaptchaCopyWith(Captcha value, $Res Function(Captcha) then) =
      _$CaptchaCopyWithImpl<$Res, Captcha>;
  @useResult
  $Res call(
      {@JsonKey(name: "key") String? key,
      @JsonKey(name: "image_base64") String? imageBase64,
      @JsonKey(name: "thumb_base64") String? thumbBase64});
}

/// @nodoc
class _$CaptchaCopyWithImpl<$Res, $Val extends Captcha>
    implements $CaptchaCopyWith<$Res> {
  _$CaptchaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? imageBase64 = freezed,
    Object? thumbBase64 = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      imageBase64: freezed == imageBase64
          ? _value.imageBase64
          : imageBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbBase64: freezed == thumbBase64
          ? _value.thumbBase64
          : thumbBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {@JsonKey(name: "key") String? key,
      @JsonKey(name: "image_base64") String? imageBase64,
      @JsonKey(name: "thumb_base64") String? thumbBase64});
}

/// @nodoc
class __$$CaptchaImplCopyWithImpl<$Res>
    extends _$CaptchaCopyWithImpl<$Res, _$CaptchaImpl>
    implements _$$CaptchaImplCopyWith<$Res> {
  __$$CaptchaImplCopyWithImpl(
      _$CaptchaImpl _value, $Res Function(_$CaptchaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? imageBase64 = freezed,
    Object? thumbBase64 = freezed,
  }) {
    return _then(_$CaptchaImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      imageBase64: freezed == imageBase64
          ? _value.imageBase64
          : imageBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbBase64: freezed == thumbBase64
          ? _value.thumbBase64
          : thumbBase64 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CaptchaImpl implements _Captcha {
  const _$CaptchaImpl(
      {@JsonKey(name: "key") this.key,
      @JsonKey(name: "image_base64") this.imageBase64,
      @JsonKey(name: "thumb_base64") this.thumbBase64});

  factory _$CaptchaImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaptchaImplFromJson(json);

  @override
  @JsonKey(name: "key")
  final String? key;
  @override
  @JsonKey(name: "image_base64")
  final String? imageBase64;
  @override
  @JsonKey(name: "thumb_base64")
  final String? thumbBase64;

  @override
  String toString() {
    return 'Captcha(key: $key, imageBase64: $imageBase64, thumbBase64: $thumbBase64)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaptchaImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.imageBase64, imageBase64) ||
                other.imageBase64 == imageBase64) &&
            (identical(other.thumbBase64, thumbBase64) ||
                other.thumbBase64 == thumbBase64));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, imageBase64, thumbBase64);

  @JsonKey(ignore: true)
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
          {@JsonKey(name: "key") final String? key,
          @JsonKey(name: "image_base64") final String? imageBase64,
          @JsonKey(name: "thumb_base64") final String? thumbBase64}) =
      _$CaptchaImpl;

  factory _Captcha.fromJson(Map<String, dynamic> json) = _$CaptchaImpl.fromJson;

  @override
  @JsonKey(name: "key")
  String? get key;
  @override
  @JsonKey(name: "image_base64")
  String? get imageBase64;
  @override
  @JsonKey(name: "thumb_base64")
  String? get thumbBase64;
  @override
  @JsonKey(ignore: true)
  _$$CaptchaImplCopyWith<_$CaptchaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WalletPayment _$WalletPaymentFromJson(Map<String, dynamic> json) {
  return _WalletPayment.fromJson(json);
}

/// @nodoc
mixin _$WalletPayment {
  @JsonKey(name: "type")
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: "captcha")
  Captcha? get captcha => throw _privateConstructorUsedError;
  @JsonKey(name: "sms")
  Sms? get sms => throw _privateConstructorUsedError;
  @JsonKey(name: "token")
  String? get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletPaymentCopyWith<WalletPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletPaymentCopyWith<$Res> {
  factory $WalletPaymentCopyWith(
          WalletPayment value, $Res Function(WalletPayment) then) =
      _$WalletPaymentCopyWithImpl<$Res, WalletPayment>;
  @useResult
  $Res call(
      {@JsonKey(name: "type") String? type,
      @JsonKey(name: "captcha") Captcha? captcha,
      @JsonKey(name: "sms") Sms? sms,
      @JsonKey(name: "token") String? token});

  $CaptchaCopyWith<$Res>? get captcha;
  $SmsCopyWith<$Res>? get sms;
}

/// @nodoc
class _$WalletPaymentCopyWithImpl<$Res, $Val extends WalletPayment>
    implements $WalletPaymentCopyWith<$Res> {
  _$WalletPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? captcha = freezed,
    Object? sms = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      captcha: freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as Captcha?,
      sms: freezed == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as Sms?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CaptchaCopyWith<$Res>? get captcha {
    if (_value.captcha == null) {
      return null;
    }

    return $CaptchaCopyWith<$Res>(_value.captcha!, (value) {
      return _then(_value.copyWith(captcha: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SmsCopyWith<$Res>? get sms {
    if (_value.sms == null) {
      return null;
    }

    return $SmsCopyWith<$Res>(_value.sms!, (value) {
      return _then(_value.copyWith(sms: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WalletPaymentImplCopyWith<$Res>
    implements $WalletPaymentCopyWith<$Res> {
  factory _$$WalletPaymentImplCopyWith(
          _$WalletPaymentImpl value, $Res Function(_$WalletPaymentImpl) then) =
      __$$WalletPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "type") String? type,
      @JsonKey(name: "captcha") Captcha? captcha,
      @JsonKey(name: "sms") Sms? sms,
      @JsonKey(name: "token") String? token});

  @override
  $CaptchaCopyWith<$Res>? get captcha;
  @override
  $SmsCopyWith<$Res>? get sms;
}

/// @nodoc
class __$$WalletPaymentImplCopyWithImpl<$Res>
    extends _$WalletPaymentCopyWithImpl<$Res, _$WalletPaymentImpl>
    implements _$$WalletPaymentImplCopyWith<$Res> {
  __$$WalletPaymentImplCopyWithImpl(
      _$WalletPaymentImpl _value, $Res Function(_$WalletPaymentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? captcha = freezed,
    Object? sms = freezed,
    Object? token = freezed,
  }) {
    return _then(_$WalletPaymentImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      captcha: freezed == captcha
          ? _value.captcha
          : captcha // ignore: cast_nullable_to_non_nullable
              as Captcha?,
      sms: freezed == sms
          ? _value.sms
          : sms // ignore: cast_nullable_to_non_nullable
              as Sms?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletPaymentImpl implements _WalletPayment {
  const _$WalletPaymentImpl(
      {@JsonKey(name: "type") this.type,
      @JsonKey(name: "captcha") this.captcha,
      @JsonKey(name: "sms") this.sms,
      @JsonKey(name: "token") this.token});

  factory _$WalletPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletPaymentImplFromJson(json);

  @override
  @JsonKey(name: "type")
  final String? type;
  @override
  @JsonKey(name: "captcha")
  final Captcha? captcha;
  @override
  @JsonKey(name: "sms")
  final Sms? sms;
  @override
  @JsonKey(name: "token")
  final String? token;

  @override
  String toString() {
    return 'WalletPayment(type: $type, captcha: $captcha, sms: $sms, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletPaymentImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.captcha, captcha) || other.captcha == captcha) &&
            (identical(other.sms, sms) || other.sms == sms) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, captcha, sms, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletPaymentImplCopyWith<_$WalletPaymentImpl> get copyWith =>
      __$$WalletPaymentImplCopyWithImpl<_$WalletPaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletPaymentImplToJson(
      this,
    );
  }
}

abstract class _WalletPayment implements WalletPayment {
  const factory _WalletPayment(
      {@JsonKey(name: "type") final String? type,
      @JsonKey(name: "captcha") final Captcha? captcha,
      @JsonKey(name: "sms") final Sms? sms,
      @JsonKey(name: "token") final String? token}) = _$WalletPaymentImpl;

  factory _WalletPayment.fromJson(Map<String, dynamic> json) =
      _$WalletPaymentImpl.fromJson;

  @override
  @JsonKey(name: "type")
  String? get type;
  @override
  @JsonKey(name: "captcha")
  Captcha? get captcha;
  @override
  @JsonKey(name: "sms")
  Sms? get sms;
  @override
  @JsonKey(name: "token")
  String? get token;
  @override
  @JsonKey(ignore: true)
  _$$WalletPaymentImplCopyWith<_$WalletPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
