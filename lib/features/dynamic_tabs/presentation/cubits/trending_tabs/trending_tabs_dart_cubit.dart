import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/option_tab_entity.dart';

part 'trending_tabs_dart_cubit.freezed.dart';
part 'trending_tabs_dart_state.dart';

class TrendingTabsDartCubit extends Cubit<TrendingTabsDartState> {
  TrendingTabsDartCubit() : super(const TrendingTabsDartState());
}
