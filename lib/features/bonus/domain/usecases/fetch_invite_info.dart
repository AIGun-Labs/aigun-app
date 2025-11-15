import '../../../../core/types/result.dart';

import '../entities/invite_info_entity.dart';
import '../repositories/invite_repo.dart';

class FetchInviteInfo {
  final InviteRepository _repository;

  FetchInviteInfo(this._repository);

  Future<Result<InviteInfoEntity>> call() async =>
      await _repository.fetchInviteInfo();
}
