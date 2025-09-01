import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/data/services/api/index.dart';
import 'package:get_it/get_it.dart';

import '../../../data/models/monitor/index.dart';
import '../index.dart';

class MonitorCubit extends Cubit<MonitorState> {
  MonitorCubit() : super(const MonitorState.initial());

  final MonitorApi _api = GetIt.instance<MonitorApi>();

  String? _currentGroupId;

  /// 用于缓存不同groupId的数据，避免重复加载
  final Map<String, Monitor> _cachedData = {};

  /// 标记是否正在加载某个groupId的数据
  final Set<String> _loadingGroups = {};

  String? get currentGroupId => _currentGroupId;

  void setCurrentGroupId(String? groupId) {
    if (groupId == null) return;

    _currentGroupId = groupId;

    // 如果有缓存数据，直接使用缓存数据
    if (_cachedData.containsKey(groupId)) {
      emit(MonitorState.loaded(monitors: _cachedData[groupId]!));
      return;
    }

    // 否则，加载数据
    _loadData(groupId);
  }

  void refreshCurrentGroup() {
    if (_currentGroupId != null) {
      _loadData(_currentGroupId!);
    }
  }

  Future<void> _loadData(String groupId) async {
    // 如果正在加载，则不重复加载
    if (_loadingGroups.contains(groupId)) {
      return;
    }

    // 标记正在加载
    _loadingGroups.add(groupId);
    emit(const MonitorState.loading());

    try {
      final monitors = await _api.getMonitor(groupId);

      // 缓存数据
      _cachedData[groupId] = monitors;

      // 如果当前groupId仍然是请求的groupId，则更新状态
      if (_currentGroupId == groupId) {
        emit(MonitorState.loaded(monitors: monitors));
      }
    } catch (e) {
      // 只有当前groupId仍然是请求的groupId时，才发出错误状态
      if (_currentGroupId == groupId) {
        emit(MonitorState.error(message: e.toString()));
      }
    } finally {
      // 无论成功失败，都移除加载标记
      _loadingGroups.remove(groupId);
    }
  }

  Future<void> addMonitor({
    required String groupId,
    String? tags,
    String? notTags,
    String? description,
  }) async {
    await _api.addMonitor(
      groupId: groupId,
      tags: tags,
      notTags: notTags,
      description: description,
    );
    // 添加后强制刷新数据
    if (_currentGroupId == groupId) {
      await _loadData(groupId);
    }
  }

  Future<void> deleteMonitor({
    required String groupId,
    String? subscriptionId,
  }) async {
    await _api.deleteMonitor(
      groupId: groupId,
      subscriptionId: subscriptionId,
    );
    // 删除后强制刷新数据
    if (_currentGroupId == groupId) {
      await _loadData(groupId);
    }
  }

  /// 清除所有缓存数据
  void clearCache() {
    _cachedData.clear();
    _loadingGroups.clear();
    _currentGroupId = null;

    // 重置状态为初始状态
    emit(const MonitorState.initial());
  }

  /// 清除特定groupId的缓存数据
  void clearCacheForGroup(String groupId) {
    _cachedData.remove(groupId);
  }

  /// 获取缓存的Monitor数据
  Monitor? getCachedMonitor(String groupId) {
    return _cachedData[groupId];
  }
}
