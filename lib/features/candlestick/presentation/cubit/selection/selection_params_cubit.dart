import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/timeframe.dart';
import '../../../../../shared/domain/value_object/network.dart';
import 'selection_params_state.dart';

class SelectionParamsCubit extends Cubit<SelectionParamsState> {
  SelectionParamsCubit() : super(const SelectionParamsState());

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
}
