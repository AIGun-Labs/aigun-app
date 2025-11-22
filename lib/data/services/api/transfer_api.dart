import '../../../utils/logger.dart';
import '../../models/index.dart';
import '../../models/transfer/index.dart';
import '../index.dart';

class TransferApi {
  static const String _basePath = '/api/v1/wallet_tx';

  final DioClient _dioClient;
  TransferApi(this._dioClient);

  /// 获取转账报价
  Future<TransferQuote> getTransferQuote({
    required String inputMint,
    required String outputMint,
    required String amount,
  }) async {
    final Map<String, dynamic> resposne =
        await _dioClient.post<Map<String, dynamic>>(
      '$_basePath/quote',
      data: {
        'inputMint': inputMint,
        'outputMint': outputMint,
        'amount': amount,
      },
    );

    Logger.info('resposne: $resposne');

    return TransferQuote.fromJson(resposne);
  }

// 普通的转账接口
  Future<TransferTransaction> transferToken({
    required String chainId,
    required String walletId,
    required String fromAddress,
    required String toAddress,
    required String amount,
    required String tokenMint,
    required String network,
  }) async {
    final path = '$_basePath/$network/transfer';

    // 请求接口
    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>(
      path,
      data: {
        'chain_id': chainId,
        'from_address': fromAddress,
        'to_address': toAddress,
        'amount': amount,
        'token_mint': tokenMint,
        'wallet_id': walletId
      },
    );

    return TransferTransaction.fromJson(response);
  }

// 携带挑战的转账接口
  Future<TransferTransaction> transferTokenWithChallenge(
      {required Challenge challenge}) async {
    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>(
      '$_basePath/transfer',
      data: {
        'challenge': challenge.toJson(),
      },
    );

    return TransferTransaction.fromJson(response);
  }

// 携带短信验证码的转账接口
  Future<TransferTransaction> transferTokenWithSmsChallenge(
      {required String smsCode}) async {
    final Map<String, dynamic> response =
        await _dioClient.post<Map<String, dynamic>>(
      '$_basePath/transfer',
      data: {
        'challenge': {
          'sms': {
            'code': smsCode,
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
        await _dioClient.post<Map<String, dynamic>>(
      '$_basePath/transfer',
      data: {
        'captcha': {
          'key': captchaKey,
          'dots': captchaDots,
        },
      },
    );

    Logger.info('response: $response');

    return TransferTransaction.fromJson(response);
  }

  /// 获取Gas费
  Future<Gas> getGasFee({
    required String chainId,
    required String address,
  }) async {
    final path = '$_basePath/gas/$chainId/$address';

    final Map<String, dynamic> response =
        await _dioClient.get<Map<String, dynamic>>(
      path,
    );

    // 响应拦截器已自动提取data字段，直接使用response
    return Gas.fromJson(response);
  }

  Future<TransferTransaction> getTransactionStatus(
      {required String chainId,
      required String txHash,
      required String network}) async {
    final path = '$_basePath/$network/status/$chainId/$txHash';

    final Map<String, dynamic> response =
        await _dioClient.get<Map<String, dynamic>>(
      path,
    );

    return TransferTransaction.fromJson(response);
  }
}
