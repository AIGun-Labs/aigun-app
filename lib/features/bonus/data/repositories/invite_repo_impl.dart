import '../../../../core/types/result.dart';
import '../../domain/entities/invite_info_entity.dart';
import '../../domain/repositories/invite_repo.dart';
import '../mappers/invite_info_mapper.dart';
import '../sources/invite_remote_source.dart';

class InviteRepoImpl implements InviteRepo {
  InviteRepoImpl(this._remote);
  final InviteRemoteSource _remote;

  @override
  Future<Result<InviteInfoEntity>> fetchInviteInfo() async {
    try {
      final data = await _remote.fetchInviteInfo();

      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> claimGold() async {
    try {
      await _remote.claimGold();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<bool>> activateInviteCode(String inviteCode) async {
    try {
      final result = await _remote.activateInviteCode(inviteCode);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<String>> getRealTimeFunds() async {
    try {
      final result = await _remote.getRealTimeBalance();
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
