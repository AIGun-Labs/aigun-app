import 'dart:io';

import 'logger.dart';

class RegionUtils {
  ///

  ///

  static Future<bool> isUserInMainlandChina() async {
    try {
      final String locale = Platform.localeName;

      Logger.debug(': $locale');

      final isMainlandChina = locale.toLowerCase().startsWith('zh_hans');

      Logger.info(': ${isMainlandChina ? "" : ""}');

      return isMainlandChina;
    } catch (e) {
      Logger.error('', e);

      return false;
    }
  }

  ///

  /// - https://ipapi.co/
  /// - https://ip-api.com/

  ///

  static Future<bool> isUserInMainlandChinaByIP() async {
    try {
      // final response = await http.get(Uri.parse('https://ipapi.co/json/'));
      // final data = jsonDecode(response.body);
      // return data['country_code'] == 'CN';

      Logger.debug('IP ');
      return false;
    } catch (e) {
      Logger.error(' IP ', e);
      return false;
    }
  }

  static String getUserLanguageCode() {
    try {
      final String locale = Platform.localeName;
      final String languageCode = locale.split('_').first;
      return languageCode;
    } catch (e) {
      Logger.error('', e);
      return 'en';
    }
  }

  static String getUserCountryCode() {
    try {
      final String locale = Platform.localeName;
      final parts = locale.split('_');
      if (parts.length > 1) {
        return parts.last.toUpperCase();
      }
      return 'US';
    } catch (e) {
      Logger.error('', e);
      return 'US';
    }
  }

  static bool isChineseEnvironment() {
    try {
      final String languageCode = getUserLanguageCode();
      return languageCode.toLowerCase() == 'zh';
    } catch (e) {
      Logger.error('', e);
      return false;
    }
  }
}
