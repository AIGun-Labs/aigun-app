import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/types/result.dart';
import '../../application/usecases/get_supported_chains.dart';
import 'supported_chains_state.dart';

class SupportedChainsCubit extends Cubit<SupportedChainsStatus> {
  final GetSupportedChains _getSupportedChains;
  SupportedChainsCubit(this._getSupportedChains)
    : super(const SupportedChainsStatus.initial());

  void initialize() {
    getChains();
  }

  Future<void> getChains() async {
    emit(const SupportedChainsStatus.loading());

    final result = await _getSupportedChains.call();
    result.whenOrNull(
      success: (chains) => emit(SupportedChainsStatus.success(chains)),
      failure: (failure) => emit(SupportedChainsStatus.error(failure)),
    );
  }
}
