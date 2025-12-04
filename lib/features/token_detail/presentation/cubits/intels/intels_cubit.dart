import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/intel/intel.dart';
import '../../../domain/usecases/fetch_intel_count.dart';
import '../../../domain/usecases/fetch_token_associated_intels.dart';

part 'intels_cubit.freezed.dart';
part 'intels_state.dart';

class IntelsCubit extends Cubit<IntelsState> {
  final FetchIntelCount _fetchIntelCount;
  final FetchTokenAssociatedIntels _fetchTokenAssociatedIntels;

  IntelsCubit(this._fetchIntelCount, this._fetchTokenAssociatedIntels)
    : super(const IntelsState());

  Future<void> getIntelCount({
    required String address,
    required String network,
  }) async {
    emit(
      state.copyWith(
        status: IntelsStatus.loading,
        network: network,
        address: address,
      ),
    );

    final result = await _fetchIntelCount.call(
      address: address,
      network: network,
    );
    emit(state.copyWith(status: IntelsStatus.success, count: result.value));
  }

  Future<void> getIntels() async {
    if (state.address.isEmpty || state.network.isEmpty) {
      return;
    }
    if (state.tokenAssociatedIntelsStatus ==
        TokenAssociatedIntelsStatus.loading) {
      return;
    }
    emit(
      state.copyWith(
        tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.loading,
      ),
    );

    try {
      final tokenAssociatedIntels = await _fetchTokenAssociatedIntels.call(
        address: state.address,
        network: state.network,
        page: state.intelsPage,
        pageSize: state.intelsPageSize,
      );

      if (tokenAssociatedIntels.isEmpty) {
        emit(
          state.copyWith(
            isNotMore: true,
            tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            intelsPage: state.intelsPage + 1,
            isNotMore: tokenAssociatedIntels.isEmpty,
            intels: [...state.intels, ...tokenAssociatedIntels],
            tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.success,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> refreshIntels() async {
    emit(
      state.copyWith(
        intelsPage: 1,
        intels: [],
        tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.loading,
      ),
    );
    try {
      final tokenAssociatedIntels = await _fetchTokenAssociatedIntels.call(
        address: state.address,
        network: state.network,
        page: 1,
        pageSize: state.intelsPageSize,
      );

      // 如果 token 是空的，则设置为没有更多
      if (tokenAssociatedIntels.isEmpty) {
        emit(
          state.copyWith(
            isNotMore: true,
            tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            intelsPage: 2,
            intels: tokenAssociatedIntels,
            tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.success,
          ),
        );
      }

      emit(
        state.copyWith(
          tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.success,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          tokenAssociatedIntelsStatus: TokenAssociatedIntelsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
