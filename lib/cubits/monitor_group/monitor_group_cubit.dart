import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/models/monitor/index.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:get_it/get_it.dart';

import '../../utils/logger.dart';
import '../index.dart';

class MonitorGroupCubit extends Cubit<MonitorGroupState> {
  MonitorGroupCubit() : super(const MonitorGroupState.initial());

  final MonitorApi _api = GetIt.instance<MonitorApi>();

  List<MonitorGroup> get monitorGroupList => state.maybeWhen(
        loaded: (monitorGroupList) => monitorGroupList,
        orElse: () => [],
      );

  Future<void> fetchMonitorGroupList() async {
    try {
      emit(const MonitorGroupState.loading());
      final data = await _api.getMonitorGroups();

      Logger.debug('fetchMonitorGroupList: $data');

      if (data.isEmpty) {
        emit(const MonitorGroupState.loaded(
            monitorGroupList: [MonitorGroup(id: '0')]));
      } else {
        emit(MonitorGroupState.loaded(monitorGroupList: data));
      }
    } catch (e) {
      emit(MonitorGroupState.error(message: e.toString()));
    }
  }

  Future<void> addMonitorGroup({
    required String name,
    String? description,
  }) async {
    try {
      emit(const MonitorGroupState.loading());
      await _api.addMonitorGroup(name: name, description: description);
      await fetchMonitorGroupList();
    } catch (e) {
      emit(MonitorGroupState.error(message: e.toString()));
    }
  }

  Future<void> updateMonitorGroup({
    required String id,
    String? name,
    String? description,
  }) async {
    try {
      emit(const MonitorGroupState.loading());
      await _api.updateMonitorGroup(
          id: id, name: name, description: description);
      await fetchMonitorGroupList();
    } catch (e) {
      emit(MonitorGroupState.error(message: e.toString()));
    }
  }

  Future<void> deleteMonitorGroup({
    required String id,
  }) async {
    try {
      emit(const MonitorGroupState.loading());
      await _api.deleteMonitorGroup(id: id);
      await fetchMonitorGroupList();
    } catch (e) {
      emit(MonitorGroupState.error(message: e.toString()));
    }
  }

  void onReorderGroup(int oldIndex, int newIndex) {
    final List<MonitorGroup> newGroups = List.from(monitorGroupList);
    final item = newGroups.removeAt(oldIndex);
    newGroups.insert(newIndex, item);
    emit(MonitorGroupState.loaded(monitorGroupList: newGroups));
  }
}
