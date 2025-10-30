import 'package:flutter_aigun/core/types/result.dart';

import '../repositories/invite_repository.dart';

class FetchClaimGold {
  final InviteRepository _repository;

  FetchClaimGold(this._repository);

  Future<Result<bool>> call() async => await _repository.claimGold();
}
