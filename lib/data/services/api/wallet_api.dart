import '../../../core/service_locator.dart';
import '../../../utils/logger.dart';
import '../../../utils/storage/secure/user_storage_service.dart';
import '../../models/index.dart';
import '../http/dio_client.dart';

class WalletApi {
  final DioClient _dioClient;
  WalletApi(this._dioClient);

  static const String _basePath = '/api/v1/wallet';

  Future<void> createWalletUser({
    required String paymentPin,
  }) async {
    final user = await getIt<UserStorageService>().getUser();

    await _dioClient.post(
      '$_basePath/wallet_user/create',
      data: {
        'payment_pin': paymentPin,
        'email': user.email,
        'username': user.nickname,
      },
    );
  }

  Future<List<Chain>> getChains() async {
    final response = await _dioClient.get(
      '$_basePath/chains',
    );

    final chains = response['chains'] as List<dynamic>;

    return chains.map((chain) => Chain.fromJson(chain)).toList();
  }

  /// 发送代币
  Future<void> sendToken({
    required String walletId,
    required String password,
    required int chainId,
    required String toAddress,
    required String amount,
    required String tokenAddress,
  }) async {
    await _dioClient.post<void>(
      '$_basePath/transfer',
      data: {
        'wallet_id': walletId,
        'password': password,
        'chain_id': chainId,
        'to_address': toAddress,
        'amount': amount,
        'token_address': tokenAddress,
      },
    );
    // 响应拦截器已自动提取data字段，无需返回值的方法直接完成
  }

  /// 创建钱包
  Future<Wallet> createWallet({
    required String chainType,
  }) async {
    final response = await _dioClient.post(
      '$_basePath/',
      data: {
        'chain_type': chainType,
      },
    );
    // 响应拦截器已自动提取data字段，直接使用response.data
    return Wallet.fromJson(response as Map<String, dynamic>);
  }

  Future<Balance> getBalanceByWalletId(String walletId) async {
    final response = await _dioClient.get(
      '$_basePath/balance',
      queryParameters: {
        'wallet_id': walletId,
      },
    );

    return Balance.fromJson(response);
  }

  Future getBalanceByWalletIdAndChainId(
      String walletId, String chainId, String address) async {
    final response = await _dioClient.get(
      '$_basePath/token/balance/$chainId/$address',
      queryParameters: {
        'wallet_id': walletId,
      },
    );

    Logger.info('response: $response');

    return response['token']['balance'];
  }

  /// 删除钱包
  Future<bool> deleteWallet({
    required String address,
  }) async {
    await _dioClient.delete<void>(
      '$_basePath/wallets/$address',
    );
    // 响应拦截器已自动提取data字段，删除成功时返回true
    return true;
  }

  /// 获取钱包列表
  Future<List<Wallet>> getWalletList() async {
    final response = await _dioClient.get(
      '$_basePath/list',
    );

    final wallets = response['wallets'] as List<dynamic>;

    if (wallets.isEmpty) {
      return [];
    }

    return wallets.map((wallet) => Wallet.fromJson(wallet)).toList();
  }

  /// 获取余额
  Future<Balance> getBalance() async {
    final response = await _dioClient.get(
      '$_basePath/balances',
    );
    return Balance.fromJson(response.data);
  }

  /// 获取指定地址的余额
  // Future<Balance> getBalanceByAddress({
  //   required String walletId,
  // }) async {
  //   final response = await _dioClient.get(
  //     '$_basePath/balances',
  //     queryParameters: {
  //       "organization_id": "baa83bed-f411-4660-ace9-c663d57e9830",
  //       "wallet_user_id": "44920dc3-3920-435a-821e-956a7fc98ab0",
  //       "wallet_id": walletId,
  //     },
  //   );
  //   // 响应拦截器已自动提取data字段，直接使用response.data
  //   return Balance.fromJson(response);
  // }

  /// 导出私钥
  Future<ExportPrivateKey> exportPrivateKey({
    required String address,
    required String password,
  }) async {
    final response = await _dioClient.post(
      '$_basePath/privatekey',
      data: {
        'address': address,
        'password': password,
      },
    );
    // 响应拦截器已自动提取data字段，直接使用response.data
    return ExportPrivateKey.fromJson(response as Map<String, dynamic>);
  }
}
