import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import 'chain_state.dart';

class ChainCubit extends Cubit<ChainState> {
  ChainCubit(this._newUserCubit) : super(const ChainState()) {
    _userSubscription = _newUserCubit.stream.listen((state) {
      if (state.authStatus == AuthStatus.authenticated) {
        init();
      }
    });
  }
  final NewUserCubit _newUserCubit;
  late final StreamSubscription _userSubscription;

  void init() {
    getChains();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> getChains() async {
    emit(const ChainState(status: ChainStatus.loading()));

    try {
      final chain = await getIt<ChainApi>().getChains();
      emit(state.copyWith(chains: chain, status: ChainStatus.success(chain)));
    } catch (e, s) {
      emit(ChainState(status: ChainStatus.error(e.toString())));
      await SentryService().reportError(
        e,
        s,
        tags: {'feature': 'getTokenInfo'},
      );
    }
  }
}
