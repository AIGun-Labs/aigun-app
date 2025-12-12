import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_tab_action_cubit.freezed.dart';
part 'top_tab_action_state.dart';

class TopTabActionCubit extends Cubit<TopTabActionState?> {
  TopTabActionCubit() : super(null);

  int _nonce = 0;

  void scrollToTop(int tabIndex) => emit(
    TopTabActionState(
      type: TabActionType.scrollToTop,
      tabIndex: tabIndex,
      nonce: ++_nonce,
    ),
  );

  void refresh(int tabIndex) => emit(
    TopTabActionState(
      type: TabActionType.refresh,
      tabIndex: tabIndex,
      nonce: ++_nonce,
    ),
  );
}
