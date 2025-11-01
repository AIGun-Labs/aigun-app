// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletList _$WalletListFromJson(Map<String, dynamic> json) {
  return _WalletList.fromJson(json);
}

/// @nodoc
mixin _$WalletList {
  List<Wallet> get wallets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletListCopyWith<WalletList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletListCopyWith<$Res> {
  factory $WalletListCopyWith(
          WalletList value, $Res Function(WalletList) then) =
      _$WalletListCopyWithImpl<$Res, WalletList>;
  @useResult
  $Res call({List<Wallet> wallets});
}

/// @nodoc
class _$WalletListCopyWithImpl<$Res, $Val extends WalletList>
    implements $WalletListCopyWith<$Res> {
  _$WalletListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallets = null,
  }) {
    return _then(_value.copyWith(
      wallets: null == wallets
          ? _value.wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletListImplCopyWith<$Res>
    implements $WalletListCopyWith<$Res> {
  factory _$$WalletListImplCopyWith(
          _$WalletListImpl value, $Res Function(_$WalletListImpl) then) =
      __$$WalletListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Wallet> wallets});
}

/// @nodoc
class __$$WalletListImplCopyWithImpl<$Res>
    extends _$WalletListCopyWithImpl<$Res, _$WalletListImpl>
    implements _$$WalletListImplCopyWith<$Res> {
  __$$WalletListImplCopyWithImpl(
      _$WalletListImpl _value, $Res Function(_$WalletListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallets = null,
  }) {
    return _then(_$WalletListImpl(
      wallets: null == wallets
          ? _value._wallets
          : wallets // ignore: cast_nullable_to_non_nullable
              as List<Wallet>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletListImpl implements _WalletList {
  const _$WalletListImpl({final List<Wallet> wallets = const []})
      : _wallets = wallets;

  factory _$WalletListImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletListImplFromJson(json);

  final List<Wallet> _wallets;
  @override
  @JsonKey()
  List<Wallet> get wallets {
    if (_wallets is EqualUnmodifiableListView) return _wallets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wallets);
  }

  @override
  String toString() {
    return 'WalletList(wallets: $wallets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletListImpl &&
            const DeepCollectionEquality().equals(other._wallets, _wallets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_wallets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletListImplCopyWith<_$WalletListImpl> get copyWith =>
      __$$WalletListImplCopyWithImpl<_$WalletListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletListImplToJson(
      this,
    );
  }
}

abstract class _WalletList implements WalletList {
  const factory _WalletList({final List<Wallet> wallets}) = _$WalletListImpl;

  factory _WalletList.fromJson(Map<String, dynamic> json) =
      _$WalletListImpl.fromJson;

  @override
  List<Wallet> get wallets;
  @override
  @JsonKey(ignore: true)
  _$$WalletListImplCopyWith<_$WalletListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
