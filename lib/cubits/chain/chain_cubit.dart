import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/services/api/index.dart';
import '../../data/services/sentry_service.dart';
import '../user/user_cubit.dart';
import 'chain_state.dart';

class ChainCubit extends Cubit<ChainState> {
  final UserCubit userCubit;
  late final StreamSubscription userSubscription;

  ChainCubit(this.userCubit) : super(const ChainState()) {
    userSubscription = userCubit.stream.listen((state) {
      if (state.isLoggedIn) {
        init();
      }
    });
  }

  void init() {
    getChains();
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  Future<void> getChains() async {
    emit(const ChainState(status: ChainStatus.loading()));

    try {
      final chain = await getIt<ChainApi>().getChains();
      emit(state.copyWith(chains: chain, status: ChainStatus.success(chain)));
    } catch (e, s) {
      emit(ChainState(status: ChainStatus.error(e.toString())));
      await SentryService()
          .reportError(e, s, tags: {"feature": "getTokenInfo"});
    }
  }
}
