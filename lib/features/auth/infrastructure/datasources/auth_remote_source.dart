import 'package:dio/dio.dart';

import '../../../../core/device_identifier_service.dart';
import '../../../../infrastructure/network/dio_client.dart';
import '../../../../utils/device_helper.dart';
import '../../../../utils/signature_service.dart';
import '../models/auth_response_model.dart';

/// Auth Remote Data Source
///
/// Handles all HTTP API calls related to authentication.
class AuthRemoteSource {
  AuthRemoteSource(this._client);
  final DioClient _client;

  static const String _basePathV1 = '/api/v1/intel-user';
  static const String _basePathV2 = '/api/v2/intel-user';
  static const String _inviteBasePath = '/api/v1/invite';

  /// Send verification code to email
  ///
  /// POST /api/v1/intel-user/send-verification-code
  Future<void> sendVerificationCode(String email) async {
    await _client.post(
      '$_basePathV1/send-verification-code',
      data: {'email': email},
    );
  }

  /// Verify email code
  ///
  /// POST /api/v1/intel-user/verify-code
  /// Returns user info and tokens if user exists
  Future<AuthResponseModel> verifyCode(String email, String code) async {
    final response = await _client.post(
      '$_basePathV1/verify-code',
      data: {'email': email, 'code': code},
    );

    if (response is Map<String, dynamic>) {
      return AuthResponseModel.fromJson(response);
    }

    return const AuthResponseModel();
  }

  /// Register new user
  ///
  /// POST /api/v2/intel-user/register
  /// Includes signature headers for security
  Future<AuthResponseModel> register({
    required String email,
    required String verifyCode,
    required String nickname,
    String? inviteCode,
  }) async {
    final fingerprintId = await DeviceIdentifierService.getDeviceId();
    final deviceType = DeviceHelper.getDeviceType();

    // Create signatures
    final emailSignature = await SignatureService.createSignature(
      message: email,
    );
    final message = nickname + deviceType + fingerprintId;
    final signature = await SignatureService.createSignature(message: message);
    final token = await SignatureService.createSignature(
      message: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    final Map<String, dynamic> data = {
      'email': email,
      'verify_code': verifyCode,
      'nickname': nickname,
      'device_id': fingerprintId,
      'device_type': deviceType,
    };

    if (inviteCode != null && inviteCode.trim().isNotEmpty) {
      data['invite_code'] = inviteCode;
    }

    final response = await _client.post(
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
      return AuthResponseModel.fromJson(response);
    }

    return const AuthResponseModel();
  }

  /// Submit thanks message for invite code
  ///
  /// POST /api/v1/invite/message
  Future<void> submitThanksMessage(int messageId, String inviteCode) async {
    await _client.post(
      '$_inviteBasePath/message',
      data: {'message_id': messageId, 'invite_code': inviteCode},
    );
  }
}
