import 'package:dio/dio.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/data/models/user/profit/profit.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:get_it/get_it.dart';

import '../../models/index.dart';

class UserApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();
  static const String _basePath = '/api/v1/intel-user';
  static const String _basePathTrade = "/api/v1/trade/favorite-token";

  Future<User> getUserInfo() async {
    final response = await _dioClient.get("$_basePath/info");

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

//
  Future<UserProfit> getTokenProfit({
    required String walletId,
    required String address,
    required String network,
  }) async {
    final response =
        await _dioClient.get("$_basePath/token-profit", queryParameters: {
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

  Future<TradeConfig> getUserTradeConfig(String chainName) async {
    final response = await _dioClient.get("$_basePath/trx-config",
        queryParameters: {"chain_name": chainName});

    return TradeConfig.fromJson(response);
  }

  Future<void> updateTradeConfig({
    required String chainName,
    required TradeMode mode,
    required TradeCustomSetting config,
  }) async {
    await _dioClient.put("$_basePath/trx-config", data: {
      "chain_name": chainName,
      "mode": mode.name,
      "config": {
        "slippage": config.slippage,
        "mev_protect": config.mevProtect,
        "priority_fee": config.priorityFee,
        "tip_fee": config.tipFee,
        "gas_price": config.gasPrice,
      },
    });
  }

  Future<TradeLiveData> getTradeLiveData(String chainId) async {
    final response = await _dioClient
        .get("$_basePath/live-data", queryParameters: {"chain_id": chainId});
    return TradeLiveData.fromJson(response);
  }

  Future<List<dynamic>> getUserTokenHoldingsByAddress(
      {required String address, required String chainName}) async {
    final response = await _dioClient.get("$_basePath/holdings",
        queryParameters: {"address": address, "chain_name": chainName});
    return response.map((e) => e).toList();
  }
}
