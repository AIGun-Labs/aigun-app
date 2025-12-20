import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/constants.dart';
import '../../core/service_locator.dart';
import '../../data/models/index.dart';
import '../../data/services/api/wallet_api.dart';
import '../../data/services/sentry_service.dart';
import '../../l10n/l10n.dart';
import '../../shared/presentation/cubits/new_user/new_user_cubit.dart';
import '../../utils/logger.dart';
import '../../utils/storage/local/wallet_storage.dart';
import '../../utils/validators/wallet_validator.dart';
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

  // 当 cubit 被销毁的时候 flutter 会自动调用这个方法
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  /// 初始化钱包
  Future<void> init() async {
    // 从本地获取选中的钱包
    final savedWallet = await _storage.getSelectedWallet();
    // 如果有保存的钱包，提取其地址（使用第一个地址作为默认）
    final savedAddress = savedWallet?.addresses?.firstOrNull?.address;
    emit(state.copyWith(selectedWalletAddress: savedAddress));
    await getUserWallets();
  }

  void toReceivePage(
    BuildContext context, {
    required String avatar,
    required String symbol,
    required String network,
    required String title,
    required bool isNative,
  }) {
    final walletAddress = getWalletByNetwork(network);

    if (walletAddress == null) return;

    final newAvatar = isNative ? walletAddress.chainLogo : avatar;
    final newTitle = isNative
        ? S.of(context).networkReceive(walletAddress.chainName ?? network)
        : S.of(context).tokenReceive(symbol);

    Logger.info('toReceivePage newAvatar: $newAvatar');

    context.pushNamed(
      RouteNames.receiveAddress,
      extra: {
        'avatar': newAvatar,
        'title': newTitle,
        'symbol': walletAddress.chainName,
        'address': walletAddress.address,
        'subAvatar': walletAddress.chainLogo,
      },
    );
  }

  ///  跳转到代币收款页面
  void toNativeReceivePage(
    BuildContext context, {
    required String avatar,
    required String symbol,
    required String network,
    // required String title,
    // required bool isNative,
  }) {
    final wallet = getWalletByNetwork(network);

    if (wallet == null) return;
    final newTitle = S.of(context).networkReceive(wallet.chainName ?? network);

    // 网络收款不需要显示 network
    context.pushNamed(
      RouteNames.receiveAddress,
      extra: {
        'avatar': wallet.chainLogo,
        'title': newTitle,
        'symbol': wallet.chainName,
        'address': wallet.address,
      },
    );
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

  /// Get all the user's wallets
  Future<void> getUserWallets() async {
    if (_userCubit.state.authStatus != AuthStatus.authenticated) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      // 获取钱包列表
      final wallets = await _walletApi.getWalletList();

      // 设置第一个钱包为默认钱包
      if (wallets.isNotEmpty) {
        await getIt<WalletStorage>().saveSelectedWallet(wallets.first);
      } else {
        await SentryService().reportError(
          Exception('No wallets found'),
          StackTrace.current,
          tags: {'feature': 'getUserWallets'},
        );
      }
      emit(
        state.copyWith(wallets: wallets, isLoading: false, errorMessage: ''),
      );
    } catch (e) {
      await SentryService().reportError(
        e,
        StackTrace.current,
        tags: {'feature': 'getUserWallets'},
      );
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  // 创建钱包用户
  Future<void> createWalletUser(String paymentPin) async {
    if (!WalletValidator.validatePaymentPin(paymentPin).isValid) {
      emit(state.copyWith(isPaymentPin: false));
      Fluttertoast.showToast(
        msg: 'The payment pin format is incorrect',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.sp,
      );
      return;
    }
    emit(state.copyWith(isCreating: true));

    try {
      await _walletApi.createWalletUser(paymentPin: paymentPin);
      await getUserWallets();
    } catch (e) {
      await SentryService().reportError(
        e,
        StackTrace.current,
        tags: {'feature': 'createWalletUser'},
      );
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isPaymentPin: false,
          isCreating: false,
        ),
      );
    }
    emit(state.copyWith(isCreating: false));
  }

  // Get all supported chains
  Future<void> getChains() async {
    emit(state.copyWith(isLoading: true));

    try {
      final chains = await _walletApi.getChains();

      if (chains.isEmpty) {
        await SentryService().reportError(
          Exception('No chains found'),
          StackTrace.current,
          tags: {'feature': 'getChains'},
        );
      }
      emit(state.copyWith(chains: chains, isLoading: false, errorMessage: ''));
    } catch (e) {
      await SentryService().reportError(
        e,
        StackTrace.current,
        tags: {'feature': 'getChains'},
      );
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  /// 创建钱包
  Future<void> createWallet(String chainType) async {
    emit(state.copyWith(isCreating: true));

    try {
      await _walletApi.createWallet(chainType: chainType);
      await getUserWallets();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isCreating: false));
    }
  }

  Future<void> deleteWallet(String address) async {
    emit(state.copyWith(isLoading: true));
    try {
      final success = await _walletApi.deleteWallet(address: address);
      if (success) {
        await getUserWallets();
      } else {
        emit(state.copyWith(errorMessage: '删除钱包失败', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  /// 导出钱包私钥
  Future<void> exportPrivateKey(String address, String password) async {
    emit(state.copyWith(isLoading: true));
    try {
      final privateKeyData = await _walletApi.exportPrivateKey(
        address: address,
        password: password,
      );
      _exportedPrivateKey = privateKeyData.privateKey;
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  /// 保存选中的钱包到本地
  Future<void> selectWallet(String? address) async {
    if (address == null) {
      await _storage.saveSelectedWallet(null);
      emit(state.copyWith(selectedWalletAddress: null));
    } else {
      // 通过地址查找钱包对象
      try {
        final wallet = state.wallets.firstWhere(
          (w) => w.addresses?.any((addr) => addr.address == address) ?? false,
        );
        await _storage.saveSelectedWallet(wallet);
        emit(state.copyWith(selectedWalletAddress: address));
      } catch (e) {
        // 如果找不到钱包，不执行任何操作
      }
    }
  }
}
