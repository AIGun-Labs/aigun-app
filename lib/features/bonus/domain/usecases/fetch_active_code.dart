import 'package:flutter_aigun/core/types/result.dart';

import '../repositories/invite_repository.dart';

class FetchActiveCode {
  final InviteRepository _repository;

  FetchActiveCode(this._repository);

  Future<Result<bool>> call(String inviteCode) async =>
      await _repository.activateInviteCode(inviteCode);
}
