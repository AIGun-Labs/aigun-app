part of 'top_tab_action_cubit.dart';

enum TabActionType { scrollToTop, refresh }

@freezed
class TopTabActionState with _$TopTabActionState {
  @override
  final TabActionType type;
  @override
  final int tabIndex;
  @override
  final int nonce;

  const TopTabActionState({
    required this.type,
    required this.tabIndex,
    required this.nonce,
  });
}
