part of 'hot_token_cubit.dart';

enum HotTokenStatus { initial, loading, success, failure, empty }

@freezed
class HotTokenState with _$HotTokenState {
  @override
  final HotTokenStatus status;
  @override
  final List<HotTokenEntity> tokens;
  @override
  final String selectedNetwork;
  @override
  final Map<String, String> supportedNetworks;

  @override
  final String message;

  const HotTokenState({
    this.status = HotTokenStatus.initial,
    this.tokens = const [],
    this.selectedNetwork = 'all',
    this.supportedNetworks = const {},
    this.message = '',
  });
}

/// 热门代币状态
// @freezed
// class HotTokenState with _$HotTokenState {
//   /// 初始状态
//   const factory HotTokenState.initial() = HotTokenInitial;

//   /// 加载中（首次加载或刷新）
//   const factory HotTokenState.loading({
//     List<HotTokenEntity>? previousTokens, // 保留旧数据
//     String? selectedNetwork,
//   }) = HotTokenLoading;

//   /// 已加载
//   const factory HotTokenState.loaded({
//     required List<HotTokenEntity> tokens,
//     required String selectedNetwork,
//   }) = HotTokenLoaded;

//   /// 空列表
//   const factory HotTokenState.empty({
//     required String selectedNetwork,
//   }) = HotTokenEmpty;

//   /// 错误
//   const factory HotTokenState.error({
//     required String message,
//     String? selectedNetwork,
//   }) = HotTokenError;
// }
