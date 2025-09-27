import 'dart:convert';

import 'package:flutter_aigun/cubits/trade/trade_state.dart';
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
  static const String _tokenSwapKey = "token_swap";

// 初始化
  Future<void> init() async {
    final fromToken = await getFromToken();
    if (fromToken == null) {
      await saveFromToken(defaultFormTradeToken);
    }

    final toToken = await getToToken();
    if (toToken == null) {
      await saveToToken(defaultTradeToken);
    }
  }

  Future<List<TradeToken?>> getTokens() async {
    final fromToken = await getFromToken();
    final toToken = await getToToken();
    return [fromToken, toToken];
  }

  Future<void> saveFromToken(TradeToken fromToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenSwapKey, fromToken.toString());
  }

  Future<TradeToken?> getFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final fromTokenString = prefs.getString(_tokenSwapKey);
    if (fromTokenString == null) {
      return null;
    }
    return null;
    // return TradeToken.fromJson(jsonDecode(fromTokenString));
  }

  Future<void> saveToToken(TradeToken toToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenSwapKey, toToken.toString());
  }

  Future<TradeToken?> getToToken() async {
    final prefs = await SharedPreferences.getInstance();
    final toTokenString = prefs.getString(_tokenSwapKey);
    if (toTokenString == null) {
      return null;
    }
    // return TradeToken.fromJson(jsonDecode(toTokenString));
  }
}
