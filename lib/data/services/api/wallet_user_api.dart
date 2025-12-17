import '../../../infrastructure/network/dio_client.dart';
import '../../../utils/storage/secure/user_storage_service.dart';

class WalletUserApi {
  WalletUserApi(this._dioClient, this._userStorage);
  final DioClient _dioClient;
  final UserStorageService _userStorage;
  static const String _basePath = '/api/v1/wallet_user';

  Future<void> createWalletUser({required String paymentPin}) async {
    final user = await _userStorage.getUser();

    await _dioClient.post(
      '$_basePath/create',
      data: {
        'payment_pin': paymentPin,
        'email': user.email,
        'username': user.nickname,
      },
    );
  }
}
