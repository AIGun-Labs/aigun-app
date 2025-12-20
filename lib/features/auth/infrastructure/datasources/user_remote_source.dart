import '../../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../../data/models/user/live_data/live_data.dart';
import '../../../../data/models/user/trade_config/trade_config.dart';
import '../../../../enums/trade_mode.dart';
import '../../../../infrastructure/network/dio_client.dart';
import '../../../../shared/utils/trade_config_utils.dart';
import '../models/auth_user_model.dart';

class UserRemoteSource {
  UserRemoteSource(this._dioClient);
  final DioClient _dioClient;
  static const String _basePath = '/api/v1/intel-user';

  Future<AuthUserModel> getUserInfo() async {
    final response = await _dioClient.get('$_basePath/info');

    return AuthUserModel.fromJson(response);
  }

  Future<TradeLiveData> getTradeLiveData(String network) async {
    final response = await _dioClient.get(
      '$_basePath/live-data',
      queryParameters: {'network': network},
    );
    return TradeLiveData.fromJson(response);
  }

  Future<TradeConfig> getUserTradeConfig(String network) async {
    final response = await _dioClient.get(
      '$_basePath/trx-config',
      queryParameters: {'network': network, 'chain_name': network},
    );

    return TradeConfig.fromJson(response);
  }

  Future<void> updateTradeConfig({
    required String network,
    required TradeMode mode,
    required TradeCustomSetting config,
  }) async {
    final netConfig = TradeConfigUtils().getConfigByNetwork(network, config);

    await _dioClient.put(
      '$_basePath/trx-config',
      data: {'network': network, 'mode': mode.name, 'config': netConfig},
    );
  }
}
