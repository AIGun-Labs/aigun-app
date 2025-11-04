import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_aigun/core/enums/network.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/cubits/trade/trade_state.dart';
import 'package:flutter_aigun/cubits/trade_setting/trade_setting_state.dart';
import 'package:flutter_aigun/data/models/trade/setting/trade_custom_setting.dart';
import 'package:flutter_aigun/enums/trade_mode.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/screens/trade_setting/models/network_config.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/mode_card.dart';
import 'package:flutter_aigun/screens/trade_setting/widgets/network_settings_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 优化后的设置列组件
class SettingsColumn extends StatefulWidget {
  const SettingsColumn({super.key});

  @override
  State<SettingsColumn> createState() => _SettingsColumnState();
}

class _SettingsColumnState extends State<SettingsColumn> {
  // 使用 Map 统一管理所有网络的控制器
  late final Map<Network, Map<NetworkFieldType, TextEditingController>> _networkControllers;
  late final Map<Network, Map<NetworkFieldType, FocusNode>> _networkFocusNodes;
  late final List<NetworkConfig> _networkConfigs;
  bool _isInitialized = false;
  
  // 防抖 Timer
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _networkControllers = {};
    _networkFocusNodes = {};
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // 确保只初始化一次
    if (!_isInitialized) {
      _isInitialized = true;
      
      // 获取网络配置（需要 context 用于国际化）
      _networkConfigs = NetworkConfigs.getAllConfigs(S.of(context));
      
      // 初始化所有控制器和焦点节点
      for (final config in _networkConfigs) {
        _networkControllers[config.network] = {};
        _networkFocusNodes[config.network] = {};
        for (final field in config.fields) {
          _networkControllers[config.network]![field.type] = TextEditingController();
          _networkFocusNodes[config.network]![field.type] = FocusNode();
        }
      }

      // 从状态初始化控制器的值
      final state = context.read<TradeSettingCubit>().state;
      _updateControllersFromState(state);

      // 设置监听器
      _setupListeners();
    }
  }

  /// 从状态更新所有控制器的值（只在没有焦点时更新）
  void _updateControllersFromState(TradeSettingState state) {
    for (final config in _networkConfigs) {
      final setting = state.customSettings[config.key];
      if (setting == null) continue;

      final controllers = _networkControllers[config.network]!;
      final focusNodes = _networkFocusNodes[config.network]!;
      
      // 根据字段类型更新对应的控制器
      for (final field in config.fields) {
        final controller = controllers[field.type];
        final focusNode = focusNodes[field.type];
        if (controller == null || focusNode == null) continue;

        // 只在没有焦点时更新，避免打断用户输入
        if (focusNode.hasFocus) continue;

        switch (field.type) {
          case NetworkFieldType.slippage:
            final newValue = setting.slippage.toString();
            if (controller.text != newValue) {
              controller.text = newValue;
            }
            break;
          case NetworkFieldType.priorityFee:
            final newValue = setting.priorityFee ?? '';
            if (controller.text != newValue) {
              controller.text = newValue;
            }
            break;
          case NetworkFieldType.tipFee:
            final newValue = setting.tipFee ?? '';
            if (controller.text != newValue) {
              controller.text = newValue;
            }
            break;
          case NetworkFieldType.gasPrice:
            final newValue = setting.gasPrice ?? '';
            if (controller.text != newValue) {
              controller.text = newValue;
            }
            break;
          case NetworkFieldType.mevProtect:
            // Switch 不需要 TextEditingController
            break;
        }
      }
    }
  }

  /// 设置所有TextField的监听器
  void _setupListeners() {
    for (final config in _networkConfigs) {
      final controllers = _networkControllers[config.network]!;
      final networkKey = config.key; // 获取网络的 key
      
      for (final field in config.fields) {
        final controller = controllers[field.type];
        if (controller == null) continue;

        switch (field.type) {
          case NetworkFieldType.slippage:
            controller.addListener(() {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                final slippage = int.tryParse(text);
                if (slippage != null) {
                  _updateCustomSettingForNetwork(
                    networkKey,
                    (current) => current.copyWith(slippage: slippage),
                  );
                }
              }
            });
            break;

          case NetworkFieldType.priorityFee:
            controller.addListener(() {
              _debounceUpdate(() {
                _updateCustomSettingForNetwork(
                  networkKey,
                  (current) => current.copyWith(priorityFee: controller.text),
                );
              });
            });
            break;

          case NetworkFieldType.tipFee:
            controller.addListener(() {
              _debounceUpdate(() {
                _updateCustomSettingForNetwork(
                  networkKey,
                  (current) => current.copyWith(tipFee: controller.text),
                );
              });
            });
            break;

          case NetworkFieldType.gasPrice:
            controller.addListener(() {
              _debounceUpdate(() {
                _updateCustomSettingForNetwork(
                  networkKey,
                  (current) => current.copyWith(gasPrice: controller.text),
                );
              });
            });
            break;

          case NetworkFieldType.mevProtect:
            // Switch 不需要监听器
            break;
        }
      }
    }
  }

  /// 防抖更新（避免频繁更新状态）
  void _debounceUpdate(VoidCallback callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), callback);
  }

  /// 为指定网络更新自定义设置的辅助方法
  void _updateCustomSettingForNetwork(String networkKey, Function(dynamic) update) {
    if (!mounted) return;
    
    final cubit = context.read<TradeSettingCubit>();
    final current = cubit.state.customSettings[networkKey.toLowerCase()] ??
        const TradeCustomSetting();
    
    debugPrint('🔧 _updateCustomSettingForNetwork - networkKey: $networkKey');
    debugPrint('🔧 Current setting: $current');
    
    final updated = update(current);
    
    debugPrint('🔧 Updated setting: $updated');
    
    cubit.updateCustomSettingForNetwork(networkKey, updated);
    // 切换到自定义模式
    cubit.updateTradeMode(TradeMode.custom);
  }

  @override
  void dispose() {
    // 清理防抖 Timer
    _debounceTimer?.cancel();
    
    // 清理所有控制器和焦点节点
    for (final networkControllers in _networkControllers.values) {
      for (final controller in networkControllers.values) {
        controller.dispose();
      }
    }
    for (final networkFocusNodes in _networkFocusNodes.values) {
      for (final focusNode in networkFocusNodes.values) {
        focusNode.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TradeSettingCubit, TradeSettingState>(
      listener: (context, state) {
        // 状态变化时更新控制器（只在控制器没有焦点时更新，避免打断输入）
        if (_isInitialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _updateControllersFromState(state);
            }
          });
        }
      },
      builder: (context, state) {
        return Column(
          spacing: 10.h,
          children: [
            _buildModeCard(
              context,
              mode: TradeMode.fast,
              icon: "assets/lottie/cowboy-gun.lottie",
              isSelected: state.mode == TradeMode.fast,
            ),
            _buildModeCard(
              context,
              mode: TradeMode.normal,
              icon: "assets/lottie/cowboy-cycling.lottie",
              isSelected: state.mode == TradeMode.normal,
            ),
            _buildCustomSettings(context),
          ],
        );
      },
    );
  }

  /// 构建模式卡片
  Widget _buildModeCard(
    BuildContext context, {
    required TradeMode mode,
    required String icon,
    required bool isSelected,
  }) {
    final s = S.of(context);
    final modeInfo = _getModeInfo(s, mode);

    return TradeModeCard(
      isSelected: isSelected,
      onTap: () {
        context.read<TradeSettingCubit>().updateTradeMode(mode);
      },
      modeIcon: icon,
      modeTitle: modeInfo['title']!,
      modeDescription: modeInfo['description']!,
    );
  }

  /// 获取模式信息
  Map<String, String> _getModeInfo(dynamic s, TradeMode mode) {
    switch (mode) {
      case TradeMode.fast:
        return {'title': s.fastMode, 'description': s.fastModeDesc};
      case TradeMode.normal:
        return {'title': s.normalMode, 'description': s.normalModeDesc};
      case TradeMode.custom:
        return {'title': '', 'description': ''};
    }
  }

  /// 构建自定义设置（根据当前选择的网络）
  Widget _buildCustomSettings(BuildContext context) {
    // 如果还没初始化完成，返回空 widget
    if (!_isInitialized) {
      return const SizedBox.shrink();
    }
    
    return BlocSelector<TradeCubit, TradeState, String>(
      selector: (state) => state.fromToken?.network.toString() ?? '',
      builder: (context, networkString) {
        // 找到匹配的网络配置
        final config = _networkConfigs.firstWhere(
          (config) => networkString.toLowerCase() == config.network.value,
          orElse: () => _networkConfigs.first,
        );

        final controllers = _networkControllers[config.network];
        final focusNodes = _networkFocusNodes[config.network];
        if (controllers == null || focusNodes == null) return const SizedBox.shrink();

        return NetworkSettingsBuilder(
          config: config,
          controllers: controllers,
          focusNodes: focusNodes,
        );
      },
    );
  }
}

