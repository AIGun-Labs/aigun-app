import '../../../utils/storage/secure/user_storage_service.dart';
import '../http/dio_client.dart';

class WalletUserApi {
  final DioClient _dioClient;
  WalletUserApi(this._dioClient, this._userStorage);
  final UserStorageService _userStorage;
  static const String _basePath = '/api/v1/wallet_user';

  Future<void> createWalletUser({
    required String paymentPin,
  }) async {
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
