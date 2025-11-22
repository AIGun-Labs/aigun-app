import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/index.dart';

class WalletStorage {
  static const String _selectedWalletKey = 'selected_wallet';
  final SharedPreferences _prefs;
  WalletStorage(this._prefs);

// 保存选中的钱包
  Future<void> saveSelectedWallet(Wallet? wallet) async {
    // 如果钱包为空，则删除钱包
    if (wallet == null) {
      await _prefs.remove(_selectedWalletKey);
    } else {
      final walletJson = wallet.toJson();
      await _prefs.setString(_selectedWalletKey, jsonEncode(walletJson));
    }
  }

  // 获取选中的钱包
  Future<Wallet?> getSelectedWallet() async {
    final walletJsonString = _prefs.getString(_selectedWalletKey);
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
    if (address == null) {
      await _prefs.remove(_selectedWalletKey);
    } else {
      await _prefs.setString(_selectedWalletKey, address);
    }
  }

  Future<String?> getSelectedWalletAddress() async {
    return _prefs.getString(_selectedWalletKey);
  }
}
