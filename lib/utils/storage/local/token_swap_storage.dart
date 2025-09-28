import 'dart:convert';

import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TradeToken defaultTradeToken = TradeToken(
    chainId: 1151111081099710,
    chainLogo:
        "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg",
    chainName: "Solana",
    tokenAvatar:
        "https://statics.solscan.io/cdn/imgs/s60?ref=68747470733a2f2f7261772e67697468756275736572636f6e74656e742e636f6d2f736f6c616e612d6c6162732f746f6b656e2d6c6973742f6d61696e2f6173736574732f6d61696e6e65742f45506a465764643541756671535371654d32714e31787a7962617043384734774547476b5a777954447431762f6c6f676f2e706e67",
    tokenName: "USDC",
    address: "EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v",
    tokenPrice: 0,
    balance: "0",
    decimals: 6,
    symbol: "USDC");

const TradeToken defaultFormTradeToken = TradeToken(
    chainId: 1151111081099710,
    chainLogo:
        "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/solana.svg",
    chainName: "Solana",
    tokenAvatar:
        "https://static.oklink.com/cdn/web3/currency/token/501-11111111111111111111111111111111-1.png/type=default_350_0?v=1734571825920",
    tokenName: "SOL",
    address: "So11111111111111111111111111111111111111112",
    tokenPrice: 0,
    balance: "0",
    decimals: 9,
    symbol: "SOL");

class TokenSwapStorage {
  static const String _fromTokenKey = "from_token_swap";
  static const String _toTokenKey = "to_token_swap";
  static const String _tokenSwapKey = "token_swap"; // 保留用于清理旧数据

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
    final prefs = await SharedPreferences.getInstance();

    final fromTokenJson = fromToken.toJson();
    await prefs.setString(_fromTokenKey, jsonEncode(fromTokenJson));
    // 清理旧的错误数据
    await prefs.remove(_tokenSwapKey);
  }

  Future<Token?> getFromToken() async {
    final prefs = await SharedPreferences.getInstance();

    // 优先读取新的 key
    var fromTokenString = prefs.getString(_fromTokenKey);

    // 如果新 key 不存在，尝试从旧 key 迁移
    if (fromTokenString == null) {
      final oldData = prefs.getString(_tokenSwapKey);
      if (oldData != null && oldData.startsWith('{') && oldData.endsWith('}')) {
        // 旧数据是有效的 JSON，迁移到新 key
        fromTokenString = oldData;
        await prefs.setString(_fromTokenKey, oldData);
      }
    }

    if (fromTokenString == null) {
      return null;
    }

    try {
      // 验证是否为有效的 JSON
      if (!fromTokenString.startsWith('{') || !fromTokenString.endsWith('}')) {
        // 数据损坏，清除并返回 null
        await prefs.remove(_fromTokenKey);
        return null;
      }

      final fromTokenJson = jsonDecode(fromTokenString);
      return Token.fromJson(fromTokenJson);
    } catch (e) {
      // 解析失败，清除损坏的数据
      await prefs.remove(_fromTokenKey);
      return null;
    }
  }

  Future<void> saveToToken(Token toToken) async {
    final prefs = await SharedPreferences.getInstance();
    final toTokenJson = toToken.toJson();
    await prefs.setString(_toTokenKey, jsonEncode(toTokenJson));
  }

  Future<Token?> getToToken() async {
    final prefs = await SharedPreferences.getInstance();
    final toTokenString = prefs.getString(_toTokenKey);
    if (toTokenString == null) {
      return null;
    }

    try {
      // 验证是否为有效的 JSON
      if (!toTokenString.startsWith('{') || !toTokenString.endsWith('}')) {
        // 数据损坏，清除并返回 null
        await prefs.remove(_toTokenKey);
        return null;
      }

      final toTokenJson = jsonDecode(toTokenString);
      return Token.fromJson(toTokenJson);
    } catch (e) {
      // 解析失败，清除损坏的数据
      await prefs.remove(_toTokenKey);
      return null;
    }
  }
}
