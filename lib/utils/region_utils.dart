import 'dart:io';
import 'package:flutter_aigun/utils/logger.dart';

/// 地区判断工具类
/// 用于判断用户是否在中国大陆地区
class RegionUtils {

  /// 判断用户是否在中国大陆地区
  /// 
  /// 判断策略：
  /// 1. 优先使用系统语言和地区设置
  /// 2. 作为备选方案，可以通过 IP 地址判断（需要额外实现）
  /// 
  /// 返回：
  /// - true: 中国大陆地区
  /// - false: 其他地区
  static Future<bool> isUserInMainlandChina() async {
    try {
      // 获取系统地区代码
      final String locale = Platform.localeName; // 例如：zh_CN, en_US
      
      Logger.debug('系统地区代码: $locale');

      // 判断是否为中国大陆地区
      // zh_CN 代表简体中文（中国大陆）
      // zh_TW 代表繁体中文（台湾）
      // zh_HK 代表繁体中文（香港）
      final isMainlandChina = locale.toLowerCase().startsWith('zh_cn');
      
      Logger.info('用户地区判断: ${isMainlandChina ? "中国大陆" : "其他地区"}');
      
      return isMainlandChina;
    } catch (e) {
      Logger.error('判断用户地区失败', e);
      // 发生错误时，默认返回 false（使用 Firebase Analytics）
      return false;
    }
  }

  /// 通过 IP 地址判断是否在中国大陆（可选实现）
  /// 
  /// 注意：这需要调用第三方 IP 定位服务，例如：
  /// - https://ipapi.co/
  /// - https://ip-api.com/
  /// - 阿里云 IP 定位服务
  /// 
  /// 此方法为示例，实际使用时需要根据具体的 API 进行实现
  static Future<bool> isUserInMainlandChinaByIP() async {
    try {
      // TODO: 实现 IP 地址判断逻辑
      // 例如：
      // final response = await http.get(Uri.parse('https://ipapi.co/json/'));
      // final data = jsonDecode(response.body);
      // return data['country_code'] == 'CN';
      
      Logger.debug('IP 地址判断功能尚未实现');
      return false;
    } catch (e) {
      Logger.error('通过 IP 判断用户地区失败', e);
      return false;
    }
  }

  /// 获取用户的语言代码
  /// 例如：zh, en, ja
  static String getUserLanguageCode() {
    try {
      final String locale = Platform.localeName;
      final String languageCode = locale.split('_').first;
      return languageCode;
    } catch (e) {
      Logger.error('获取用户语言代码失败', e);
      return 'en'; // 默认返回英语
    }
  }

  /// 获取用户的国家代码
  /// 例如：CN, US, JP
  static String getUserCountryCode() {
    try {
      final String locale = Platform.localeName;
      final parts = locale.split('_');
      if (parts.length > 1) {
        return parts.last.toUpperCase();
      }
      return 'US'; // 默认返回美国
    } catch (e) {
      Logger.error('获取用户国家代码失败', e);
      return 'US'; // 默认返回美国
    }
  }

  /// 判断是否为中文环境（包括大陆、台湾、香港）
  static bool isChineseEnvironment() {
    try {
      final String languageCode = getUserLanguageCode();
      return languageCode.toLowerCase() == 'zh';
    } catch (e) {
      Logger.error('判断中文环境失败', e);
      return false;
    }
  }
}

