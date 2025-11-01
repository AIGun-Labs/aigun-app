// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeLiveData _$TradeLiveDataFromJson(Map<String, dynamic> json) {
  return _TradeLiveData.fromJson(json);
}

/// @nodoc
mixin _$TradeLiveData {
  @JsonKey(name: "priority_fee")
  String? get priorityFee => throw _privateConstructorUsedError;
  @JsonKey(name: "tip_fee")
  String? get tipFee => throw _privateConstructorUsedError;
  @JsonKey(name: "gas_price")
  String? get gasPrice => throw _privateConstructorUsedError;

  /// Serializes this TradeLiveData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeLiveData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeLiveDataCopyWith<TradeLiveData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeLiveDataCopyWith<$Res> {
  factory $TradeLiveDataCopyWith(
          TradeLiveData value, $Res Function(TradeLiveData) then) =
      _$TradeLiveDataCopyWithImpl<$Res, TradeLiveData>;
  @useResult
  $Res call(
      {@JsonKey(name: "priority_fee") String? priorityFee,
      @JsonKey(name: "tip_fee") String? tipFee,
      @JsonKey(name: "gas_price") String? gasPrice});
}

/// @nodoc
class _$TradeLiveDataCopyWithImpl<$Res, $Val extends TradeLiveData>
    implements $TradeLiveDataCopyWith<$Res> {
  _$TradeLiveDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeLiveData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityFee = freezed,
    Object? tipFee = freezed,
    Object? gasPrice = freezed,
  }) {
    return _then(_value.copyWith(
      priorityFee: freezed == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as String?,
      tipFee: freezed == tipFee
          ? _value.tipFee
          : tipFee // ignore: cast_nullable_to_non_nullable
              as String?,
      gasPrice: freezed == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeLiveDataImplCopyWith<$Res>
    implements $TradeLiveDataCopyWith<$Res> {
  factory _$$TradeLiveDataImplCopyWith(
          _$TradeLiveDataImpl value, $Res Function(_$TradeLiveDataImpl) then) =
      __$$TradeLiveDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "priority_fee") String? priorityFee,
      @JsonKey(name: "tip_fee") String? tipFee,
      @JsonKey(name: "gas_price") String? gasPrice});
}

/// @nodoc
class __$$TradeLiveDataImplCopyWithImpl<$Res>
    extends _$TradeLiveDataCopyWithImpl<$Res, _$TradeLiveDataImpl>
    implements _$$TradeLiveDataImplCopyWith<$Res> {
  __$$TradeLiveDataImplCopyWithImpl(
      _$TradeLiveDataImpl _value, $Res Function(_$TradeLiveDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeLiveData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priorityFee = freezed,
    Object? tipFee = freezed,
    Object? gasPrice = freezed,
  }) {
    return _then(_$TradeLiveDataImpl(
      priorityFee: freezed == priorityFee
          ? _value.priorityFee
          : priorityFee // ignore: cast_nullable_to_non_nullable
              as String?,
      tipFee: freezed == tipFee
          ? _value.tipFee
          : tipFee // ignore: cast_nullable_to_non_nullable
              as String?,
      gasPrice: freezed == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeLiveDataImpl implements _TradeLiveData {
  const _$TradeLiveDataImpl(
      {@JsonKey(name: "priority_fee") this.priorityFee,
      @JsonKey(name: "tip_fee") this.tipFee,
      @JsonKey(name: "gas_price") this.gasPrice});

  factory _$TradeLiveDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeLiveDataImplFromJson(json);

  @override
  @JsonKey(name: "priority_fee")
  final String? priorityFee;
  @override
  @JsonKey(name: "tip_fee")
  final String? tipFee;
  @override
  @JsonKey(name: "gas_price")
  final String? gasPrice;

  @override
  String toString() {
    return 'TradeLiveData(priorityFee: $priorityFee, tipFee: $tipFee, gasPrice: $gasPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeLiveDataImpl &&
            (identical(other.priorityFee, priorityFee) ||
                other.priorityFee == priorityFee) &&
            (identical(other.tipFee, tipFee) || other.tipFee == tipFee) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, priorityFee, tipFee, gasPrice);

  /// Create a copy of TradeLiveData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeLiveDataImplCopyWith<_$TradeLiveDataImpl> get copyWith =>
      __$$TradeLiveDataImplCopyWithImpl<_$TradeLiveDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeLiveDataImplToJson(
      this,
    );
  }
}

abstract class _TradeLiveData implements TradeLiveData {
  const factory _TradeLiveData(
          {@JsonKey(name: "priority_fee") final String? priorityFee,
          @JsonKey(name: "tip_fee") final String? tipFee,
          @JsonKey(name: "gas_price") final String? gasPrice}) =
      _$TradeLiveDataImpl;

  factory _TradeLiveData.fromJson(Map<String, dynamic> json) =
      _$TradeLiveDataImpl.fromJson;

  @override
  @JsonKey(name: "priority_fee")
  String? get priorityFee;
  @override
  @JsonKey(name: "tip_fee")
  String? get tipFee;
  @override
  @JsonKey(name: "gas_price")
  String? get gasPrice;

  /// Create a copy of TradeLiveData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeLiveDataImplCopyWith<_$TradeLiveDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
