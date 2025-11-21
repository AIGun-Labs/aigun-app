import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TradeSettingStorage {
  static const String _tradeSettingKey = 'trade_setting';
  final SharedPreferences _prefs;
  TradeSettingStorage(this._prefs);

  Future<void> saveTradeSetting(dynamic tradeSetting) async {
    if (tradeSetting == null) {
      await _prefs.remove(_tradeSettingKey);
    } else {
      final tradeSettingJson = jsonEncode(tradeSetting);
      await _prefs.setString(_tradeSettingKey, tradeSettingJson);
    }
  }

  Future<dynamic> getTradeSetting() async {
    final tradeSettingJson = _prefs.getString(_tradeSettingKey);
    return tradeSettingJson != null ? jsonDecode(tradeSettingJson) : null;
  }
}
