import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/cubits/chain_back/chain_state.dart';
import 'package:flutter_aigun/cubits/user/user_cubit.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/services/api/chain_api.dart';
import 'package:get_it/get_it.dart';

class ChainCubit extends Cubit<ChainState> {
  final ChainApi chainApi = GetIt.instance<ChainApi>();
  final UserCubit userCubit;
  late final StreamSubscription userSubscription;

  ChainCubit(this.userCubit) : super(ChainState.initial()) {
    userSubscription = userCubit.stream.listen((state) {
      if (state.isLoggedIn) {
        init();
      }
    });
  }

  void init() {
    getChainList();
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  Future<void> getChainList() async {
    emit(state.copyWith(isLoading: true));
    try {
      final chains = await chainApi.getChain();
      emit(state.copyWith(chains: chains));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<List<String>> getChainTypes() async {
    try {
      final data = await chainApi.getChainType();
      if (data['types'] != null) {
        return (data['types'] as List<dynamic>).cast<String>();
      }
    } catch (e) {
      // 可以选择处理错误或者记录日志
    }
    return [];
  }

  Chain? getChain(String chainId) {
    try {
      if (state.chains.isEmpty || chainId.isEmpty) return null;
      return state.chains
          .firstWhere((chain) => chain.chainId == int.tryParse(chainId));
    } catch (e) {
      return null;
    }
  }

  String getChainName(String chainId) {
    // if (state.chains.isEmpty || chainId.isEmpty) return '';
    // return state.chains.firstWhere((chain) => chain.chainId == chainId).name;\
    return "";
  }

  String getChainSymbol(String chainId) {
    // if (state.chains.isEmpty || chainId.isEmpty) return '';
    // return state.chains
    //     .firstWhere((chain) => chain.chainId == chainId)
    //     .mainToken;
    return "";
  }
}
