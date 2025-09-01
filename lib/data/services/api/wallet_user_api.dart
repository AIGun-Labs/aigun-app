import 'package:flutter_aigun/data/services/http/dio_client.dart';
import 'package:flutter_aigun/utils/storage/secure/user_storage_service.dart';
import 'package:get_it/get_it.dart';

class WalletUserApi {
  final DioClient dioClient = GetIt.instance<DioClient>();

  static const String _basePath = '/api/v1/wallet_user';

  Future<void> createWalletUser({
    required String paymentPin,
  }) async {
    final user = await UserStorageService().getUser();

    await dioClient.post(
      "$_basePath/create",
      data: {
        'payment_pin': paymentPin,
        "email": user?.email,
        "username": user?.nickname,
      },
    );
  }
}
