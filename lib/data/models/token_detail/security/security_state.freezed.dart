// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenDetailSecurity {

@JsonKey(name: 'contract_analysis') List<SecurityItem> get contractAnaly;@JsonKey(name: 'trade_tax') TradeTax? get tradeTax;
/// Create a copy of TokenDetailSecurity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenDetailSecurityCopyWith<TokenDetailSecurity> get copyWith => _$TokenDetailSecurityCopyWithImpl<TokenDetailSecurity>(this as TokenDetailSecurity, _$identity);

  /// Serializes this TokenDetailSecurity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenDetailSecurity&&const DeepCollectionEquality().equals(other.contractAnaly, contractAnaly)&&(identical(other.tradeTax, tradeTax) || other.tradeTax == tradeTax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(contractAnaly),tradeTax);

@override
String toString() {
  return 'TokenDetailSecurity(contractAnaly: $contractAnaly, tradeTax: $tradeTax)';
}


}

/// @nodoc
abstract mixin class $TokenDetailSecurityCopyWith<$Res>  {
  factory $TokenDetailSecurityCopyWith(TokenDetailSecurity value, $Res Function(TokenDetailSecurity) _then) = _$TokenDetailSecurityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'contract_analysis') List<SecurityItem> contractAnaly,@JsonKey(name: 'trade_tax') TradeTax? tradeTax
});


$TradeTaxCopyWith<$Res>? get tradeTax;

}
/// @nodoc
class _$TokenDetailSecurityCopyWithImpl<$Res>
    implements $TokenDetailSecurityCopyWith<$Res> {
  _$TokenDetailSecurityCopyWithImpl(this._self, this._then);

  final TokenDetailSecurity _self;
  final $Res Function(TokenDetailSecurity) _then;

/// Create a copy of TokenDetailSecurity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contractAnaly = null,Object? tradeTax = freezed,}) {
  return _then(_self.copyWith(
contractAnaly: null == contractAnaly ? _self.contractAnaly : contractAnaly // ignore: cast_nullable_to_non_nullable
as List<SecurityItem>,tradeTax: freezed == tradeTax ? _self.tradeTax : tradeTax // ignore: cast_nullable_to_non_nullable
as TradeTax?,
  ));
}
/// Create a copy of TokenDetailSecurity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeTaxCopyWith<$Res>? get tradeTax {
    if (_self.tradeTax == null) {
    return null;
  }

  return $TradeTaxCopyWith<$Res>(_self.tradeTax!, (value) {
    return _then(_self.copyWith(tradeTax: value));
  });
}
}


/// Adds pattern-matching-related methods to [TokenDetailSecurity].
extension TokenDetailSecurityPatterns on TokenDetailSecurity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenDetailSecurity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenDetailSecurity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenDetailSecurity value)  $default,){
final _that = this;
switch (_that) {
case _TokenDetailSecurity():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenDetailSecurity value)?  $default,){
final _that = this;
switch (_that) {
case _TokenDetailSecurity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'contract_analysis')  List<SecurityItem> contractAnaly, @JsonKey(name: 'trade_tax')  TradeTax? tradeTax)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenDetailSecurity() when $default != null:
return $default(_that.contractAnaly,_that.tradeTax);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'contract_analysis')  List<SecurityItem> contractAnaly, @JsonKey(name: 'trade_tax')  TradeTax? tradeTax)  $default,) {final _that = this;
switch (_that) {
case _TokenDetailSecurity():
return $default(_that.contractAnaly,_that.tradeTax);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'contract_analysis')  List<SecurityItem> contractAnaly, @JsonKey(name: 'trade_tax')  TradeTax? tradeTax)?  $default,) {final _that = this;
switch (_that) {
case _TokenDetailSecurity() when $default != null:
return $default(_that.contractAnaly,_that.tradeTax);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenDetailSecurity implements TokenDetailSecurity {
  const _TokenDetailSecurity({@JsonKey(name: 'contract_analysis') final  List<SecurityItem> contractAnaly = const [], @JsonKey(name: 'trade_tax') this.tradeTax}): _contractAnaly = contractAnaly;
  factory _TokenDetailSecurity.fromJson(Map<String, dynamic> json) => _$TokenDetailSecurityFromJson(json);

 final  List<SecurityItem> _contractAnaly;
@override@JsonKey(name: 'contract_analysis') List<SecurityItem> get contractAnaly {
  if (_contractAnaly is EqualUnmodifiableListView) return _contractAnaly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contractAnaly);
}

@override@JsonKey(name: 'trade_tax') final  TradeTax? tradeTax;

/// Create a copy of TokenDetailSecurity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenDetailSecurityCopyWith<_TokenDetailSecurity> get copyWith => __$TokenDetailSecurityCopyWithImpl<_TokenDetailSecurity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenDetailSecurityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenDetailSecurity&&const DeepCollectionEquality().equals(other._contractAnaly, _contractAnaly)&&(identical(other.tradeTax, tradeTax) || other.tradeTax == tradeTax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_contractAnaly),tradeTax);

@override
String toString() {
  return 'TokenDetailSecurity(contractAnaly: $contractAnaly, tradeTax: $tradeTax)';
}


}

/// @nodoc
abstract mixin class _$TokenDetailSecurityCopyWith<$Res> implements $TokenDetailSecurityCopyWith<$Res> {
  factory _$TokenDetailSecurityCopyWith(_TokenDetailSecurity value, $Res Function(_TokenDetailSecurity) _then) = __$TokenDetailSecurityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'contract_analysis') List<SecurityItem> contractAnaly,@JsonKey(name: 'trade_tax') TradeTax? tradeTax
});


@override $TradeTaxCopyWith<$Res>? get tradeTax;

}
/// @nodoc
class __$TokenDetailSecurityCopyWithImpl<$Res>
    implements _$TokenDetailSecurityCopyWith<$Res> {
  __$TokenDetailSecurityCopyWithImpl(this._self, this._then);

  final _TokenDetailSecurity _self;
  final $Res Function(_TokenDetailSecurity) _then;

/// Create a copy of TokenDetailSecurity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contractAnaly = null,Object? tradeTax = freezed,}) {
  return _then(_TokenDetailSecurity(
contractAnaly: null == contractAnaly ? _self._contractAnaly : contractAnaly // ignore: cast_nullable_to_non_nullable
as List<SecurityItem>,tradeTax: freezed == tradeTax ? _self.tradeTax : tradeTax // ignore: cast_nullable_to_non_nullable
as TradeTax?,
  ));
}

/// Create a copy of TokenDetailSecurity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TradeTaxCopyWith<$Res>? get tradeTax {
    if (_self.tradeTax == null) {
    return null;
  }

  return $TradeTaxCopyWith<$Res>(_self.tradeTax!, (value) {
    return _then(_self.copyWith(tradeTax: value));
  });
}
}


/// @nodoc
mixin _$SecurityItem {

@JsonKey(name: 'title') Multilingual? get title;@JsonKey(name: 'description') Multilingual? get description;@JsonKey(name: 'is_safe', defaultValue: false) bool get isSafe;@JsonKey(name: 'type') String? get type;
/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityItemCopyWith<SecurityItem> get copyWith => _$SecurityItemCopyWithImpl<SecurityItem>(this as SecurityItem, _$identity);

  /// Serializes this SecurityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSafe, isSafe) || other.isSafe == isSafe)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,isSafe,type);

@override
String toString() {
  return 'SecurityItem(title: $title, description: $description, isSafe: $isSafe, type: $type)';
}


}

/// @nodoc
abstract mixin class $SecurityItemCopyWith<$Res>  {
  factory $SecurityItemCopyWith(SecurityItem value, $Res Function(SecurityItem) _then) = _$SecurityItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'title') Multilingual? title,@JsonKey(name: 'description') Multilingual? description,@JsonKey(name: 'is_safe', defaultValue: false) bool isSafe,@JsonKey(name: 'type') String? type
});


$MultilingualCopyWith<$Res>? get title;$MultilingualCopyWith<$Res>? get description;

}
/// @nodoc
class _$SecurityItemCopyWithImpl<$Res>
    implements $SecurityItemCopyWith<$Res> {
  _$SecurityItemCopyWithImpl(this._self, this._then);

  final SecurityItem _self;
  final $Res Function(SecurityItem) _then;

/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? isSafe = null,Object? type = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Multilingual?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as Multilingual?,isSafe: null == isSafe ? _self.isSafe : isSafe // ignore: cast_nullable_to_non_nullable
as bool,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get title {
    if (_self.title == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.title!, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}


/// Adds pattern-matching-related methods to [SecurityItem].
extension SecurityItemPatterns on SecurityItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityItem value)  $default,){
final _that = this;
switch (_that) {
case _SecurityItem():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityItem value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'title')  Multilingual? title, @JsonKey(name: 'description')  Multilingual? description, @JsonKey(name: 'is_safe', defaultValue: false)  bool isSafe, @JsonKey(name: 'type')  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityItem() when $default != null:
return $default(_that.title,_that.description,_that.isSafe,_that.type);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'title')  Multilingual? title, @JsonKey(name: 'description')  Multilingual? description, @JsonKey(name: 'is_safe', defaultValue: false)  bool isSafe, @JsonKey(name: 'type')  String? type)  $default,) {final _that = this;
switch (_that) {
case _SecurityItem():
return $default(_that.title,_that.description,_that.isSafe,_that.type);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'title')  Multilingual? title, @JsonKey(name: 'description')  Multilingual? description, @JsonKey(name: 'is_safe', defaultValue: false)  bool isSafe, @JsonKey(name: 'type')  String? type)?  $default,) {final _that = this;
switch (_that) {
case _SecurityItem() when $default != null:
return $default(_that.title,_that.description,_that.isSafe,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SecurityItem implements SecurityItem {
  const _SecurityItem({@JsonKey(name: 'title') this.title, @JsonKey(name: 'description') this.description, @JsonKey(name: 'is_safe', defaultValue: false) required this.isSafe, @JsonKey(name: 'type') this.type = 'risk'});
  factory _SecurityItem.fromJson(Map<String, dynamic> json) => _$SecurityItemFromJson(json);

@override@JsonKey(name: 'title') final  Multilingual? title;
@override@JsonKey(name: 'description') final  Multilingual? description;
@override@JsonKey(name: 'is_safe', defaultValue: false) final  bool isSafe;
@override@JsonKey(name: 'type') final  String? type;

/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityItemCopyWith<_SecurityItem> get copyWith => __$SecurityItemCopyWithImpl<_SecurityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecurityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSafe, isSafe) || other.isSafe == isSafe)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,isSafe,type);

@override
String toString() {
  return 'SecurityItem(title: $title, description: $description, isSafe: $isSafe, type: $type)';
}


}

/// @nodoc
abstract mixin class _$SecurityItemCopyWith<$Res> implements $SecurityItemCopyWith<$Res> {
  factory _$SecurityItemCopyWith(_SecurityItem value, $Res Function(_SecurityItem) _then) = __$SecurityItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'title') Multilingual? title,@JsonKey(name: 'description') Multilingual? description,@JsonKey(name: 'is_safe', defaultValue: false) bool isSafe,@JsonKey(name: 'type') String? type
});


@override $MultilingualCopyWith<$Res>? get title;@override $MultilingualCopyWith<$Res>? get description;

}
/// @nodoc
class __$SecurityItemCopyWithImpl<$Res>
    implements _$SecurityItemCopyWith<$Res> {
  __$SecurityItemCopyWithImpl(this._self, this._then);

  final _SecurityItem _self;
  final $Res Function(_SecurityItem) _then;

/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? isSafe = null,Object? type = freezed,}) {
  return _then(_SecurityItem(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as Multilingual?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as Multilingual?,isSafe: null == isSafe ? _self.isSafe : isSafe // ignore: cast_nullable_to_non_nullable
as bool,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get title {
    if (_self.title == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.title!, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SecurityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MultilingualCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $MultilingualCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}
}


/// @nodoc
mixin _$TradeTax {

@JsonKey(name: 'buy_tax') String get buyTax;@JsonKey(name: 'sell_tax') String get sellTax;
/// Create a copy of TradeTax
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TradeTaxCopyWith<TradeTax> get copyWith => _$TradeTaxCopyWithImpl<TradeTax>(this as TradeTax, _$identity);

  /// Serializes this TradeTax to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TradeTax&&(identical(other.buyTax, buyTax) || other.buyTax == buyTax)&&(identical(other.sellTax, sellTax) || other.sellTax == sellTax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buyTax,sellTax);

@override
String toString() {
  return 'TradeTax(buyTax: $buyTax, sellTax: $sellTax)';
}


}

/// @nodoc
abstract mixin class $TradeTaxCopyWith<$Res>  {
  factory $TradeTaxCopyWith(TradeTax value, $Res Function(TradeTax) _then) = _$TradeTaxCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'buy_tax') String buyTax,@JsonKey(name: 'sell_tax') String sellTax
});




}
/// @nodoc
class _$TradeTaxCopyWithImpl<$Res>
    implements $TradeTaxCopyWith<$Res> {
  _$TradeTaxCopyWithImpl(this._self, this._then);

  final TradeTax _self;
  final $Res Function(TradeTax) _then;

/// Create a copy of TradeTax
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buyTax = null,Object? sellTax = null,}) {
  return _then(_self.copyWith(
buyTax: null == buyTax ? _self.buyTax : buyTax // ignore: cast_nullable_to_non_nullable
as String,sellTax: null == sellTax ? _self.sellTax : sellTax // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TradeTax].
extension TradeTaxPatterns on TradeTax {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TradeTax value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TradeTax() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TradeTax value)  $default,){
final _that = this;
switch (_that) {
case _TradeTax():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TradeTax value)?  $default,){
final _that = this;
switch (_that) {
case _TradeTax() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'buy_tax')  String buyTax, @JsonKey(name: 'sell_tax')  String sellTax)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TradeTax() when $default != null:
return $default(_that.buyTax,_that.sellTax);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'buy_tax')  String buyTax, @JsonKey(name: 'sell_tax')  String sellTax)  $default,) {final _that = this;
switch (_that) {
case _TradeTax():
return $default(_that.buyTax,_that.sellTax);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'buy_tax')  String buyTax, @JsonKey(name: 'sell_tax')  String sellTax)?  $default,) {final _that = this;
switch (_that) {
case _TradeTax() when $default != null:
return $default(_that.buyTax,_that.sellTax);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TradeTax implements TradeTax {
  const _TradeTax({@JsonKey(name: 'buy_tax') required this.buyTax, @JsonKey(name: 'sell_tax') required this.sellTax});
  factory _TradeTax.fromJson(Map<String, dynamic> json) => _$TradeTaxFromJson(json);

@override@JsonKey(name: 'buy_tax') final  String buyTax;
@override@JsonKey(name: 'sell_tax') final  String sellTax;

/// Create a copy of TradeTax
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TradeTaxCopyWith<_TradeTax> get copyWith => __$TradeTaxCopyWithImpl<_TradeTax>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TradeTaxToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TradeTax&&(identical(other.buyTax, buyTax) || other.buyTax == buyTax)&&(identical(other.sellTax, sellTax) || other.sellTax == sellTax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buyTax,sellTax);

@override
String toString() {
  return 'TradeTax(buyTax: $buyTax, sellTax: $sellTax)';
}


}

/// @nodoc
abstract mixin class _$TradeTaxCopyWith<$Res> implements $TradeTaxCopyWith<$Res> {
  factory _$TradeTaxCopyWith(_TradeTax value, $Res Function(_TradeTax) _then) = __$TradeTaxCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'buy_tax') String buyTax,@JsonKey(name: 'sell_tax') String sellTax
});




}
/// @nodoc
class __$TradeTaxCopyWithImpl<$Res>
    implements _$TradeTaxCopyWith<$Res> {
  __$TradeTaxCopyWithImpl(this._self, this._then);

  final _TradeTax _self;
  final $Res Function(_TradeTax) _then;

/// Create a copy of TradeTax
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buyTax = null,Object? sellTax = null,}) {
  return _then(_TradeTax(
buyTax: null == buyTax ? _self.buyTax : buyTax // ignore: cast_nullable_to_non_nullable
as String,sellTax: null == sellTax ? _self.sellTax : sellTax // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
