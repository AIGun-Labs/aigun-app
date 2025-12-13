import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_chart_plus/k_chart_widget.dart';

import '../../../../../core/enums/timeframe.dart';
import '../../../../../shared/domain/value_object/network.dart';
import 'selection_params_state.dart';

class SelectionParamsCubit extends Cubit<SelectionParamsState> {
  SelectionParamsCubit() : super(const SelectionParamsState());

  void updateToken({required String network, required String address}) {
    emit(
      state.copyWith(
        network: ChainNetwork(network),
        tokenContractAddress: address,
      ),
    );
  }

  void updateNetwork(ChainNetwork network) =>
      emit(state.copyWith(network: network));

  void updateTokenContractAddress(String tokenContractAddress) =>
      emit(state.copyWith(tokenContractAddress: tokenContractAddress));

  void updateBar(String? bar) => emit(state.copyWith(bar: bar));

  void updateTimeframe(Timeframe timeframe) {
    final barInSeconds = timeframe.duration.inSeconds.toString();
    emit(state.copyWith(selectedTimeframe: timeframe, bar: barInSeconds));
  }

  void updateLimit(int? limit) => emit(state.copyWith(limit: limit));

  void updateFrom(int? from) => emit(state.copyWith(from: from));

  void updateTo(int? to) => emit(state.copyWith(to: to));

  void updateMainStates(Set<MainState> mainStates) =>
      emit(state.copyWith(mainStates: mainStates));

  void updateSecondaryStates(Set<SecondaryState> secondaryStates) =>
      emit(state.copyWith(secondaryStates: secondaryStates));

  void addMainState(MainState mainState) =>
      emit(state.copyWith(mainStates: {...state.mainStates, mainState}));

  void addSecondaryState(SecondaryState secondaryState) => emit(
    state.copyWith(secondaryStates: {...state.secondaryStates, secondaryState}),
  );

  void removeMainState(MainState mainState) => emit(
    state.copyWith(
      mainStates: state.mainStates.where((state) => state != mainState).toSet(),
    ),
  );

  void removeSecondaryState(SecondaryState secondaryState) => emit(
    state.copyWith(
      secondaryStates: state.secondaryStates
          .where((state) => state != secondaryState)
          .toSet(),
    ),
  );

  void toggleVolHidden() => emit(state.copyWith(volHidden: !state.volHidden));

  void toggleMainState(MainState mainState) {
    if (state.mainStates.contains(mainState)) {
      removeMainState(mainState);
    } else {
      addMainState(mainState);
    }
  }

  void toggleSecondaryState(SecondaryState secondaryState) {
    if (state.secondaryStates.contains(secondaryState)) {
      removeSecondaryState(secondaryState);
    } else {
      addSecondaryState(secondaryState);
    }
  }
}
