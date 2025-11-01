// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfit _$UserProfitFromJson(Map<String, dynamic> json) {
  return _UserProfit.fromJson(json);
}

/// @nodoc
mixin _$UserProfit {
  @JsonKey(name: "balance")
  String get balance => throw _privateConstructorUsedError;
  @JsonKey(name: "value")
  String get value => throw _privateConstructorUsedError;
  @JsonKey(name: "profit")
  String get profit => throw _privateConstructorUsedError;
  @JsonKey(name: "rise_fall")
  String get riseFall => throw _privateConstructorUsedError;

  /// Serializes this UserProfit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfitCopyWith<UserProfit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfitCopyWith<$Res> {
  factory $UserProfitCopyWith(
          UserProfit value, $Res Function(UserProfit) then) =
      _$UserProfitCopyWithImpl<$Res, UserProfit>;
  @useResult
  $Res call(
      {@JsonKey(name: "balance") String balance,
      @JsonKey(name: "value") String value,
      @JsonKey(name: "profit") String profit,
      @JsonKey(name: "rise_fall") String riseFall});
}

/// @nodoc
class _$UserProfitCopyWithImpl<$Res, $Val extends UserProfit>
    implements $UserProfitCopyWith<$Res> {
  _$UserProfitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? value = null,
    Object? profit = null,
    Object? riseFall = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as String,
      riseFall: null == riseFall
          ? _value.riseFall
          : riseFall // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfitImplCopyWith<$Res>
    implements $UserProfitCopyWith<$Res> {
  factory _$$UserProfitImplCopyWith(
          _$UserProfitImpl value, $Res Function(_$UserProfitImpl) then) =
      __$$UserProfitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "balance") String balance,
      @JsonKey(name: "value") String value,
      @JsonKey(name: "profit") String profit,
      @JsonKey(name: "rise_fall") String riseFall});
}

/// @nodoc
class __$$UserProfitImplCopyWithImpl<$Res>
    extends _$UserProfitCopyWithImpl<$Res, _$UserProfitImpl>
    implements _$$UserProfitImplCopyWith<$Res> {
  __$$UserProfitImplCopyWithImpl(
      _$UserProfitImpl _value, $Res Function(_$UserProfitImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? value = null,
    Object? profit = null,
    Object? riseFall = null,
  }) {
    return _then(_$UserProfitImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as String,
      riseFall: null == riseFall
          ? _value.riseFall
          : riseFall // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfitImpl implements _UserProfit {
  const _$UserProfitImpl(
      {@JsonKey(name: "balance") required this.balance,
      @JsonKey(name: "value") required this.value,
      @JsonKey(name: "profit") required this.profit,
      @JsonKey(name: "rise_fall") required this.riseFall});

  factory _$UserProfitImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfitImplFromJson(json);

  @override
  @JsonKey(name: "balance")
  final String balance;
  @override
  @JsonKey(name: "value")
  final String value;
  @override
  @JsonKey(name: "profit")
  final String profit;
  @override
  @JsonKey(name: "rise_fall")
  final String riseFall;

  @override
  String toString() {
    return 'UserProfit(balance: $balance, value: $value, profit: $profit, riseFall: $riseFall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfitImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.profit, profit) || other.profit == profit) &&
            (identical(other.riseFall, riseFall) ||
                other.riseFall == riseFall));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, balance, value, profit, riseFall);

  /// Create a copy of UserProfit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfitImplCopyWith<_$UserProfitImpl> get copyWith =>
      __$$UserProfitImplCopyWithImpl<_$UserProfitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfitImplToJson(
      this,
    );
  }
}

abstract class _UserProfit implements UserProfit {
  const factory _UserProfit(
          {@JsonKey(name: "balance") required final String balance,
          @JsonKey(name: "value") required final String value,
          @JsonKey(name: "profit") required final String profit,
          @JsonKey(name: "rise_fall") required final String riseFall}) =
      _$UserProfitImpl;

  factory _UserProfit.fromJson(Map<String, dynamic> json) =
      _$UserProfitImpl.fromJson;

  @override
  @JsonKey(name: "balance")
  String get balance;
  @override
  @JsonKey(name: "value")
  String get value;
  @override
  @JsonKey(name: "profit")
  String get profit;
  @override
  @JsonKey(name: "rise_fall")
  String get riseFall;

  /// Create a copy of UserProfit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfitImplCopyWith<_$UserProfitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
