// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenDetailSecurity _$TokenDetailSecurityFromJson(Map<String, dynamic> json) {
  return _TokenDetailSecurity.fromJson(json);
}

/// @nodoc
mixin _$TokenDetailSecurity {
  @JsonKey(name: "contract_analysis")
  List<SecurityItem> get contractAnaly => throw _privateConstructorUsedError;
  @JsonKey(name: "trade_tax")
  TradeTax? get tradeTax => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenDetailSecurityCopyWith<TokenDetailSecurity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDetailSecurityCopyWith<$Res> {
  factory $TokenDetailSecurityCopyWith(
          TokenDetailSecurity value, $Res Function(TokenDetailSecurity) then) =
      _$TokenDetailSecurityCopyWithImpl<$Res, TokenDetailSecurity>;
  @useResult
  $Res call(
      {@JsonKey(name: "contract_analysis") List<SecurityItem> contractAnaly,
      @JsonKey(name: "trade_tax") TradeTax? tradeTax});

  $TradeTaxCopyWith<$Res>? get tradeTax;
}

/// @nodoc
class _$TokenDetailSecurityCopyWithImpl<$Res, $Val extends TokenDetailSecurity>
    implements $TokenDetailSecurityCopyWith<$Res> {
  _$TokenDetailSecurityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractAnaly = null,
    Object? tradeTax = freezed,
  }) {
    return _then(_value.copyWith(
      contractAnaly: null == contractAnaly
          ? _value.contractAnaly
          : contractAnaly // ignore: cast_nullable_to_non_nullable
              as List<SecurityItem>,
      tradeTax: freezed == tradeTax
          ? _value.tradeTax
          : tradeTax // ignore: cast_nullable_to_non_nullable
              as TradeTax?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TradeTaxCopyWith<$Res>? get tradeTax {
    if (_value.tradeTax == null) {
      return null;
    }

    return $TradeTaxCopyWith<$Res>(_value.tradeTax!, (value) {
      return _then(_value.copyWith(tradeTax: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenDetailSecurityImplCopyWith<$Res>
    implements $TokenDetailSecurityCopyWith<$Res> {
  factory _$$TokenDetailSecurityImplCopyWith(_$TokenDetailSecurityImpl value,
          $Res Function(_$TokenDetailSecurityImpl) then) =
      __$$TokenDetailSecurityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "contract_analysis") List<SecurityItem> contractAnaly,
      @JsonKey(name: "trade_tax") TradeTax? tradeTax});

  @override
  $TradeTaxCopyWith<$Res>? get tradeTax;
}

/// @nodoc
class __$$TokenDetailSecurityImplCopyWithImpl<$Res>
    extends _$TokenDetailSecurityCopyWithImpl<$Res, _$TokenDetailSecurityImpl>
    implements _$$TokenDetailSecurityImplCopyWith<$Res> {
  __$$TokenDetailSecurityImplCopyWithImpl(_$TokenDetailSecurityImpl _value,
      $Res Function(_$TokenDetailSecurityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractAnaly = null,
    Object? tradeTax = freezed,
  }) {
    return _then(_$TokenDetailSecurityImpl(
      contractAnaly: null == contractAnaly
          ? _value._contractAnaly
          : contractAnaly // ignore: cast_nullable_to_non_nullable
              as List<SecurityItem>,
      tradeTax: freezed == tradeTax
          ? _value.tradeTax
          : tradeTax // ignore: cast_nullable_to_non_nullable
              as TradeTax?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenDetailSecurityImpl implements _TokenDetailSecurity {
  const _$TokenDetailSecurityImpl(
      {@JsonKey(name: "contract_analysis")
      final List<SecurityItem> contractAnaly = const [],
      @JsonKey(name: "trade_tax") this.tradeTax})
      : _contractAnaly = contractAnaly;

  factory _$TokenDetailSecurityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenDetailSecurityImplFromJson(json);

  final List<SecurityItem> _contractAnaly;
  @override
  @JsonKey(name: "contract_analysis")
  List<SecurityItem> get contractAnaly {
    if (_contractAnaly is EqualUnmodifiableListView) return _contractAnaly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contractAnaly);
  }

  @override
  @JsonKey(name: "trade_tax")
  final TradeTax? tradeTax;

  @override
  String toString() {
    return 'TokenDetailSecurity(contractAnaly: $contractAnaly, tradeTax: $tradeTax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenDetailSecurityImpl &&
            const DeepCollectionEquality()
                .equals(other._contractAnaly, _contractAnaly) &&
            (identical(other.tradeTax, tradeTax) ||
                other.tradeTax == tradeTax));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_contractAnaly), tradeTax);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenDetailSecurityImplCopyWith<_$TokenDetailSecurityImpl> get copyWith =>
      __$$TokenDetailSecurityImplCopyWithImpl<_$TokenDetailSecurityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenDetailSecurityImplToJson(
      this,
    );
  }
}

abstract class _TokenDetailSecurity implements TokenDetailSecurity {
  const factory _TokenDetailSecurity(
          {@JsonKey(name: "contract_analysis")
          final List<SecurityItem> contractAnaly,
          @JsonKey(name: "trade_tax") final TradeTax? tradeTax}) =
      _$TokenDetailSecurityImpl;

  factory _TokenDetailSecurity.fromJson(Map<String, dynamic> json) =
      _$TokenDetailSecurityImpl.fromJson;

  @override
  @JsonKey(name: "contract_analysis")
  List<SecurityItem> get contractAnaly;
  @override
  @JsonKey(name: "trade_tax")
  TradeTax? get tradeTax;
  @override
  @JsonKey(ignore: true)
  _$$TokenDetailSecurityImplCopyWith<_$TokenDetailSecurityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SecurityItem _$SecurityItemFromJson(Map<String, dynamic> json) {
  return _SecurityItem.fromJson(json);
}

/// @nodoc
mixin _$SecurityItem {
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "description")
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "is_safe")
  bool get isSafe => throw _privateConstructorUsedError;
  @JsonKey(name: "type")
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecurityItemCopyWith<SecurityItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityItemCopyWith<$Res> {
  factory $SecurityItemCopyWith(
          SecurityItem value, $Res Function(SecurityItem) then) =
      _$SecurityItemCopyWithImpl<$Res, SecurityItem>;
  @useResult
  $Res call(
      {@JsonKey(name: "title") String title,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "is_safe") bool isSafe,
      @JsonKey(name: "type") String type});
}

/// @nodoc
class _$SecurityItemCopyWithImpl<$Res, $Val extends SecurityItem>
    implements $SecurityItemCopyWith<$Res> {
  _$SecurityItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? isSafe = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isSafe: null == isSafe
          ? _value.isSafe
          : isSafe // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecurityItemImplCopyWith<$Res>
    implements $SecurityItemCopyWith<$Res> {
  factory _$$SecurityItemImplCopyWith(
          _$SecurityItemImpl value, $Res Function(_$SecurityItemImpl) then) =
      __$$SecurityItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "title") String title,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "is_safe") bool isSafe,
      @JsonKey(name: "type") String type});
}

/// @nodoc
class __$$SecurityItemImplCopyWithImpl<$Res>
    extends _$SecurityItemCopyWithImpl<$Res, _$SecurityItemImpl>
    implements _$$SecurityItemImplCopyWith<$Res> {
  __$$SecurityItemImplCopyWithImpl(
      _$SecurityItemImpl _value, $Res Function(_$SecurityItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? isSafe = null,
    Object? type = null,
  }) {
    return _then(_$SecurityItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isSafe: null == isSafe
          ? _value.isSafe
          : isSafe // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecurityItemImpl implements _SecurityItem {
  const _$SecurityItemImpl(
      {@JsonKey(name: "title") required this.title,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "is_safe") required this.isSafe,
      @JsonKey(name: "type") this.type = "risk"});

  factory _$SecurityItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecurityItemImplFromJson(json);

  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "description")
  final String description;
  @override
  @JsonKey(name: "is_safe")
  final bool isSafe;
  @override
  @JsonKey(name: "type")
  final String type;

  @override
  String toString() {
    return 'SecurityItem(title: $title, description: $description, isSafe: $isSafe, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isSafe, isSafe) || other.isSafe == isSafe) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, description, isSafe, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityItemImplCopyWith<_$SecurityItemImpl> get copyWith =>
      __$$SecurityItemImplCopyWithImpl<_$SecurityItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecurityItemImplToJson(
      this,
    );
  }
}

abstract class _SecurityItem implements SecurityItem {
  const factory _SecurityItem(
      {@JsonKey(name: "title") required final String title,
      @JsonKey(name: "description") required final String description,
      @JsonKey(name: "is_safe") required final bool isSafe,
      @JsonKey(name: "type") final String type}) = _$SecurityItemImpl;

  factory _SecurityItem.fromJson(Map<String, dynamic> json) =
      _$SecurityItemImpl.fromJson;

  @override
  @JsonKey(name: "title")
  String get title;
  @override
  @JsonKey(name: "description")
  String get description;
  @override
  @JsonKey(name: "is_safe")
  bool get isSafe;
  @override
  @JsonKey(name: "type")
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$SecurityItemImplCopyWith<_$SecurityItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeTax _$TradeTaxFromJson(Map<String, dynamic> json) {
  return _TradeTax.fromJson(json);
}

/// @nodoc
mixin _$TradeTax {
  @JsonKey(name: "buy_tax")
  String get buyTax => throw _privateConstructorUsedError;
  @JsonKey(name: "sell_tax")
  String get sellTax => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeTaxCopyWith<TradeTax> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeTaxCopyWith<$Res> {
  factory $TradeTaxCopyWith(TradeTax value, $Res Function(TradeTax) then) =
      _$TradeTaxCopyWithImpl<$Res, TradeTax>;
  @useResult
  $Res call(
      {@JsonKey(name: "buy_tax") String buyTax,
      @JsonKey(name: "sell_tax") String sellTax});
}

/// @nodoc
class _$TradeTaxCopyWithImpl<$Res, $Val extends TradeTax>
    implements $TradeTaxCopyWith<$Res> {
  _$TradeTaxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buyTax = null,
    Object? sellTax = null,
  }) {
    return _then(_value.copyWith(
      buyTax: null == buyTax
          ? _value.buyTax
          : buyTax // ignore: cast_nullable_to_non_nullable
              as String,
      sellTax: null == sellTax
          ? _value.sellTax
          : sellTax // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeTaxImplCopyWith<$Res>
    implements $TradeTaxCopyWith<$Res> {
  factory _$$TradeTaxImplCopyWith(
          _$TradeTaxImpl value, $Res Function(_$TradeTaxImpl) then) =
      __$$TradeTaxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "buy_tax") String buyTax,
      @JsonKey(name: "sell_tax") String sellTax});
}

/// @nodoc
class __$$TradeTaxImplCopyWithImpl<$Res>
    extends _$TradeTaxCopyWithImpl<$Res, _$TradeTaxImpl>
    implements _$$TradeTaxImplCopyWith<$Res> {
  __$$TradeTaxImplCopyWithImpl(
      _$TradeTaxImpl _value, $Res Function(_$TradeTaxImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? buyTax = null,
    Object? sellTax = null,
  }) {
    return _then(_$TradeTaxImpl(
      buyTax: null == buyTax
          ? _value.buyTax
          : buyTax // ignore: cast_nullable_to_non_nullable
              as String,
      sellTax: null == sellTax
          ? _value.sellTax
          : sellTax // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeTaxImpl implements _TradeTax {
  const _$TradeTaxImpl(
      {@JsonKey(name: "buy_tax") required this.buyTax,
      @JsonKey(name: "sell_tax") required this.sellTax});

  factory _$TradeTaxImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeTaxImplFromJson(json);

  @override
  @JsonKey(name: "buy_tax")
  final String buyTax;
  @override
  @JsonKey(name: "sell_tax")
  final String sellTax;

  @override
  String toString() {
    return 'TradeTax(buyTax: $buyTax, sellTax: $sellTax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeTaxImpl &&
            (identical(other.buyTax, buyTax) || other.buyTax == buyTax) &&
            (identical(other.sellTax, sellTax) || other.sellTax == sellTax));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, buyTax, sellTax);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeTaxImplCopyWith<_$TradeTaxImpl> get copyWith =>
      __$$TradeTaxImplCopyWithImpl<_$TradeTaxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeTaxImplToJson(
      this,
    );
  }
}

abstract class _TradeTax implements TradeTax {
  const factory _TradeTax(
          {@JsonKey(name: "buy_tax") required final String buyTax,
          @JsonKey(name: "sell_tax") required final String sellTax}) =
      _$TradeTaxImpl;

  factory _TradeTax.fromJson(Map<String, dynamic> json) =
      _$TradeTaxImpl.fromJson;

  @override
  @JsonKey(name: "buy_tax")
  String get buyTax;
  @override
  @JsonKey(name: "sell_tax")
  String get sellTax;
  @override
  @JsonKey(ignore: true)
  _$$TradeTaxImplCopyWith<_$TradeTaxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
