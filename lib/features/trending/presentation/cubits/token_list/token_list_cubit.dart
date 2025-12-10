import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_list_cubit.freezed.dart';
part 'token_list_state.dart';

class TokenListCubit extends Cubit<TokenListState> {
  TokenListCubit() : super(TokenListState.initial());
}
