import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/index.dart';

class WalletStorage {
  static const String _selectedWalletKey = 'selected_wallet';

  WalletStorage();

// 保存选中的钱包
  Future<void> saveSelectedWallet(Wallet? wallet) async {
    final prefs = await SharedPreferences.getInstance();
    // 如果钱包为空，则删除钱包
    if (wallet == null) {
      await prefs.remove(_selectedWalletKey);
    } else {
      final walletJson = wallet.toJson();
      await prefs.setString(_selectedWalletKey, jsonEncode(walletJson));
    }
  }

  // 获取选中的钱包
  Future<Wallet?> getSelectedWallet() async {
    final prefs = await SharedPreferences.getInstance();
    final walletJsonString = prefs.getString(_selectedWalletKey);
    if (walletJsonString == null || walletJsonString.isEmpty) {
      return null;
    }
    try {
      final walletJson = jsonDecode(walletJsonString) as Map<String, dynamic>;
      return Wallet.fromJson(walletJson);
    } catch (e) {
      // 如果解析失败，返回null
      return null;
    }
  }

  // 保持向后兼容的方法，保存选中的钱包地址
  Future<void> saveSelectedWalletAddress(String? address) async {
    final prefs = await SharedPreferences.getInstance();
    if (address == null) {
      await prefs.remove(_selectedWalletKey);
    } else {
      await prefs.setString(_selectedWalletKey, address);
    }
  }

  Future<String?> getSelectedWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedWalletKey);
  }
}
