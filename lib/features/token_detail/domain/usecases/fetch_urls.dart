import '../../../../core/types/result.dart';
import '../entities/urls_entity.dart';
import '../repositories/token_detail_repo.dart';

class FetchUrls {
  final TokenDetailRepo _repository;
  FetchUrls(this._repository);

  Future<Result<UrlsEntity>> call({
    required String address,
    required String network,
  }) async => await _repository.fetchUrls(address: address, network: network);
}
