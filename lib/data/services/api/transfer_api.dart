import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_aigun/data/models/index.dart';
import 'package:flutter_aigun/data/models/transfer/index.dart';
import 'package:flutter_aigun/data/services/index.dart';

class TransferApi {
  static const String _basePath = '/api/v1/wallet_tx';

  /// 获取转账报价
  Future<TransferQuote> getTransferQuote({
    required String inputMint,
    required String outputMint,
    required String amount,
  }) async {
    final Map<String, dynamic> resposne =
        await getIt<DioClient>().post<Map<String, dynamic>>(
      "$_basePath/quote",
      data: {
        'inputMint': inputMint,
        'outputMint': outputMint,
        'amount': amount,
      },
    );

    print("resposne: $resposne");

    return TransferQuote.fromJson(resposne);
  }

// 普通的转账接口
  Future<TransferTransaction> transferToken({
    required int chainId,
    required String fromAddress,
    required String toAddress,
    required String amount,
    required String tokenMint,
    // required String organizationId,
    // required String walletUserId,
    // required String paymentPin,
    // Map<String, dynamic>? challenge
  }) async {
    // 请求接口
    final Map<String, dynamic> response =
        await getIt<DioClient>().post<Map<String, dynamic>>(
      "$_basePath/transfer",
      data: {
        "chain_id": chainId,
        "from_address": fromAddress,
        "to_address": toAddress,
        "amount": amount,
        "token_mint": tokenMint,
        // "organization_id": organizationId,
        // "wallet_user_id": walletUserId,
        // "payment_pin": paymentPin,
        // "challenge": challenge,
      },
    );

    return TransferTransaction.fromJson(response);
  }

// 携带挑战的转账接口
  Future<TransferTransaction> transferTokenWithChallenge(
      {required Challenge challenge}) async {
    final Map<String, dynamic> response =
        await getIt<DioClient>().post<Map<String, dynamic>>(
      "$_basePath/transfer",
      data: {
        "challenge": challenge.toJson(),
      },
    );

    return TransferTransaction.fromJson(response);
  }

// 携带短信验证码的转账接口
  Future<TransferTransaction> transferTokenWithSmsChallenge(
      {required String smsCode}) async {
    final Map<String, dynamic> response =
        await getIt<DioClient>().post<Map<String, dynamic>>(
      "$_basePath/transfer",
      data: {
        "challenge": {
          "sms": {
            "code": smsCode,
          },
        }
      },
    );

    return TransferTransaction.fromJson(response);
  }

// 携带图形点选文字验证码的转账接口
  Future<TransferTransaction> transferTokenWithCaptchaChallenge({
    required String captchaKey,
    required String captchaDots,
  }) async {
    final Map<String, dynamic> response =
        await getIt<DioClient>().post<Map<String, dynamic>>(
      "$_basePath/transfer",
      data: {
        "captcha": {
          "key": captchaKey,
          "dots": captchaDots,
        },
      },
    );

    print("response: $response");

    return TransferTransaction.fromJson(response);
  }

  /// 获取Gas费
  Future<Gas> getGasFee({
    required String chainId,
  }) async {
    final Map<String, dynamic> response =
        await getIt<DioClient>().get<Map<String, dynamic>>(
      '$_basePath/gas/$chainId',
    );
    print("response: $response");
    // 响应拦截器已自动提取data字段，直接使用response
    return Gas.fromJson(response);
  }
}
