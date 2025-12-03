import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/transaction_entity.dart';
import '../models/swap_token_model.dart';

/// Swap 本地数据源 - 负责代币选择的本地持久化
///
/// 职责：
/// - 存取用户上次选择的代币对
/// - 不处理业务默认值（由 Repository 层处理）
class SwapLocalSource {
  final SharedPreferences _prefs;

  SwapLocalSource(this._prefs);

  static const String _fromTokenKey = 'from_token_swap';
  static const String _toTokenKey = 'to_token_swap';

  /// 保存选中的代币对
  Future<void> saveSelectedTokens({
    required TransactionEntity fromToken,
    required TransactionEntity toToken,
  }) async {
    await Future.wait([
      _saveToken(_fromTokenKey, fromToken),
      _saveToken(_toTokenKey, toToken),
    ]);
  }

  /// 保存 From 代币
  Future<void> saveFromToken(TransactionEntity token) async {
    await _saveToken(_fromTokenKey, token);
  }

  /// 保存 To 代币
  Future<void> saveToToken(TransactionEntity token) async {
    await _saveToken(_toTokenKey, token);
  }

  /// 获取选中的代币对
  /// 返回 null 表示没有缓存，由上层决定默认值
  Future<({TransactionEntity? from, TransactionEntity? to})>
  getSelectedTokens() async {
    return (from: _getToken(_fromTokenKey), to: _getToken(_toTokenKey));
  }

  /// 获取 From 代币
  TransactionEntity? getFromToken() => _getToken(_fromTokenKey);

  /// 获取 To 代币
  TransactionEntity? getToToken() => _getToken(_toTokenKey);

  /// 清除所有缓存
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
