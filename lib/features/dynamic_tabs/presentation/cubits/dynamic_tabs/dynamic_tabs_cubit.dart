import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/option_tab_entity.dart';
import '../../../domain/usecases/get_option_tab.dart';

part 'dynamic_tabs_cubit.freezed.dart';
part 'dynamic_tabs_state.dart';

class DynamicTabsCubit extends Cubit<DynamicTabsState> {
  final GetOptionTab _getOptionTab;

  DynamicTabsCubit(this._getOptionTab) : super(const DynamicTabsState());

  Future<void> init() async {
    await _getTabs();
  }

  Future<void> _getTabs() async {
    emit(state.copyWith(status: DynamicTabsStatus.loading));
    final status = await _getOptionTab.call();

    if (status.isSuccess) {
      emit(
        state.copyWith(status: DynamicTabsStatus.success, tabs: status.value!),
      );
    } else {
      emit(
        state.copyWith(
          status: DynamicTabsStatus.failure,
          errorMessage: status.errorMessage ?? '',
        ),
      );
    }
  }
}
