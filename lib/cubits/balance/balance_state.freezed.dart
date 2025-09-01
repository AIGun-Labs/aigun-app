// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BalanceState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Balance? get balances => throw _privateConstructorUsedError;
  bool get hideSmallAssets => throw _privateConstructorUsedError;
  int get selectedChainIndex => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  List<Token> get filteredTokens => throw _privateConstructorUsedError;

  /// Create a copy of BalanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BalanceStateCopyWith<BalanceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BalanceStateCopyWith<$Res> {
  factory $BalanceStateCopyWith(
          BalanceState value, $Res Function(BalanceState) then) =
      _$BalanceStateCopyWithImpl<$Res, BalanceState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool hasError,
      String? errorMessage,
      Balance? balances,
      bool hideSmallAssets,
      int selectedChainIndex,
      String searchQuery,
      List<Token> filteredTokens});

  $BalanceCopyWith<$Res>? get balances;
}

/// @nodoc
class _$BalanceStateCopyWithImpl<$Res, $Val extends BalanceState>
    implements $BalanceStateCopyWith<$Res> {
  _$BalanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BalanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? balances = freezed,
    Object? hideSmallAssets = null,
    Object? selectedChainIndex = null,
    Object? searchQuery = null,
    Object? filteredTokens = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      balances: freezed == balances
          ? _value.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as Balance?,
      hideSmallAssets: null == hideSmallAssets
          ? _value.hideSmallAssets
          : hideSmallAssets // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedChainIndex: null == selectedChainIndex
          ? _value.selectedChainIndex
          : selectedChainIndex // ignore: cast_nullable_to_non_nullable
              as int,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      filteredTokens: null == filteredTokens
          ? _value.filteredTokens
          : filteredTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
    ) as $Val);
  }

  /// Create a copy of BalanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BalanceCopyWith<$Res>? get balances {
    if (_value.balances == null) {
      return null;
    }

    return $BalanceCopyWith<$Res>(_value.balances!, (value) {
      return _then(_value.copyWith(balances: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BalanceStateImplCopyWith<$Res>
    implements $BalanceStateCopyWith<$Res> {
  factory _$$BalanceStateImplCopyWith(
          _$BalanceStateImpl value, $Res Function(_$BalanceStateImpl) then) =
      __$$BalanceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool hasError,
      String? errorMessage,
      Balance? balances,
      bool hideSmallAssets,
      int selectedChainIndex,
      String searchQuery,
      List<Token> filteredTokens});

  @override
  $BalanceCopyWith<$Res>? get balances;
}

/// @nodoc
class __$$BalanceStateImplCopyWithImpl<$Res>
    extends _$BalanceStateCopyWithImpl<$Res, _$BalanceStateImpl>
    implements _$$BalanceStateImplCopyWith<$Res> {
  __$$BalanceStateImplCopyWithImpl(
      _$BalanceStateImpl _value, $Res Function(_$BalanceStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BalanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? balances = freezed,
    Object? hideSmallAssets = null,
    Object? selectedChainIndex = null,
    Object? searchQuery = null,
    Object? filteredTokens = null,
  }) {
    return _then(_$BalanceStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      balances: freezed == balances
          ? _value.balances
          : balances // ignore: cast_nullable_to_non_nullable
              as Balance?,
      hideSmallAssets: null == hideSmallAssets
          ? _value.hideSmallAssets
          : hideSmallAssets // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedChainIndex: null == selectedChainIndex
          ? _value.selectedChainIndex
          : selectedChainIndex // ignore: cast_nullable_to_non_nullable
              as int,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      filteredTokens: null == filteredTokens
          ? _value._filteredTokens
          : filteredTokens // ignore: cast_nullable_to_non_nullable
              as List<Token>,
    ));
  }
}

/// @nodoc

class _$BalanceStateImpl implements _BalanceState {
  const _$BalanceStateImpl(
      {this.isLoading = false,
      this.hasError = false,
      this.errorMessage,
      this.balances,
      this.hideSmallAssets = false,
      this.selectedChainIndex = 0,
      this.searchQuery = '',
      final List<Token> filteredTokens = const []})
      : _filteredTokens = filteredTokens;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasError;
  @override
  final String? errorMessage;
  @override
  final Balance? balances;
  @override
  @JsonKey()
  final bool hideSmallAssets;
  @override
  @JsonKey()
  final int selectedChainIndex;
  @override
  @JsonKey()
  final String searchQuery;
  final List<Token> _filteredTokens;
  @override
  @JsonKey()
  List<Token> get filteredTokens {
    if (_filteredTokens is EqualUnmodifiableListView) return _filteredTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTokens);
  }

  @override
  String toString() {
    return 'BalanceState(isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, balances: $balances, hideSmallAssets: $hideSmallAssets, selectedChainIndex: $selectedChainIndex, searchQuery: $searchQuery, filteredTokens: $filteredTokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BalanceStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.balances, balances) ||
                other.balances == balances) &&
            (identical(other.hideSmallAssets, hideSmallAssets) ||
                other.hideSmallAssets == hideSmallAssets) &&
            (identical(other.selectedChainIndex, selectedChainIndex) ||
                other.selectedChainIndex == selectedChainIndex) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality()
                .equals(other._filteredTokens, _filteredTokens));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      hasError,
      errorMessage,
      balances,
      hideSmallAssets,
      selectedChainIndex,
      searchQuery,
      const DeepCollectionEquality().hash(_filteredTokens));

  /// Create a copy of BalanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BalanceStateImplCopyWith<_$BalanceStateImpl> get copyWith =>
      __$$BalanceStateImplCopyWithImpl<_$BalanceStateImpl>(this, _$identity);
}

abstract class _BalanceState implements BalanceState {
  const factory _BalanceState(
      {final bool isLoading,
      final bool hasError,
      final String? errorMessage,
      final Balance? balances,
      final bool hideSmallAssets,
      final int selectedChainIndex,
      final String searchQuery,
      final List<Token> filteredTokens}) = _$BalanceStateImpl;

  @override
  bool get isLoading;
  @override
  bool get hasError;
  @override
  String? get errorMessage;
  @override
  Balance? get balances;
  @override
  bool get hideSmallAssets;
  @override
  int get selectedChainIndex;
  @override
  String get searchQuery;
  @override
  List<Token> get filteredTokens;

  /// Create a copy of BalanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BalanceStateImplCopyWith<_$BalanceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
