import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/core/custom_exceptions.dart';
import 'package:flutter_aigun/core/service_locator.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/data/services/api/wallet_api.dart';
import 'package:flutter_aigun/data/services/api/wallet_user_api.dart';
import 'package:flutter_aigun/utils/storage/local/wallet_storage.dart';
import 'package:flutter_aigun/utils/validators/wallet_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletApi _walletApi = GetIt.instance<WalletApi>();
  final WalletStorage _storage = WalletStorage();
  final UserCubit userCubit;
  late final StreamSubscription userSubscription;
  late final StreamSubscription balanceSubscription;
  String? _exportedPrivateKey;

  String? get exportedPrivateKey => _exportedPrivateKey;

  WalletCubit(this.userCubit) : super(const WalletState()) {
    userSubscription = userCubit.stream.listen((state) async {
      if (state.isLoggedIn) {
        init();
      }
    });

    init();
  }

// 当 cubit 被销毁的时候 flutter 会自动调用这个方法
  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }

  /// 初始化钱包
  Future<void> init() async {
    // 从本地获取选中的钱包
    final savedWallet = await _storage.getSelectedWallet();
    // 如果有保存的钱包，提取其地址（使用第一个地址作为默认）
    final savedAddress = savedWallet?.addresses?.first.address;
    emit(state.copyWith(selectedWalletAddress: savedAddress));
    await getUserWallets();
  }

  /// Get all the user's wallets
  Future<void> getUserWallets() async {
    emit(state.copyWith(isLoading: true));
    try {
      // 获取钱包列表
      final wallets = await _walletApi.getWalletList();
      // 设置第一个钱包为默认钱包
      if (wallets.isNotEmpty) {
        await getIt<WalletStorage>().saveSelectedWallet(wallets.first);
      }
      emit(
          state.copyWith(wallets: wallets, isLoading: false, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

// 创建钱包用户
  Future<void> createWalletUser(String paymentPin) async {
    if (!WalletValidator.validatePaymentPin(paymentPin).isValid) {
      emit(state.copyWith(isPaymentPin: false));
      Fluttertoast.showToast(
          msg: "The payment pin format is incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.sp);
      return;
    }
    emit(state.copyWith(isCreating: true));

    try {
      await getIt<WalletUserApi>().createWalletUser(paymentPin: paymentPin);
      await getUserWallets();
    } on DioException catch (e) {
      final error = e.error;
      if (error is BusinessException) {
        if (error.code == 200006) {
          Fluttertoast.showToast(
              msg: error.msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.sp);
        }
      }
      emit(state.copyWith(
          errorMessage: e.toString(), isPaymentPin: false, isCreating: false));
    } catch (e) {
      emit(state.copyWith(
          errorMessage: e.toString(), isPaymentPin: false, isCreating: false));
    }
    emit(state.copyWith(isCreating: false));
  }

// Get all supported chains
  Future<void> getChains() async {
    emit(state.copyWith(isLoading: true));

    try {
      final chains = await _walletApi.getChains();
      emit(state.copyWith(chains: chains, isLoading: false, errorMessage: ''));
    } catch (e) {
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
          address: address, password: password);
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

  void clearWallets() {
    emit(state.copyWith(wallets: [], selectedWalletAddress: null));
  }
}
