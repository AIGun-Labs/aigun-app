import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/intel/intel.dart';
import '../../../domain/usecases/fetch_intel_count.dart';

part 'intels_cubit.freezed.dart';
part 'intels_state.dart';

class IntelsCubit extends Cubit<IntelsState> {
  final FetchIntelCount _fetchIntelCount;

  IntelsCubit(this._fetchIntelCount) : super(const IntelsState());

  Future<void> getIntelCount({
    required String address,
    required String network,
  }) async {
    final result = await _fetchIntelCount.call(
      address: address,
      network: network,
    );
    emit(IntelsState(status: IntelsStatus.success, count: result.value));
  }
}
