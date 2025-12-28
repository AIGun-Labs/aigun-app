import '../../../../infrastructure/network/dio_client.dart';
import '../models/invite_info_model.dart';

class InviteRemoteSource {
  InviteRemoteSource(this._dioClient);
  final DioClient _dioClient;

  static const String _basePath = '/api/v1/invite';

  static const String _claimGoldPath = '$_basePath/gold/claim';

  static const String _activeInviteCodePath = '$_basePath/active';

  static const String _realTimeBalancePath = '$_basePath/realtime';
  Future<InviteInfoModel> fetchInviteInfo() async {
    try {
      final data = await _dioClient.get(_basePath);
      return InviteInfoModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> claimGold() async {
    try {
      await _dioClient.post(_claimGoldPath);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> activateInviteCode(String inviteCode) async {
    try {
      await _dioClient.post(
        _activeInviteCodePath,
        data: {'active_code': inviteCode},
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getRealTimeBalance() async {
    try {
      final data = await _dioClient.get(_realTimeBalancePath);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
