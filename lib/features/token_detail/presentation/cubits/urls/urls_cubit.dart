import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entity/urls_entity.dart';
import '../../../domain/usecases/fetch_urls.dart';

part 'urls_cubit.freezed.dart';
part 'urls_state.dart';

class UrlsCubit extends Cubit<UrlsState> {
  final FetchUrls _fetchUrls;

  UrlsCubit(this._fetchUrls) : super(UrlsState.initial());

  Future<void> fetchUrls({
    required String address,
    required String network,
  }) async {
    final result = await _fetchUrls.call(address: address, network: network);
    if (result.isSuccess) {
      emit(UrlsState.success(result.value!));
    } else {
      emit(UrlsState.error(result.errorMessage!));
    }
  }
}
