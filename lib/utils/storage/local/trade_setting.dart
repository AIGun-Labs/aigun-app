import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TradeSettingStorage {
  static const String _tradeSettingKey = "trade_setting";

  TradeSettingStorage();

  Future<void> saveTradeSetting(dynamic tradeSetting) async {
    final prefs = await SharedPreferences.getInstance();

    if (tradeSetting == null) {
      await prefs.remove(_tradeSettingKey);
    } else {
      final tradeSettingJson = jsonEncode(tradeSetting);
      await prefs.setString(_tradeSettingKey, tradeSettingJson);
    }
  }

  Future<dynamic> getTradeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    final tradeSettingJson = prefs.getString(_tradeSettingKey);
    return tradeSettingJson != null ? jsonDecode(tradeSettingJson) : null;
  }
}
