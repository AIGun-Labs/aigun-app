import '../../../infrastructure/network/dio_client.dart';
import '../../../utils/logger.dart';
import '../../models/index.dart';
import '../../models/transfer/index.dart';

class TransferApi {
  TransferApi(this._dioClient);
  static const String _basePath = '/api/v1/wallet_tx';

  final DioClient _dioClient;
  Future<TransferQuote> getTransferQuote({
    required String inputMint,
    required String outputMint,
    required String amount,
  }) async {
    final Map<String, dynamic>? resposne = await _dioClient
        .post<Map<String, dynamic>>(
          '$_basePath/quote',
          data: {
            'inputMint': inputMint,
            'outputMint': outputMint,
            'amount': amount,
          },
        );

    if (resposne == null) {
      throw Exception('Response is null');
    }

    Logger.info('resposne: $resposne');

    return TransferQuote.fromJson(resposne);
  }

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
    final Map<String, dynamic>? response = await _dioClient
        .post<Map<String, dynamic>>(
          path,
          data: {
            'chain_id': chainId,
            'from_address': fromAddress,
            'to_address': toAddress,
            'amount': amount,
            'token_mint': tokenMint,
            'wallet_id': walletId,
          },
        );

    if (response == null) {
      throw Exception('Response is null');
    }

    return TransferTransaction.fromJson(response);
  }

  Future<TransferTransaction> transferTokenWithChallenge({
    required Challenge challenge,
  }) async {
    final Map<String, dynamic>? response = await _dioClient
        .post<Map<String, dynamic>>(
          '$_basePath/transfer',
          data: {'challenge': challenge.toJson()},
        );

    if (response == null) {
      throw Exception('Response is null');
    }

    return TransferTransaction.fromJson(response);
  }

  Future<TransferTransaction> transferTokenWithSmsChallenge({
    required String smsCode,
  }) async {
    final Map<String, dynamic>? response = await _dioClient
        .post<Map<String, dynamic>>(
          '$_basePath/transfer',
          data: {
            'challenge': {
              'sms': {'code': smsCode},
            },
          },
        );

    if (response == null) {
      throw Exception('Response is null');
    }

    return TransferTransaction.fromJson(response);
  }

  Future<TransferTransaction> transferTokenWithCaptchaChallenge({
    required String captchaKey,
    required String captchaDots,
  }) async {
    final Map<String, dynamic>? response = await _dioClient
        .post<Map<String, dynamic>>(
          '$_basePath/transfer',
          data: {
            'captcha': {'key': captchaKey, 'dots': captchaDots},
          },
        );

    Logger.info('response: $response');

    if (response == null) {
      throw Exception('Response is null');
    }

    return TransferTransaction.fromJson(response);
  }

  Future<Gas> getGasFee({
    required String chainId,
    required String address,
  }) async {
    final path = '$_basePath/gas/$chainId/$address';

    final Map<String, dynamic>? response = await _dioClient
        .get<Map<String, dynamic>>(path);

    Logger.info('Transfer Api: Get gas fee response: $response');

    if (response == null) {
      throw Exception('Response is null');
    }
    return Gas.fromJson(response);
  }

  Future<TransferTransaction> getTransactionStatus({
    required String chainId,
    required String txHash,
    required String network,
  }) async {
    final path = '$_basePath/$network/status/$chainId/$txHash';

    final Map<String, dynamic>? response = await _dioClient
        .get<Map<String, dynamic>>(path);

    if (response == null) {
      throw Exception('Response is null');
    }

    return TransferTransaction.fromJson(response);
  }
}
