import 'package:shared_preferences/shared_preferences.dart';

class WalletStorage {
  static const String _selectedWalletKey = 'selected_wallet_address';

  WalletStorage();

  Future<void> saveSelectedWallet(String address) async {
    final prefs = await SharedPreferences.getInstance();
    if (address == null) {
      await prefs.remove(_selectedWalletKey);
    } else {
      await prefs.setString(_selectedWalletKey, address);
    }
  }

  Future<String?> getSelectedWallet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedWalletKey);
  }
}
