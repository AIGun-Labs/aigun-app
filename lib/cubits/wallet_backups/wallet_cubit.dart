import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/services/api/wallet_api.dart';
import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../index.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._userCubit) : super(const WalletState()) {
    _userSubscription = _userCubit.stream.listen((state) {
      if (state.authStatus == AuthStatus.authenticated) {
        init();
      }
    });

    init();
  }
  final WalletApi _walletApi = getIt<WalletApi>();
  final WalletStorage _storage = getIt<WalletStorage>();
  final NewUserCubit _userCubit;
  late final StreamSubscription _userSubscription;
  String? _exportedPrivateKey;

  String? get exportedPrivateKey => _exportedPrivateKey;

  String? getWalletAddressByNetwork(String network) {
    final walletAddress = state.wallets.first.addresses
        ?.where((address) => address.network == network)
        .firstOrNull;
    return walletAddress?.address ?? '';
  }

  WalletAddress? getWalletByNetwork(String network) {
    if (state.wallets.isEmpty) return null;
    return state.wallets.first.addresses
        ?.where((wallet) => wallet.network == network)
        .firstOrNull;
  }

  WalletAddress? getWalletAddress(String network, String address) {
    if (state.wallets.isEmpty) return null;

    return state.wallets.first.addresses
        ?.where((wallet) => wallet.network == network)
        .firstOrNull;
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> init() async {
    return;
  }

  void toReceivePage(
    BuildContext context, {
    required String avatar,
    required String symbol,
    required String network,
    required String title,
    required bool isNative,
  }) {
    return;
  }

  void toNativeReceivePage(
    BuildContext context, {
    required String avatar,
    required String symbol,
    required String network,
  }) {
    return;
  }

  // void toReceivePage(
  //   BuildContext context, {
  //   String? network,
  //   String? chainName,
  // }) {
  //   if (network == null) return;

  //   final walletAddress = getWalletByNetwork(network);

  //   if (walletAddress == null) return;

  //   final title = S.of(context).networkReceive(chainName ?? '');

  //   context.pushNamed(
  //     RouteNames.receiveAddress,
  //     extra: {
  //       'avatar': walletAddress.chainLogo,
  //       'title': title,
  //       'symbol': walletAddress.chainName,
  //       'address': walletAddress.address,
  //     },
  //   );
  // }
  Future<void> getUserWallets() async {
    return;
  }

  Future<void> createWalletUser(String paymentPin) async {
    return;
  }

  Future<void> getChains() async {
    return;
  }

  Future<void> createWallet(String chainType) async {
    return;
  }

  Future<void> deleteWallet(String address) async {
    return;
  }

  Future<void> exportPrivateKey(String address, String password) async {
    return;
  }

  Future<void> selectWallet(String? address) async {
    return;
  }
}
