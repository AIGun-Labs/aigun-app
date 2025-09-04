import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeSettingCubit extends Cubit<TradeSettingState> {
  TradeSettingCubit() : super(const TradeSettingState());

  void updateTradeMode(TradeMode tradeMode) {
    emit(state.copyWith(tradeMode: tradeMode));
  }

  void updateSolanaCustomSetting(TradeCustomSetting updateSolanaCustomSetting) {
    emit(state.copyWith(solana: updateSolanaCustomSetting));
  }

  void updateEthereumCustomSetting(
      TradeCustomSetting updateEthereumCustomSetting) {
    emit(state.copyWith(ethereum: updateEthereumCustomSetting));
  }
}
