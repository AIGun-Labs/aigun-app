import 'package:dio/dio.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/models/user/profit/profit.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_aigun/shared/utils/trade_config_utils.dart';

import '../../models/index.dart';

class UserApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();
  static const String _basePath = '/api/v1/intel-user';
  // static const String _basePathTrade = "/api/v1/trade/favorite-token";
  static const String _basePathV2 = "/api/v1/intelligence";

  Future<User?> getUserInfo() async {
    final response = await _dioClient.get("$_basePath/info");

    if (response == null) {
      return null;
    }

    return User.fromJson(response);
  }

  /// TODO: 下面的API 都是旧的后面需要删除

  Future<ApiResponse<User>> createUserWithResponse({
    required String email,
    required String password,
    required String code,
    required String name,
  }) async {
    final response = await _dioClient.post(
      '$_basePath/register',
      data: {
        'email': email,
        'password': password,
        'code': code,
        'name': name,
      },
    );

    return ApiResponse.fromJson(
        response, (json) => User.fromJson(json as Map<String, dynamic>));
  }

  Future<User> createUser({
    required String email,
    required String password,
    required String code,
    required String name,
  }) async {
    final apiResponse = await createUserWithResponse(
      email: email,
      password: password,
      code: code,
      name: name,
    );

    return apiResponse.data!;
  }

  Future<ApiResponse<User>> signInWithResponse({
    required String username,
    required String password,
  }) async {
    final response = await _dioClient.post(
      '$_basePath/login',
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );
    return ApiResponse.fromJson(
        response, (json) => User.fromJson(json as Map<String, dynamic>));
  }

  Future<User> signIn({
    required String username,
    required String password,
  }) async {
    final apiResponse = await signInWithResponse(
      username: username,
      password: password,
    );
    return apiResponse.data!;
  }

  Future<String> getUserSubscriptions() async {
    final response = await _dioClient.get("$_basePath/ai-agents/follow");

    final subscriptions = (response as List).map((e) => e.toString()).toList();

    if (subscriptions.isEmpty) {
      return '';
    }

    return subscriptions.join('#');
  }

//
  Future<UserProfit> getTokenProfit({
    required String walletId,
    required String address,
    required String network,
    // required String chainId,
  }) async {
    final response =
        await _dioClient.get("$_basePathV2/token/profit", queryParameters: {
      "wallet_id": walletId,
      "address": address,
      "network": network,
    });
    return UserProfit.fromJson(response);
  }

  Future<ApiResponse<void>> sendVerificationCodeWithResponse({
    required String email,
    required String type,
  }) async {
    final response = await _dioClient.post(
      '$_basePath/send-verification-code',
      data: {
        'email': email,
        'type': type,
      },
    );
    return ApiResponse.fromJson(response, (json) => json);
  }

  Future<void> sendVerificationCode({
    required String email,
    required String type,
  }) async {
    await sendVerificationCodeWithResponse(
      email: email,
      type: type,
    );
    // 对于void方法，只需要检查是否成功，失败会抛出异常
  }

  /// 重置密码 - 返回完整响应（包含code、msg）
  Future<ApiResponse<void>> resetPasswordWithResponse({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    final response = await _dioClient.post(
      '$_basePath/reset-password',
      data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
      },
    );
    return ApiResponse.fromJson(response, (json) => json);
  }

  /// 重置密码 - 简化版本
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await resetPasswordWithResponse(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }

  /// 检测邮箱状态 - 返回完整响应（包含code、msg）
  Future<ApiResponse<bool>> checkEmailStatusWithResponse({
    required String email,
  }) async {
    final response = await _dioClient.get(
      '$_basePath/email-exists',
      queryParameters: {
        'email': email,
      },
    );
    return ApiResponse.fromJson(response, (json) => json as bool);
  }

  /// 检测邮箱状态 - 简化版本
  Future<bool> checkEmailStatus({
    required String email,
  }) async {
    final apiResponse = await checkEmailStatusWithResponse(email: email);
    return apiResponse.data!;
  }

  Future<TradeConfig> getUserTradeConfig(String network) async {
    final response = await _dioClient.get("$_basePath/trx-config",
        queryParameters: {"network": network, "chain_name": network});

    return TradeConfig.fromJson(response);
  }

  Future<void> updateTradeConfig({
    required String network,
    required TradeMode mode,
    required TradeCustomSetting config,
  }) async {
    final netConfig = TradeConfigUtils().getConfigByNetwork(network, config);

    await _dioClient.put("$_basePath/trx-config", data: {
      "network": network,
      "mode": mode.name,
      "config": netConfig,
    });
  }

  Future<TradeLiveData> getTradeLiveData(String chainId) async {
    final response = await _dioClient
        .get("$_basePath/live-data", queryParameters: {"chain_id": chainId});
    return TradeLiveData.fromJson(response);
  }
}
