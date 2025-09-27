import 'dart:convert';

import 'package:flutter_aigun/widgets/token/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSwapStorage {
  static const String _tokenSwapKey = "token_swap";

  Future<void> saveFromToken(Token fromToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenSwapKey, fromToken.toString());
  }

  Future<Token?> getFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final fromTokenString = prefs.getString(_tokenSwapKey);
    if (fromTokenString == null) {
      return null;
    }
    return Token.fromJson(jsonDecode(fromTokenString));
  }


  Future<void> saveToToken(Token toToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenSwapKey, toToken.toString());
  }

  Future<Token?> getToToken() async {
    final prefs = await SharedPreferences.getInstance();
    final toTokenString = prefs.getString(_tokenSwapKey);
    if (toTokenString == null) {
      return null;
    }
    return Token.fromJson(jsonDecode(toTokenString));
  }
}
