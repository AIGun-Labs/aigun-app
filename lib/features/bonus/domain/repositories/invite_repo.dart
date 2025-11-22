import '../../../../core/types/result.dart';
import '../entities/invite_info_entity.dart';

abstract class InviteRepo {
  Future<Result<InviteInfoEntity>> fetchInviteInfo();

  Future<Result<bool>> claimGold();

  Future<Result<bool>> activateInviteCode(String inviteCode);

  Future<Result<String>> getRealTimeFunds();
}
