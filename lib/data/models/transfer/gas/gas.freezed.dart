// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Gas _$GasFromJson(Map<String, dynamic> json) {
  return _Gas.fromJson(json);
}

/// @nodoc
mixin _$Gas {
  @JsonKey(name: "chain_name")
  String get chainName => throw _privateConstructorUsedError;
  @JsonKey(name: "chain_type")
  String get chainType => throw _privateConstructorUsedError;
  @JsonKey(name: "gas")
  String get gas => throw _privateConstructorUsedError;
  @JsonKey(name: "symbol")
  String get symbol => throw _privateConstructorUsedError;

  /// Serializes this Gas to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Gas
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GasCopyWith<Gas> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasCopyWith<$Res> {
  factory $GasCopyWith(Gas value, $Res Function(Gas) then) =
      _$GasCopyWithImpl<$Res, Gas>;
  @useResult
  $Res call(
      {@JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "chain_type") String chainType,
      @JsonKey(name: "gas") String gas,
      @JsonKey(name: "symbol") String symbol});
}

/// @nodoc
class _$GasCopyWithImpl<$Res, $Val extends Gas> implements $GasCopyWith<$Res> {
  _$GasCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Gas
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainName = null,
    Object? chainType = null,
    Object? gas = null,
    Object? symbol = null,
  }) {
    return _then(_value.copyWith(
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      gas: null == gas
          ? _value.gas
          : gas // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GasImplCopyWith<$Res> implements $GasCopyWith<$Res> {
  factory _$$GasImplCopyWith(_$GasImpl value, $Res Function(_$GasImpl) then) =
      __$$GasImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chain_name") String chainName,
      @JsonKey(name: "chain_type") String chainType,
      @JsonKey(name: "gas") String gas,
      @JsonKey(name: "symbol") String symbol});
}

/// @nodoc
class __$$GasImplCopyWithImpl<$Res> extends _$GasCopyWithImpl<$Res, _$GasImpl>
    implements _$$GasImplCopyWith<$Res> {
  __$$GasImplCopyWithImpl(_$GasImpl _value, $Res Function(_$GasImpl) _then)
      : super(_value, _then);

  /// Create a copy of Gas
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainName = null,
    Object? chainType = null,
    Object? gas = null,
    Object? symbol = null,
  }) {
    return _then(_$GasImpl(
      chainName: null == chainName
          ? _value.chainName
          : chainName // ignore: cast_nullable_to_non_nullable
              as String,
      chainType: null == chainType
          ? _value.chainType
          : chainType // ignore: cast_nullable_to_non_nullable
              as String,
      gas: null == gas
          ? _value.gas
          : gas // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasImpl implements _Gas {
  const _$GasImpl(
      {@JsonKey(name: "chain_name") required this.chainName,
      @JsonKey(name: "chain_type") required this.chainType,
      @JsonKey(name: "gas") required this.gas,
      @JsonKey(name: "symbol") required this.symbol});

  factory _$GasImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasImplFromJson(json);

  @override
  @JsonKey(name: "chain_name")
  final String chainName;
  @override
  @JsonKey(name: "chain_type")
  final String chainType;
  @override
  @JsonKey(name: "gas")
  final String gas;
  @override
  @JsonKey(name: "symbol")
  final String symbol;

  @override
  String toString() {
    return 'Gas(chainName: $chainName, chainType: $chainType, gas: $gas, symbol: $symbol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasImpl &&
            (identical(other.chainName, chainName) ||
                other.chainName == chainName) &&
            (identical(other.chainType, chainType) ||
                other.chainType == chainType) &&
            (identical(other.gas, gas) || other.gas == gas) &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, chainName, chainType, gas, symbol);

  /// Create a copy of Gas
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GasImplCopyWith<_$GasImpl> get copyWith =>
      __$$GasImplCopyWithImpl<_$GasImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasImplToJson(
      this,
    );
  }
}

abstract class _Gas implements Gas {
  const factory _Gas(
      {@JsonKey(name: "chain_name") required final String chainName,
      @JsonKey(name: "chain_type") required final String chainType,
      @JsonKey(name: "gas") required final String gas,
      @JsonKey(name: "symbol") required final String symbol}) = _$GasImpl;

  factory _Gas.fromJson(Map<String, dynamic> json) = _$GasImpl.fromJson;

  @override
  @JsonKey(name: "chain_name")
  String get chainName;
  @override
  @JsonKey(name: "chain_type")
  String get chainType;
  @override
  @JsonKey(name: "gas")
  String get gas;
  @override
  @JsonKey(name: "symbol")
  String get symbol;

  /// Create a copy of Gas
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GasImplCopyWith<_$GasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
