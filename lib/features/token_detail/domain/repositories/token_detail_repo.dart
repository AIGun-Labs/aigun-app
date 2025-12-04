import '../../../../core/types/result.dart';
import '../../../../data/models/intel/intel.dart';
import '../../../../shared/domain/entities/intel_v2_entity.dart';
import '../entity/token_info_entity.dart';
import '../entity/token_profit_entity.dart';
import '../entity/token_security_entity.dart';
import '../entity/urls_entity.dart';

abstract interface class TokenDetailRepo {
  Future<Result<TokenInfoEntity>> fetchTokenDetailInfo({
    required String address,
    required String network,
    String? type,
  });

  Future<Result<TokenSecurityEntity>> fetchTokenSecurity({
    required String address,
    required String network,
  });

  Future<List<Intel>> fetchTokenAssociatedIntels(
    String address,
    String network,
    int? page,
    int? pageSize,
  );

  Future<Result<UrlsEntity>> fetchUrls({
    required String address,
    required String network,
  });

  Future<Result<int>> fetchIntelCount({
    required String address,
    required String network,
  });

  Future<Result<IntelV2Entity>> fetchLatestIntelV2({
    required String address,
    required String network,
  });

  Future<Result<TokenProfitEntity>> fetchTokenProfit({
    required String address,
    required String network,
  });
}
