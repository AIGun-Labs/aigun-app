import 'dart:async';
import 'package:flutter/foundation.dart';

enum RefreshState { idle, dragging, armed, refreshing, done }

class RefreshController extends ChangeNotifier {
  RefreshController({
    this.triggerDistance = 100.0,
    this.indicatorExtent = 56.0,
    this.springBackDuration = const Duration(milliseconds: 220),
  });

  final double triggerDistance; // 触发阈值（松手前只进入 armed）
  final double indicatorExtent; // 刷新中头部固定高度
  final Duration springBackDuration; // 回弹动画时长（简单实现里未用到）

  double _pullExtent = 0.0;
  RefreshState _state = RefreshState.idle;
  Future<void> Function()? _onRefresh;

  double get pullExtent => _pullExtent;
  RefreshState get state => _state;
  set onRefresh(Future<void> Function()? v) => _onRefresh = v;

  void _setPull(double v) {
    _pullExtent = v.clamp(0.0, 1e6);
    if (_state != RefreshState.refreshing && _state != RefreshState.done) {
      if (_pullExtent <= 0) {
        _state = RefreshState.idle;
      } else {
        _state = _pullExtent >= triggerDistance
            ? RefreshState.armed
            : RefreshState.dragging;
      }
    }
    notifyListeners();
  }

  /// 物理层“吃掉”的向下位移累加到头部拉距
  void accumulatePull(double delta) => _setPull(_pullExtent + delta);

  /// 松手时由 Binder 调用：拉距达阈值才触发刷新，否则回弹
  Future<void> release() async {
    if (_state == RefreshState.armed && _onRefresh != null) {
      _state = RefreshState.refreshing;
      _pullExtent = indicatorExtent;
      notifyListeners();
      try {
        await _onRefresh!.call();
        _state = RefreshState.done;
      } catch (_) {
        _state = RefreshState.done;
      } finally {
        await Future<void>.delayed(const Duration(milliseconds: 16));
        _animateBackToIdle();
      }
    } else {
      _animateBackToIdle();
    }
  }

  void _animateBackToIdle() {
    // 简洁版：一步归零；如需平滑可用 AnimationController 做 tween
    _pullExtent = 0.0;
    _state = RefreshState.idle;
    notifyListeners();
  }

  void reset() => _animateBackToIdle();
}
