import 'package:flutter_aigun/core/types/result.dart';

import '../repositories/invite_repository.dart';

class FetchRealtimeFunds {
  final InviteRepository _repository;

  FetchRealtimeFunds(this._repository);

  Future<Result<String>> call() async => await _repository.getRealTimeFunds();
}
