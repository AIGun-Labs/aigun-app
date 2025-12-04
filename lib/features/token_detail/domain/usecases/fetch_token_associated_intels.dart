import '../../../../data/models/intel/intel.dart';
import '../repositories/token_detail_repo.dart';

class FetchTokenAssociatedIntels {
  final TokenDetailRepo _repository;

  FetchTokenAssociatedIntels(this._repository);

  Future<List<Intel>> call({
    required String address,
    required String network,
    int? page,
    int? pageSize,
  }) async => await _repository.fetchTokenAssociatedIntels(
    address,
    network,
    page,
    pageSize,
  );
}
