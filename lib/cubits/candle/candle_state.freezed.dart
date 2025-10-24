// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candle_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CandleState {
  List<Candle> get candles => throw _privateConstructorUsedError;
  dynamic get network => throw _privateConstructorUsedError;
  dynamic get tokenAddress => throw _privateConstructorUsedError;
  dynamic get bar => throw _privateConstructorUsedError;
  dynamic get limit => throw _privateConstructorUsedError;
  dynamic get from => throw _privateConstructorUsedError;
  dynamic get to => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of CandleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CandleStateCopyWith<CandleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleStateCopyWith<$Res> {
  factory $CandleStateCopyWith(
          CandleState value, $Res Function(CandleState) then) =
      _$CandleStateCopyWithImpl<$Res, CandleState>;
  @useResult
  $Res call(
      {List<Candle> candles,
      dynamic network,
      dynamic tokenAddress,
      dynamic bar,
      dynamic limit,
      dynamic from,
      dynamic to,
      bool isLoading});
}

/// @nodoc
class _$CandleStateCopyWithImpl<$Res, $Val extends CandleState>
    implements $CandleStateCopyWith<$Res> {
  _$CandleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CandleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
    Object? network = freezed,
    Object? tokenAddress = freezed,
    Object? bar = freezed,
    Object? limit = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      candles: null == candles
          ? _value.candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<Candle>,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as dynamic,
      bar: freezed == bar
          ? _value.bar
          : bar // ignore: cast_nullable_to_non_nullable
              as dynamic,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as dynamic,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as dynamic,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CandleStateImplCopyWith<$Res>
    implements $CandleStateCopyWith<$Res> {
  factory _$$CandleStateImplCopyWith(
          _$CandleStateImpl value, $Res Function(_$CandleStateImpl) then) =
      __$$CandleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Candle> candles,
      dynamic network,
      dynamic tokenAddress,
      dynamic bar,
      dynamic limit,
      dynamic from,
      dynamic to,
      bool isLoading});
}

/// @nodoc
class __$$CandleStateImplCopyWithImpl<$Res>
    extends _$CandleStateCopyWithImpl<$Res, _$CandleStateImpl>
    implements _$$CandleStateImplCopyWith<$Res> {
  __$$CandleStateImplCopyWithImpl(
      _$CandleStateImpl _value, $Res Function(_$CandleStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CandleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
    Object? network = freezed,
    Object? tokenAddress = freezed,
    Object? bar = freezed,
    Object? limit = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$CandleStateImpl(
      candles: null == candles
          ? _value._candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<Candle>,
      network: freezed == network ? _value.network! : network,
      tokenAddress:
          freezed == tokenAddress ? _value.tokenAddress! : tokenAddress,
      bar: freezed == bar ? _value.bar! : bar,
      limit: freezed == limit ? _value.limit! : limit,
      from: freezed == from ? _value.from! : from,
      to: freezed == to ? _value.to! : to,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CandleStateImpl implements _CandleState {
  const _$CandleStateImpl(
      {final List<Candle> candles = const [],
      this.network = "",
      this.tokenAddress = '',
      this.bar = 1,
      this.limit = 800,
      this.from = 0,
      this.to = 0,
      this.isLoading = false})
      : _candles = candles;

  final List<Candle> _candles;
  @override
  @JsonKey()
  List<Candle> get candles {
    if (_candles is EqualUnmodifiableListView) return _candles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_candles);
  }

  @override
  @JsonKey()
  final dynamic network;
  @override
  @JsonKey()
  final dynamic tokenAddress;
  @override
  @JsonKey()
  final dynamic bar;
  @override
  @JsonKey()
  final dynamic limit;
  @override
  @JsonKey()
  final dynamic from;
  @override
  @JsonKey()
  final dynamic to;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'CandleState(candles: $candles, network: $network, tokenAddress: $tokenAddress, bar: $bar, limit: $limit, from: $from, to: $to, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandleStateImpl &&
            const DeepCollectionEquality().equals(other._candles, _candles) &&
            const DeepCollectionEquality().equals(other.network, network) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            const DeepCollectionEquality().equals(other.bar, bar) &&
            const DeepCollectionEquality().equals(other.limit, limit) &&
            const DeepCollectionEquality().equals(other.from, from) &&
            const DeepCollectionEquality().equals(other.to, to) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_candles),
      const DeepCollectionEquality().hash(network),
      const DeepCollectionEquality().hash(tokenAddress),
      const DeepCollectionEquality().hash(bar),
      const DeepCollectionEquality().hash(limit),
      const DeepCollectionEquality().hash(from),
      const DeepCollectionEquality().hash(to),
      isLoading);

  /// Create a copy of CandleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CandleStateImplCopyWith<_$CandleStateImpl> get copyWith =>
      __$$CandleStateImplCopyWithImpl<_$CandleStateImpl>(this, _$identity);
}

abstract class _CandleState implements CandleState {
  const factory _CandleState(
      {final List<Candle> candles,
      final dynamic network,
      final dynamic tokenAddress,
      final dynamic bar,
      final dynamic limit,
      final dynamic from,
      final dynamic to,
      final bool isLoading}) = _$CandleStateImpl;

  @override
  List<Candle> get candles;
  @override
  dynamic get network;
  @override
  dynamic get tokenAddress;
  @override
  dynamic get bar;
  @override
  dynamic get limit;
  @override
  dynamic get from;
  @override
  dynamic get to;
  @override
  bool get isLoading;

  /// Create a copy of CandleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CandleStateImplCopyWith<_$CandleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
