import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_token_cubit.freezed.dart';
part 'list_token_state.dart';

//TODO: 等待后端统一接口
class ListTokenCubit extends Cubit<ListTokenState> {
  ListTokenCubit() : super(ListTokenState.initial());
}
