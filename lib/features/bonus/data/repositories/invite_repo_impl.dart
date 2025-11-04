import 'package:flutter_aigun/core/types/result.dart';
import 'package:flutter_aigun/features/bonus/data/mappers/invite_info_mapper.dart';

import '../../domain/entities/invite_info_entity.dart';
import '../../domain/repositories/invite_repo.dart';
import '../sources/invite_remote_source.dart';

class InviteRepositoryImpl implements InviteRepository {
  final InviteRemoteSource _remote;
  InviteRepositoryImpl(this._remote);

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
  Future<Result<bool>> claimGold() async {
    try {
      await _remote.claimGold();
      return const Result.success(true);
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
