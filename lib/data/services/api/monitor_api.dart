import 'package:flutter_aigun/utils/logger.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_aigun/data/models/intel_back/intel.dart';
import 'package:flutter_aigun/data/models/monitor/index.dart';
import 'package:flutter_aigun/data/services/http/dio_client.dart';

/// 监控 API 服务
class MonitorApi {
  final DioClient _dioClient = GetIt.instance<DioClient>();
  static const String _basePath = '/api/v1/subscription';

  /// 获取情报组列表
  Future<List<MonitorGroup>> getMonitorGroups({
    String? setId,
  }) async {
    final response = await _dioClient.get(
      '$_basePath/set/group/list',
      queryParameters: {
        'set_id': setId ?? '4',
      },
    );
    // 响应拦截器已自动提取data字段， 直接使用response.data
    return (response as List).map((e) => MonitorGroup.fromJson(e)).toList();
  }

  /// 获取监控列表
  Future<Monitor> getMonitor(String groupId) async {
    final response = await _dioClient.get(
      '$_basePath/tag/list',
      queryParameters: {
        'group_id': groupId,
      },
    );
    // 响应拦截器已自动提取data字段，直接使用response.data
    return Monitor.fromJson(response);
  }

  /// 添加情报组
  Future<void> addMonitorGroup({
    String? setId,
    required String name,
    String? description,
  }) async {
    await _dioClient.post(
      '$_basePath/group/add',
      data: {
        'set_id': setId ?? '4',
        'group_name': name,
        'group_description': description ?? '',
      },
    );
  }

  /// 更新情报组
  Future<void> updateMonitorGroup({
    required String id,
    String? name,
    String? description,
  }) async {
    await _dioClient.post(
      '$_basePath/group/update',
      data: {
        'group_id': id,
        'group_name': name,
        'group_description': description ?? '',
      },
    );
  }

  /// 删除情报组
  Future<void> deleteMonitorGroup({
    required String id,
  }) async {
    await _dioClient.post(
      '$_basePath/group/delete',
      data: {'group_id': id},
    );
  }

  /// 添加监控
  Future<void> addMonitor({
    required String groupId,
    String? tags,
    String? notTags,
    String? description,
  }) async {
    await _dioClient.post<Map<String, dynamic>>(
      '$_basePath/tag/add',
      data: {
        'group_id': groupId,
        'tags': tags ?? '00004ef3-479f-430e-8ee7-e01fa37595a2',
        'not_tags': notTags ?? '',
        'subscriptions_description': description ?? '',
      },
    );
  }

  /// 删除监控
  Future<void> deleteMonitor({
    required String groupId,
    String? subscriptionId,
  }) async {
    await _dioClient.post<Map<String, dynamic>>(
      '$_basePath/tag/delete',
      data: {
        'group_id': groupId,
        'subscription_id': subscriptionId,
      },
    );
  }

  /// 获取历史数据
  Future<HistoryData> getHistoryData({
    // String setId = '3',
    String? lastId,
    int? lastCreateAt,
  }) async {
    Logger.debug('HistoryData1: $lastId');
    Logger.debug('HistoryData2: $lastCreateAt');
    final response = await _dioClient.get<Map<String, dynamic>>(
      '$_basePath/history',
      queryParameters: {
        // 'set_id': setId,
        if (lastId != null) 'last_id': lastId,
        if (lastCreateAt != null) 'last_create_at': lastCreateAt,
      },
    );
    // 响应拦截器已自动提取data字段，直接使用response.data
    return HistoryData.fromJson(response);
  }
}
