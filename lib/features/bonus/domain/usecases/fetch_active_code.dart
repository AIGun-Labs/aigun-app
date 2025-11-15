import '../../../../core/types/result.dart';

import '../repositories/invite_repo.dart';

class FetchActiveCode {
  final InviteRepository _repository;

  FetchActiveCode(this._repository);

  Future<Result<bool>> call(String inviteCode) async =>
      await _repository.activateInviteCode(inviteCode);
}
