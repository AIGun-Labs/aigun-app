import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubits/trade/trade_state.dart';
import '../../../widgets/token/models/token.dart';
import '../../logger.dart';

const TradeToken defaultTradeToken = TradeToken(
  isNative: false,
  chainId: '1151111081099710',
  chainLogo: 'https://cdn.idogex.ai/assets/chain/sol.png',
  chainName: 'Solana',
  tokenAvatar:
      'https://cdn.idogex.ai/image/1f0a8217-21c3-6036-8926-dc85371428bf.png',
  tokenName: 'USDC',
  address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
  tokenPrice: 0,
  balance: '0',
  decimals: 6,
  network: 'solana',
  symbol: 'USDC',
);

const TradeToken defaultFormTradeToken = TradeToken(
  isNative: true,
  chainId: '1151111081099710',
  chainLogo: 'https://cdn.idogex.ai/assets/chain/sol.png',
  chainName: 'Solana',
  tokenAvatar:
      'https://cdn.idogex.ai/image/HGQ_T4YvqPvIpIi-mvX06fwQfHrEDjIJd_IIPq2Q9qpZRPNil0mkN1fkeZgyKGKXQOMcrrPzTUxtGK-Q9rK1Ow==',
  tokenName: 'SOL',
  address: '11111111111111111111111111111111',
  tokenPrice: 0,
  balance: '0',
  decimals: 9,
  network: 'solana',
  symbol: 'SOL',
);

class TokenSwapStorage {
  TokenSwapStorage(this._prefs);
  final SharedPreferences _prefs;
  static const String _fromTokenKey = 'from_token_swap';
  static const String _toTokenKey = 'to_token_swap';
  static const String _tokenSwapKey = 'token_swap'; // 保留用于清理旧数据

  // 初始化
  Future<void> init() async {
    final fromToken = await getFromToken();
    if (fromToken == null) {
      await saveFromToken(Token.fromTradeToken(defaultFormTradeToken));
    }

    final toToken = await getToToken();
    if (toToken == null) {
      await saveToToken(Token.fromTradeToken(defaultTradeToken));
    }
  }

  Future<List<Token?>> getTokens() async {
    final fromToken = await getFromToken();
    final toToken = await getToToken();
    return [fromToken, toToken];
  }

  Future<void> saveFromToken(Token fromToken) async {
    final fromTokenJson = fromToken.toJson();
    await _prefs.setString(_fromTokenKey, jsonEncode(fromTokenJson));
    // 清理旧的错误数据
    await _prefs.remove(_tokenSwapKey);
  }

  Future<Token?> getFromToken() async {
    // 优先读取新的 key
    var fromTokenString = _prefs.getString(_fromTokenKey);

    if (fromTokenString == null) {
      return Token.fromTradeToken(defaultFormTradeToken);
    }

    try {
      // 验证是否为有效的 JSON
      if (!fromTokenString.startsWith('{') || !fromTokenString.endsWith('}')) {
        // 数据损坏，清除并返回 null
        await _prefs.remove(_fromTokenKey);
        return Token.fromTradeToken(defaultFormTradeToken);
      }

      final fromTokenJson = jsonDecode(fromTokenString);
      return Token.fromJson(fromTokenJson);
    } catch (e) {
      // 解析失败，清除损坏的数据
      await _prefs.remove(_fromTokenKey);
      return Token.fromTradeToken(defaultFormTradeToken);
    }
  }

  Future<void> saveToToken(Token toToken) async {
    final toTokenJson = toToken.toJson();
    await _prefs.setString(_toTokenKey, jsonEncode(toTokenJson));
  }

  Future<Token?> getToToken() async {
    final toTokenString = _prefs.getString(_toTokenKey);
    if (toTokenString == null) {
      return Token.fromTradeToken(defaultTradeToken);
    }

    try {
      // 验证是否为有效的 JSON
      if (!toTokenString.startsWith('{') || !toTokenString.endsWith('}')) {
        // 数据损坏，清除并返回 null
        await _prefs.remove(_toTokenKey);
        return Token.fromTradeToken(defaultTradeToken);
      }

      final toTokenJson = jsonDecode(toTokenString);
      return Token.fromJson(toTokenJson);
    } catch (e) {
      // 解析失败，清除损坏的数据
      await _prefs.remove(_toTokenKey);
      return Token.fromTradeToken(defaultTradeToken);
    }
  }

  Future<void> reset() async {
    try {
      await _prefs.remove(_fromTokenKey);
      await _prefs.remove(_toTokenKey);

      await TokenSwapStorage(_prefs).init();
    } catch (e) {
      Logger.error('TokenSwapStorage reset error: $e');
    }
  }
}
