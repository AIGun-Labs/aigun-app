// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletAddress _$WalletAddressFromJson(Map<String, dynamic> json) {
  return _WalletAddress.fromJson(json);
}

/// @nodoc
mixin _$WalletAddress {
  @JsonKey(name: "chain_id")
  String? get chainId => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_name")
  String? get chainName => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_logo")
  String? get chainLogo => throw _privateConstructorUsedError;
  @JsonKey(name: "address_type")
  String? get addressType => throw _privateConstructorUsedError;
  @JsonKey(name: "address")
  String? get address => throw _privateConstructorUsedError;

  /// Serializes this WalletAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletAddressCopyWith<WalletAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletAddressCopyWith<$Res> {
  factory $WalletAddressCopyWith(
          WalletAddress value, $Res Function(WalletAddress) then) =
      _$WalletAddressCopyWithImpl<$Res, WalletAddress>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") String? chainId,
      @JsonKey(name: "chain_name") String? chainName,
      @JsonKey(name: "chain_logo") String? chainLogo,
      @JsonKey(name: "address_type") String? addressType,
      @JsonKey(name: "address") String? address});
}

/// @nodoc
class _$WalletAddressCopyWithImpl<$Res, $Val extends WalletAddress>
    implements $WalletAddressCopyWith<$Res> {
  _$WalletAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = freezed,
    Object? chainName = freezed,
    Object? chainLogo = freezed,
    Object? addressType = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String?,
      chainName: freezed == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String?,
      chainLogo: freezed == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      addressType: freezed == addressType
          ? _value.addressType
          : addressType // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletAddressImplCopyWith<$Res>
    implements $WalletAddressCopyWith<$Res> {
  factory _$$WalletAddressImplCopyWith(
          _$WalletAddressImpl value, $Res Function(_$WalletAddressImpl) then) =
      __$$WalletAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chain_id") String? chainId,
      @JsonKey(name: "chain_name") String? chainName,
      @JsonKey(name: "chain_logo") String? chainLogo,
      @JsonKey(name: "address_type") String? addressType,
      @JsonKey(name: "address") String? address});
}

/// @nodoc
class __$$WalletAddressImplCopyWithImpl<$Res>
    extends _$WalletAddressCopyWithImpl<$Res, _$WalletAddressImpl>
    implements _$$WalletAddressImplCopyWith<$Res> {
  __$$WalletAddressImplCopyWithImpl(
      _$WalletAddressImpl _value, $Res Function(_$WalletAddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = freezed,
    Object? chainName = freezed,
    Object? chainLogo = freezed,
    Object? addressType = freezed,
    Object? address = freezed,
  }) {
    return _then(_$WalletAddressImpl(
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String?,
      chainName: freezed == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String?,
      chainLogo: freezed == chainLogo
          ? _value.chainLogo
          : chainLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      addressType: freezed == addressType
          ? _value.addressType
          : addressType // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletAddressImpl implements _WalletAddress {
  const _$WalletAddressImpl(
      {@JsonKey(name: "chain_id") this.chainId,
      @JsonKey(name: "chain_name") this.chainName,
      @JsonKey(name: "chain_logo") this.chainLogo,
      @JsonKey(name: "address_type") this.addressType,
      @JsonKey(name: "address") this.address});

  factory _$WalletAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletAddressImplFromJson(json);

  @override
  @JsonKey(name: "chain_id")
  final String? chainId;
  @override
  @JsonKey(name: "chain_name")
  final String? chainName;
  @override
  @JsonKey(name: "chain_logo")
  final String? chainLogo;
  @override
  @JsonKey(name: "address_type")
  final String? addressType;
  @override
  @JsonKey(name: "address")
  final String? address;

  @override
  String toString() {
    return 'WalletAddress(chainId: $chainId, chainName: $chainName, chainLogo: $chainLogo, addressType: $addressType, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletAddressImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.chainName, chainName) ||
                other.chainName == chainName) &&
            (identical(other.chainLogo, chainLogo) ||
                other.chainLogo == chainLogo) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chainId, chainName, chainLogo, addressType, address);

  /// Create a copy of WalletAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletAddressImplCopyWith<_$WalletAddressImpl> get copyWith =>
      __$$WalletAddressImplCopyWithImpl<_$WalletAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletAddressImplToJson(
      this,
    );
  }
}

abstract class _WalletAddress implements WalletAddress {
  const factory _WalletAddress(
      {@JsonKey(name: "chain_id") final String? chainId,
      @JsonKey(name: "chain_name") final String? chainName,
      @JsonKey(name: "chain_logo") final String? chainLogo,
      @JsonKey(name: "address_type") final String? addressType,
      @JsonKey(name: "address") final String? address}) = _$WalletAddressImpl;

  factory _WalletAddress.fromJson(Map<String, dynamic> json) =
      _$WalletAddressImpl.fromJson;

  @override
  @JsonKey(name: "chain_id")
  String? get chainId;
  @override
  @JsonKey(name: "chain_name")
  String? get chainName;
  @override
  @JsonKey(name: "chain_logo")
  String? get chainLogo;
  @override
  @JsonKey(name: "address_type")
  String? get addressType;
  @override
  @JsonKey(name: "address")
  String? get address;

  /// Create a copy of WalletAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletAddressImplCopyWith<_$WalletAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
mixin _$Wallet {
  @JsonKey(name: "id")
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "addresses")
  List<WalletAddress>? get addresses => throw _privateConstructorUsedError;

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res, Wallet>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") String? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "addresses") List<WalletAddress>? addresses});
}

/// @nodoc
class _$WalletCopyWithImpl<$Res, $Val extends Wallet>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? addresses = freezed,
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
      addresses: freezed == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<WalletAddress>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletImplCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$$WalletImplCopyWith(
          _$WalletImpl value, $Res Function(_$WalletImpl) then) =
      __$$WalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") String? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "addresses") List<WalletAddress>? addresses});
}

/// @nodoc
class __$$WalletImplCopyWithImpl<$Res>
    extends _$WalletCopyWithImpl<$Res, _$WalletImpl>
    implements _$$WalletImplCopyWith<$Res> {
  __$$WalletImplCopyWithImpl(
      _$WalletImpl _value, $Res Function(_$WalletImpl) _then)
      : super(_value, _then);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? addresses = freezed,
  }) {
    return _then(_$WalletImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      addresses: freezed == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<WalletAddress>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletImpl implements _Wallet {
  const _$WalletImpl(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "addresses") final List<WalletAddress>? addresses})
      : _addresses = addresses;

  factory _$WalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final String? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  final List<WalletAddress>? _addresses;
  @override
  @JsonKey(name: "addresses")
  List<WalletAddress>? get addresses {
    final value = _addresses;
    if (value == null) return null;
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Wallet(id: $id, name: $name, addresses: $addresses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_addresses));

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      __$$WalletImplCopyWithImpl<_$WalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletImplToJson(
      this,
    );
  }
}

abstract class _Wallet implements Wallet {
  const factory _Wallet(
          {@JsonKey(name: "id") final String? id,
          @JsonKey(name: "name") final String? name,
          @JsonKey(name: "addresses") final List<WalletAddress>? addresses}) =
      _$WalletImpl;

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$WalletImpl.fromJson;

  @override
  @JsonKey(name: "id")
  String? get id;
  @override
  @JsonKey(name: "name")
  String? get name;
  @override
  @JsonKey(name: "addresses")
  List<WalletAddress>? get addresses;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
