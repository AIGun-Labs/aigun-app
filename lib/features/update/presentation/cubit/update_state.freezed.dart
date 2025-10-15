// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateStateCopyWith<$Res> {
  factory $UpdateStateCopyWith(
          UpdateState value, $Res Function(UpdateState) then) =
      _$UpdateStateCopyWithImpl<$Res, UpdateState>;
}

/// @nodoc
class _$UpdateStateCopyWithImpl<$Res, $Val extends UpdateState>
    implements $UpdateStateCopyWith<$Res> {
  _$UpdateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UpdateInitialImplCopyWith<$Res> {
  factory _$$UpdateInitialImplCopyWith(
          _$UpdateInitialImpl value, $Res Function(_$UpdateInitialImpl) then) =
      __$$UpdateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateInitialImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateInitialImpl>
    implements _$$UpdateInitialImplCopyWith<$Res> {
  __$$UpdateInitialImplCopyWithImpl(
      _$UpdateInitialImpl _value, $Res Function(_$UpdateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateInitialImpl implements UpdateInitial {
  const _$UpdateInitialImpl();

  @override
  String toString() {
    return 'UpdateState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class UpdateInitial implements UpdateState {
  const factory UpdateInitial() = _$UpdateInitialImpl;
}

/// @nodoc
abstract class _$$UpdateCheckingImplCopyWith<$Res> {
  factory _$$UpdateCheckingImplCopyWith(_$UpdateCheckingImpl value,
          $Res Function(_$UpdateCheckingImpl) then) =
      __$$UpdateCheckingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateCheckingImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateCheckingImpl>
    implements _$$UpdateCheckingImplCopyWith<$Res> {
  __$$UpdateCheckingImplCopyWithImpl(
      _$UpdateCheckingImpl _value, $Res Function(_$UpdateCheckingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateCheckingImpl implements UpdateChecking {
  const _$UpdateCheckingImpl();

  @override
  String toString() {
    return 'UpdateState.checking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateCheckingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return checking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return checking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return checking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return checking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking(this);
    }
    return orElse();
  }
}

abstract class UpdateChecking implements UpdateState {
  const factory UpdateChecking() = _$UpdateCheckingImpl;
}

/// @nodoc
abstract class _$$UpdateNoUpdateImplCopyWith<$Res> {
  factory _$$UpdateNoUpdateImplCopyWith(_$UpdateNoUpdateImpl value,
          $Res Function(_$UpdateNoUpdateImpl) then) =
      __$$UpdateNoUpdateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateNoUpdateImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateNoUpdateImpl>
    implements _$$UpdateNoUpdateImplCopyWith<$Res> {
  __$$UpdateNoUpdateImplCopyWithImpl(
      _$UpdateNoUpdateImpl _value, $Res Function(_$UpdateNoUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateNoUpdateImpl implements UpdateNoUpdate {
  const _$UpdateNoUpdateImpl();

  @override
  String toString() {
    return 'UpdateState.noUpdate()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateNoUpdateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return noUpdate();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return noUpdate?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (noUpdate != null) {
      return noUpdate();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return noUpdate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return noUpdate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (noUpdate != null) {
      return noUpdate(this);
    }
    return orElse();
  }
}

abstract class UpdateNoUpdate implements UpdateState {
  const factory UpdateNoUpdate() = _$UpdateNoUpdateImpl;
}

/// @nodoc
abstract class _$$UpdateAvailableImplCopyWith<$Res> {
  factory _$$UpdateAvailableImplCopyWith(_$UpdateAvailableImpl value,
          $Res Function(_$UpdateAvailableImpl) then) =
      __$$UpdateAvailableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateInfo info, bool force});

  $UpdateInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$UpdateAvailableImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateAvailableImpl>
    implements _$$UpdateAvailableImplCopyWith<$Res> {
  __$$UpdateAvailableImplCopyWithImpl(
      _$UpdateAvailableImpl _value, $Res Function(_$UpdateAvailableImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? force = null,
  }) {
    return _then(_$UpdateAvailableImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
      force: null == force
          ? _value.force
          : force // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get info {
    return $UpdateInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$UpdateAvailableImpl implements UpdateAvailable {
  const _$UpdateAvailableImpl({required this.info, required this.force});

  @override
  final UpdateInfo info;
  @override
  final bool force;

  @override
  String toString() {
    return 'UpdateState.available(info: $info, force: $force)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAvailableImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.force, force) || other.force == force));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info, force);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAvailableImplCopyWith<_$UpdateAvailableImpl> get copyWith =>
      __$$UpdateAvailableImplCopyWithImpl<_$UpdateAvailableImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return available(info, force);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return available?.call(info, force);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(info, force);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return available(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return available?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(this);
    }
    return orElse();
  }
}

abstract class UpdateAvailable implements UpdateState {
  const factory UpdateAvailable(
      {required final UpdateInfo info,
      required final bool force}) = _$UpdateAvailableImpl;

  UpdateInfo get info;
  bool get force;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateAvailableImplCopyWith<_$UpdateAvailableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDownloadingImplCopyWith<$Res> {
  factory _$$UpdateDownloadingImplCopyWith(_$UpdateDownloadingImpl value,
          $Res Function(_$UpdateDownloadingImpl) then) =
      __$$UpdateDownloadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateInfo info, double progress});

  $UpdateInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$UpdateDownloadingImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateDownloadingImpl>
    implements _$$UpdateDownloadingImplCopyWith<$Res> {
  __$$UpdateDownloadingImplCopyWithImpl(_$UpdateDownloadingImpl _value,
      $Res Function(_$UpdateDownloadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? progress = null,
  }) {
    return _then(_$UpdateDownloadingImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get info {
    return $UpdateInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$UpdateDownloadingImpl implements UpdateDownloading {
  const _$UpdateDownloadingImpl({required this.info, required this.progress});

  @override
  final UpdateInfo info;
  @override
  final double progress;

  @override
  String toString() {
    return 'UpdateState.downloading(info: $info, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDownloadingImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info, progress);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDownloadingImplCopyWith<_$UpdateDownloadingImpl> get copyWith =>
      __$$UpdateDownloadingImplCopyWithImpl<_$UpdateDownloadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return downloading(info, progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return downloading?.call(info, progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (downloading != null) {
      return downloading(info, progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return downloading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return downloading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (downloading != null) {
      return downloading(this);
    }
    return orElse();
  }
}

abstract class UpdateDownloading implements UpdateState {
  const factory UpdateDownloading(
      {required final UpdateInfo info,
      required final double progress}) = _$UpdateDownloadingImpl;

  UpdateInfo get info;
  double get progress;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDownloadingImplCopyWith<_$UpdateDownloadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePausedImplCopyWith<$Res> {
  factory _$$UpdatePausedImplCopyWith(
          _$UpdatePausedImpl value, $Res Function(_$UpdatePausedImpl) then) =
      __$$UpdatePausedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateInfo info, double progress});

  $UpdateInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$UpdatePausedImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdatePausedImpl>
    implements _$$UpdatePausedImplCopyWith<$Res> {
  __$$UpdatePausedImplCopyWithImpl(
      _$UpdatePausedImpl _value, $Res Function(_$UpdatePausedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? progress = null,
  }) {
    return _then(_$UpdatePausedImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get info {
    return $UpdateInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$UpdatePausedImpl implements UpdatePaused {
  const _$UpdatePausedImpl({required this.info, required this.progress});

  @override
  final UpdateInfo info;
  @override
  final double progress;

  @override
  String toString() {
    return 'UpdateState.paused(info: $info, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePausedImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info, progress);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePausedImplCopyWith<_$UpdatePausedImpl> get copyWith =>
      __$$UpdatePausedImplCopyWithImpl<_$UpdatePausedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return paused(info, progress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return paused?.call(info, progress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(info, progress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class UpdatePaused implements UpdateState {
  const factory UpdatePaused(
      {required final UpdateInfo info,
      required final double progress}) = _$UpdatePausedImpl;

  UpdateInfo get info;
  double get progress;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePausedImplCopyWith<_$UpdatePausedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateVerifyingImplCopyWith<$Res> {
  factory _$$UpdateVerifyingImplCopyWith(_$UpdateVerifyingImpl value,
          $Res Function(_$UpdateVerifyingImpl) then) =
      __$$UpdateVerifyingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateInfo info});

  $UpdateInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$UpdateVerifyingImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateVerifyingImpl>
    implements _$$UpdateVerifyingImplCopyWith<$Res> {
  __$$UpdateVerifyingImplCopyWithImpl(
      _$UpdateVerifyingImpl _value, $Res Function(_$UpdateVerifyingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$UpdateVerifyingImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
    ));
  }

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get info {
    return $UpdateInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$UpdateVerifyingImpl implements UpdateVerifying {
  const _$UpdateVerifyingImpl({required this.info});

  @override
  final UpdateInfo info;

  @override
  String toString() {
    return 'UpdateState.verifying(info: $info)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateVerifyingImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateVerifyingImplCopyWith<_$UpdateVerifyingImpl> get copyWith =>
      __$$UpdateVerifyingImplCopyWithImpl<_$UpdateVerifyingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return verifying(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return verifying?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (verifying != null) {
      return verifying(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return verifying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return verifying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (verifying != null) {
      return verifying(this);
    }
    return orElse();
  }
}

abstract class UpdateVerifying implements UpdateState {
  const factory UpdateVerifying({required final UpdateInfo info}) =
      _$UpdateVerifyingImpl;

  UpdateInfo get info;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateVerifyingImplCopyWith<_$UpdateVerifyingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDownloadedImplCopyWith<$Res> {
  factory _$$UpdateDownloadedImplCopyWith(_$UpdateDownloadedImpl value,
          $Res Function(_$UpdateDownloadedImpl) then) =
      __$$UpdateDownloadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateInfo info, String path});

  $UpdateInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$UpdateDownloadedImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateDownloadedImpl>
    implements _$$UpdateDownloadedImplCopyWith<$Res> {
  __$$UpdateDownloadedImplCopyWithImpl(_$UpdateDownloadedImpl _value,
      $Res Function(_$UpdateDownloadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? path = null,
  }) {
    return _then(_$UpdateDownloadedImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get info {
    return $UpdateInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$UpdateDownloadedImpl implements UpdateDownloaded {
  const _$UpdateDownloadedImpl({required this.info, required this.path});

  @override
  final UpdateInfo info;
  @override
  final String path;

  @override
  String toString() {
    return 'UpdateState.downloaded(info: $info, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDownloadedImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info, path);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDownloadedImplCopyWith<_$UpdateDownloadedImpl> get copyWith =>
      __$$UpdateDownloadedImplCopyWithImpl<_$UpdateDownloadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return downloaded(info, path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return downloaded?.call(info, path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (downloaded != null) {
      return downloaded(info, path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return downloaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return downloaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (downloaded != null) {
      return downloaded(this);
    }
    return orElse();
  }
}

abstract class UpdateDownloaded implements UpdateState {
  const factory UpdateDownloaded(
      {required final UpdateInfo info,
      required final String path}) = _$UpdateDownloadedImpl;

  UpdateInfo get info;
  String get path;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDownloadedImplCopyWith<_$UpdateDownloadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateChecksumFailedImplCopyWith<$Res> {
  factory _$$UpdateChecksumFailedImplCopyWith(_$UpdateChecksumFailedImpl value,
          $Res Function(_$UpdateChecksumFailedImpl) then) =
      __$$UpdateChecksumFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateInfo info});

  $UpdateInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$UpdateChecksumFailedImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateChecksumFailedImpl>
    implements _$$UpdateChecksumFailedImplCopyWith<$Res> {
  __$$UpdateChecksumFailedImplCopyWithImpl(_$UpdateChecksumFailedImpl _value,
      $Res Function(_$UpdateChecksumFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$UpdateChecksumFailedImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UpdateInfo,
    ));
  }

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UpdateInfoCopyWith<$Res> get info {
    return $UpdateInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc

class _$UpdateChecksumFailedImpl implements UpdateChecksumFailed {
  const _$UpdateChecksumFailedImpl({required this.info});

  @override
  final UpdateInfo info;

  @override
  String toString() {
    return 'UpdateState.checksumFailed(info: $info)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateChecksumFailedImpl &&
            (identical(other.info, info) || other.info == info));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateChecksumFailedImplCopyWith<_$UpdateChecksumFailedImpl>
      get copyWith =>
          __$$UpdateChecksumFailedImplCopyWithImpl<_$UpdateChecksumFailedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return checksumFailed(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return checksumFailed?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (checksumFailed != null) {
      return checksumFailed(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return checksumFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return checksumFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (checksumFailed != null) {
      return checksumFailed(this);
    }
    return orElse();
  }
}

abstract class UpdateChecksumFailed implements UpdateState {
  const factory UpdateChecksumFailed({required final UpdateInfo info}) =
      _$UpdateChecksumFailedImpl;

  UpdateInfo get info;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateChecksumFailedImplCopyWith<_$UpdateChecksumFailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCanceledImplCopyWith<$Res> {
  factory _$$UpdateCanceledImplCopyWith(_$UpdateCanceledImpl value,
          $Res Function(_$UpdateCanceledImpl) then) =
      __$$UpdateCanceledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UpdateCanceledImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateCanceledImpl>
    implements _$$UpdateCanceledImplCopyWith<$Res> {
  __$$UpdateCanceledImplCopyWithImpl(
      _$UpdateCanceledImpl _value, $Res Function(_$UpdateCanceledImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdateCanceledImpl implements UpdateCanceled {
  const _$UpdateCanceledImpl();

  @override
  String toString() {
    return 'UpdateState.canceled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdateCanceledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return canceled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return canceled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (canceled != null) {
      return canceled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return canceled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return canceled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (canceled != null) {
      return canceled(this);
    }
    return orElse();
  }
}

abstract class UpdateCanceled implements UpdateState {
  const factory UpdateCanceled() = _$UpdateCanceledImpl;
}

/// @nodoc
abstract class _$$UpdateErrorImplCopyWith<$Res> {
  factory _$$UpdateErrorImplCopyWith(
          _$UpdateErrorImpl value, $Res Function(_$UpdateErrorImpl) then) =
      __$$UpdateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UpdateErrorImplCopyWithImpl<$Res>
    extends _$UpdateStateCopyWithImpl<$Res, _$UpdateErrorImpl>
    implements _$$UpdateErrorImplCopyWith<$Res> {
  __$$UpdateErrorImplCopyWithImpl(
      _$UpdateErrorImpl _value, $Res Function(_$UpdateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UpdateErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateErrorImpl implements UpdateError {
  const _$UpdateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'UpdateState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateErrorImplCopyWith<_$UpdateErrorImpl> get copyWith =>
      __$$UpdateErrorImplCopyWithImpl<_$UpdateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() checking,
    required TResult Function() noUpdate,
    required TResult Function(UpdateInfo info, bool force) available,
    required TResult Function(UpdateInfo info, double progress) downloading,
    required TResult Function(UpdateInfo info, double progress) paused,
    required TResult Function(UpdateInfo info) verifying,
    required TResult Function(UpdateInfo info, String path) downloaded,
    required TResult Function(UpdateInfo info) checksumFailed,
    required TResult Function() canceled,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? checking,
    TResult? Function()? noUpdate,
    TResult? Function(UpdateInfo info, bool force)? available,
    TResult? Function(UpdateInfo info, double progress)? downloading,
    TResult? Function(UpdateInfo info, double progress)? paused,
    TResult? Function(UpdateInfo info)? verifying,
    TResult? Function(UpdateInfo info, String path)? downloaded,
    TResult? Function(UpdateInfo info)? checksumFailed,
    TResult? Function()? canceled,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? checking,
    TResult Function()? noUpdate,
    TResult Function(UpdateInfo info, bool force)? available,
    TResult Function(UpdateInfo info, double progress)? downloading,
    TResult Function(UpdateInfo info, double progress)? paused,
    TResult Function(UpdateInfo info)? verifying,
    TResult Function(UpdateInfo info, String path)? downloaded,
    TResult Function(UpdateInfo info)? checksumFailed,
    TResult Function()? canceled,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateInitial value) initial,
    required TResult Function(UpdateChecking value) checking,
    required TResult Function(UpdateNoUpdate value) noUpdate,
    required TResult Function(UpdateAvailable value) available,
    required TResult Function(UpdateDownloading value) downloading,
    required TResult Function(UpdatePaused value) paused,
    required TResult Function(UpdateVerifying value) verifying,
    required TResult Function(UpdateDownloaded value) downloaded,
    required TResult Function(UpdateChecksumFailed value) checksumFailed,
    required TResult Function(UpdateCanceled value) canceled,
    required TResult Function(UpdateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateInitial value)? initial,
    TResult? Function(UpdateChecking value)? checking,
    TResult? Function(UpdateNoUpdate value)? noUpdate,
    TResult? Function(UpdateAvailable value)? available,
    TResult? Function(UpdateDownloading value)? downloading,
    TResult? Function(UpdatePaused value)? paused,
    TResult? Function(UpdateVerifying value)? verifying,
    TResult? Function(UpdateDownloaded value)? downloaded,
    TResult? Function(UpdateChecksumFailed value)? checksumFailed,
    TResult? Function(UpdateCanceled value)? canceled,
    TResult? Function(UpdateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateInitial value)? initial,
    TResult Function(UpdateChecking value)? checking,
    TResult Function(UpdateNoUpdate value)? noUpdate,
    TResult Function(UpdateAvailable value)? available,
    TResult Function(UpdateDownloading value)? downloading,
    TResult Function(UpdatePaused value)? paused,
    TResult Function(UpdateVerifying value)? verifying,
    TResult Function(UpdateDownloaded value)? downloaded,
    TResult Function(UpdateChecksumFailed value)? checksumFailed,
    TResult Function(UpdateCanceled value)? canceled,
    TResult Function(UpdateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UpdateError implements UpdateState {
  const factory UpdateError({required final String message}) =
      _$UpdateErrorImpl;

  String get message;

  /// Create a copy of UpdateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateErrorImplCopyWith<_$UpdateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
