// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_privatekey.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExportPrivateKey _$ExportPrivateKeyFromJson(Map<String, dynamic> json) {
  return _ExportPrivateKey.fromJson(json);
}

/// @nodoc
mixin _$ExportPrivateKey {
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'private_key')
  String get privateKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExportPrivateKeyCopyWith<ExportPrivateKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportPrivateKeyCopyWith<$Res> {
  factory $ExportPrivateKeyCopyWith(
          ExportPrivateKey value, $Res Function(ExportPrivateKey) then) =
      _$ExportPrivateKeyCopyWithImpl<$Res, ExportPrivateKey>;
  @useResult
  $Res call({String address, @JsonKey(name: 'private_key') String privateKey});
}

/// @nodoc
class _$ExportPrivateKeyCopyWithImpl<$Res, $Val extends ExportPrivateKey>
    implements $ExportPrivateKeyCopyWith<$Res> {
  _$ExportPrivateKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? privateKey = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      privateKey: null == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExportPrivateKeyImplCopyWith<$Res>
    implements $ExportPrivateKeyCopyWith<$Res> {
  factory _$$ExportPrivateKeyImplCopyWith(_$ExportPrivateKeyImpl value,
          $Res Function(_$ExportPrivateKeyImpl) then) =
      __$$ExportPrivateKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, @JsonKey(name: 'private_key') String privateKey});
}

/// @nodoc
class __$$ExportPrivateKeyImplCopyWithImpl<$Res>
    extends _$ExportPrivateKeyCopyWithImpl<$Res, _$ExportPrivateKeyImpl>
    implements _$$ExportPrivateKeyImplCopyWith<$Res> {
  __$$ExportPrivateKeyImplCopyWithImpl(_$ExportPrivateKeyImpl _value,
      $Res Function(_$ExportPrivateKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? privateKey = null,
  }) {
    return _then(_$ExportPrivateKeyImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      privateKey: null == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPrivateKeyImpl implements _ExportPrivateKey {
  const _$ExportPrivateKeyImpl(
      {required this.address,
      @JsonKey(name: 'private_key') required this.privateKey});

  factory _$ExportPrivateKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportPrivateKeyImplFromJson(json);

  @override
  final String address;
  @override
  @JsonKey(name: 'private_key')
  final String privateKey;

  @override
  String toString() {
    return 'ExportPrivateKey(address: $address, privateKey: $privateKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPrivateKeyImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.privateKey, privateKey) ||
                other.privateKey == privateKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, privateKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportPrivateKeyImplCopyWith<_$ExportPrivateKeyImpl> get copyWith =>
      __$$ExportPrivateKeyImplCopyWithImpl<_$ExportPrivateKeyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPrivateKeyImplToJson(
      this,
    );
  }
}

abstract class _ExportPrivateKey implements ExportPrivateKey {
  const factory _ExportPrivateKey(
          {required final String address,
          @JsonKey(name: 'private_key') required final String privateKey}) =
      _$ExportPrivateKeyImpl;

  factory _ExportPrivateKey.fromJson(Map<String, dynamic> json) =
      _$ExportPrivateKeyImpl.fromJson;

  @override
  String get address;
  @override
  @JsonKey(name: 'private_key')
  String get privateKey;
  @override
  @JsonKey(ignore: true)
  _$$ExportPrivateKeyImplCopyWith<_$ExportPrivateKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
