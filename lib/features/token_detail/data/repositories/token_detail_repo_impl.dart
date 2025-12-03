import '../../../../core/types/result.dart';
import '../../../../data/models/intel/intel.dart';
import '../../domain/entity/token_info_entity.dart';
import '../../domain/entity/token_security_entity.dart';
import '../../domain/entity/urls_entity.dart';
import '../../domain/repositories/token_detail_repo.dart';
import '../mappers/detail_info_mapper.dart';
import '../mappers/token_security_mapper.dart';
import '../mappers/urls_mapper.dart';
import '../sources/token_detail_remote_source.dart';

class TokenDetailRepoImpl implements TokenDetailRepo {
  final TokenDetailRemoteSource _remoteSource;
  TokenDetailRepoImpl(this._remoteSource);

  @override
  Future<Result<int>> fetchIntelCount({
    required String address,
    required String network,
  }) async {
    try {
      final data = await _remoteSource.getIntelCount(
        address: address,
        network: network,
      );
      return Result.success(data);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<List<Intel>> fetchTokenAssociatedIntels(
    String address,
    String network,
    int? page,
    int? pageSize,
  ) async {
    try {
      final data = await _remoteSource.getTokenAssociatedIntels(
        address,
        network,
        page,
        pageSize,
      );
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<TokenInfoEntity>> fetchTokenDetailInfo({
    required String address,
    required String network,
    String? type,
  }) async {
    try {
      final data = await _remoteSource.getDetailInfo(
        address: address,
        network: network,
        type: type,
      );
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<TokenSecurityEntity>> fetchTokenSecurity({
    required String address,
    required String network,
  }) async {
    try {
      final data = await _remoteSource.getTokenSecurity(
        address: address,
        network: network,
      );
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UrlsEntity>> fetchUrls({
    required String address,
    required String network,
  }) async {
    try {
      final data = await _remoteSource.getUrls(
        address: address,
        network: network,
      );
      return Result.success(data.toEntity());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
