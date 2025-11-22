import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/device_identifier_service.dart';
import '../../../utils/device_helper.dart';
import '../../../utils/signature_service.dart';
import '../../../utils/storage/secure/token_storage_service.dart';
import '../../../utils/storage/secure/user_storage_service.dart';
import '../../models/auth/refresh/refresh.dart';
import '../../models/index.dart';
import '../http/dio_client.dart';

class AuthApi {
  final DioClient _dioClient;
  AuthApi(this._dioClient, this._tokenStorage, this._userStorage);

  static const String _basePathV1 = '/api/v1/intel-user';
  static const String _basePathV2 = '/api/v2/intel-user';
  static const String _inviteBasePath = '/api/v1/invite';

  final TokenStorageService _tokenStorage;
  final UserStorageService _userStorage;

  Future<String> getImageResource(String url) async {
    final response = await _dioClient.get(url);
    return response.data;
  }

  Future<Map<String, String>> createHeaders(
      String nickname, String email) async {
    final fingerprintId = await DeviceIdentifierService.getDeviceId();
    // get device type
    final deviceType = DeviceHelper.getDeviceType();
    final emailSignature =
        await SignatureService.createSignature(message: email);

    // nickname + deviceType + deviceId = signature
    final signature = await SignatureService.createSignature(
      message: nickname + deviceType + fingerprintId,
    );
    final token = await SignatureService.createSignature(
        message: DateTime.now().microsecondsSinceEpoch.toString());

// Don't look at the top. Look here. The real signature is x-device-type
    return {
      'x-device-id': emailSignature,
      'x-token': token,
      'x-device-type': signature,
    };
  }

  Future<void> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    final response = await _dioClient.post(
      '$_basePathV1/verify-code',
      data: {
        'email': email,
        'code': code,
      },
    );

    if (response is Map<String, dynamic>) {
      final user = response['user'];
      final accessToken = response['access_token'];
      final refreshToken = response['refresh_token'];
      if (user != null && accessToken != null && refreshToken != null) {
        await _userStorage.saveUser(jsonEncode(user));

        await _tokenStorage.saveTokens(
            accessToken: accessToken, refreshToken: refreshToken);
      }
    }
  }

  Future<void> sendVerificationCode(String email) async {
    await _dioClient.post(
      '$_basePathV1/send-verification-code',
      data: {
        'email': email,
      },
    );
  }

  Future<void> register(
    String email,
    String code,
    String nickname,
    String inviteCode,
    // String paymentPin,
  ) async {
    final fingerprintId = await DeviceIdentifierService.getDeviceId();
    // get device type
    final deviceType = DeviceHelper.getDeviceType();
    final emailSignature =
        await SignatureService.createSignature(message: email);

    final message = nickname + deviceType + fingerprintId;
    // nickname + deviceType + deviceId = signature
    final signature = await SignatureService.createSignature(
      message: message,
    );
    final token = await SignatureService.createSignature(
        message: DateTime.now().microsecondsSinceEpoch.toString());

    final Map<String, dynamic> data = {
      'email': email,
      'verify_code': code,
      'nickname': nickname,
      'device_id': await DeviceIdentifierService.getDeviceId(),
      'device_type': DeviceHelper.getDeviceType(),
      // "payment_pin": paymentPin
    };

    // if invite code is not empty, add it to the data
    if (inviteCode.trim().isNotEmpty) {
      data['invite_code'] = inviteCode;
    }

    final response = await _dioClient.post(
      '$_basePathV2/register',
      data: data,
      options: Options(
        headers: {
          'x-device-id': emailSignature,
          'x-token': token,
          'x-device-type': signature,
        },
      ),
    );

    if (response is Map<String, dynamic>) {
      final user = response['user'];
      final accessToken = response['access_token'];
      final refreshToken = response['refresh_token'];
      if (user != null && accessToken != null && refreshToken != null) {
        await _userStorage.saveUser(jsonEncode(user));

        await _tokenStorage.saveTokens(
            accessToken: accessToken, refreshToken: refreshToken);
      }
    }
  }

// Refresh Tokens
  Future<RefreshTokenResponse> refreshToken() async {
    final response = await _dioClient.post(
      '$_basePathV1/refresh',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${_tokenStorage.getRefreshToken()}',
        },
      ),
    );

    return RefreshTokenResponse.fromJson(response);
  }

// Create Wallet User
  Future<ApiResponse<void>> createWalletUser(
      {required String username,
      required String email,
      required String paymentPin}) async {
    return await _dioClient.post('$_basePathV1/user/wallet', data: {
      'username': username,
      'email': email,
      'payment_pin': paymentPin,
    });
  }

  Future<void> createThanksMessage(int messageId, String inviteCode) async {
    await _dioClient.post('$_inviteBasePath/message', data: {
      // "user_id": userId,
      'message_id': messageId,
      'invite_code': inviteCode,
    });
  }
}
