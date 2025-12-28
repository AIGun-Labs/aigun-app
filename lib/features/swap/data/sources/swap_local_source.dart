import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/transaction_entity.dart';
import '../models/swap_token_model.dart';

///
class SwapLocalSource {
  final SharedPreferences _prefs;

  SwapLocalSource(this._prefs);

  static const String _fromTokenKey = 'from_token_swap';
  static const String _toTokenKey = 'to_token_swap';
  Future<void> saveSelectedTokens({
    required TransactionEntity fromToken,
    required TransactionEntity toToken,
  }) async {
    await Future.wait([
      _saveToken(_fromTokenKey, fromToken),
      _saveToken(_toTokenKey, toToken),
    ]);
  }

  Future<void> saveFromToken(TransactionEntity token) async {
    await _saveToken(_fromTokenKey, token);
  }

  Future<void> saveToToken(TransactionEntity token) async {
    await _saveToken(_toTokenKey, token);
  }

  Future<({TransactionEntity? from, TransactionEntity? to})>
  getSelectedTokens() async {
    return (from: _getToken(_fromTokenKey), to: _getToken(_toTokenKey));
  }

  TransactionEntity? getFromToken() => _getToken(_fromTokenKey);
  TransactionEntity? getToToken() => _getToken(_toTokenKey);
  Future<void> clear() async {
    await Future.wait([
      _prefs.remove(_fromTokenKey),
      _prefs.remove(_toTokenKey),
    ]);
  }

  // ==================== Private Methods ====================

  Future<void> _saveToken(String key, TransactionEntity token) async {
    final model = SwapTokenModel.fromEntity(token);
    await _prefs.setString(key, jsonEncode(model.toJson()));
  }

  TransactionEntity? _getToken(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;

    try {
      if (!_isValidJson(jsonString)) {
        _prefs.remove(key);
        return null;
      }
      final model = SwapTokenModel.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      return model.toEntity();
    } catch (e) {
      _prefs.remove(key);
      return null;
    }
  }

  bool _isValidJson(String str) => str.startsWith('{') && str.endsWith('}');
}
