import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/screens/add_token/cubit/add_token_state.dart';
import 'package:flutter_aigun/utils/web3/address.dart';

class AddTokenCubit extends Cubit<AddTokenState> {
  AddTokenCubit() : super(const AddTokenState(chainId: '1'));

  void updateTokenAddress(String address) {
    emit(state.copyWith(tokenAddress: address));
    emit(state.copyWith(addressError: _checkAddress()));
  }

  void updateChainId(String chainId) {
    emit(state.copyWith(chainId: chainId));
  }

  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void setSuccess(bool isSuccess) {
    emit(state.copyWith(isSuccess: isSuccess));
  }

  bool _checkAddress() {
    if (Web3Address.checkAddress(state.tokenAddress).$1 ==
            ChainAddressType.solana &&
        state.chainId == '501') {
      return false;
    }

    if (Web3Address.checkAddress(state.tokenAddress).$1 ==
            ChainAddressType.bitcoin &&
        state.chainId == '0') {
      return false;
    }

    if (Web3Address.checkAddress(state.tokenAddress).$1 ==
        ChainAddressType.evm) {
      return false;
    }

    return true;
  }

  void addToken() {
    if (state.chainId.isEmpty) {
      emit(state.copyWith(chainError: true));
      return;
    }

    setLoading(true);
    setSuccess(true);
  }

  void reset() {
    emit(const AddTokenState(chainId: '1'));
  }
}
