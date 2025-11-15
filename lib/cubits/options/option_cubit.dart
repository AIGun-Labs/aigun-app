import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/api/option_api.dart';
import '../../shared/utils/safe_request.dart';
import 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  final OptionsApi _optionsApi;

  OptionsCubit(this._optionsApi) : super(const OptionsState()) {
    init();
  }

  void init() async {
    await Future.wait([
      getSingleTypeOptions(),
    ], eagerError: false);
  }

  Future<void> getSingleTypeOptions() async {
    final result = await safeRequest(() => _optionsApi.getSingleTypeOptions());
    if (result == null) return;
    emit(state.copyWith(singleTypeOptions: result));
  }
}
