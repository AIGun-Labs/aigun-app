import 'package:flutter_aigun/cubits/options/options_state.dart';
import 'package:flutter_aigun/data/services/api/option_api.dart';
import 'package:flutter_aigun/shared/utils/safe_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
