import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/network.dart';
import '../../../cubits/index.dart';
import '../../../cubits/trade_setting/trade_setting_state.dart';
import '../../../data/models/trade/setting/trade_custom_setting.dart';
import '../../../enums/trade_mode.dart';
import '../../../l10n/l10n.dart';
import '../models/network_config.dart';
import 'mode_card.dart';
import 'network_settings_builder.dart';

class SettingsColumn extends StatefulWidget {
  const SettingsColumn({super.key});

  @override
  State<SettingsColumn> createState() => _SettingsColumnState();
}

class _SettingsColumnState extends State<SettingsColumn> {
  late final Map<Network, Map<NetworkFieldType, TextEditingController>>
  _networkControllers;
  late final Map<Network, Map<NetworkFieldType, FocusNode>> _networkFocusNodes;
  late final List<NetworkConfig> _networkConfigs;
  bool _isInitialized = false;
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
    if (!_isInitialized) {
      _isInitialized = true;
      _networkConfigs = NetworkConfigs.getAllConfigs(S.of(context));
      for (final config in _networkConfigs) {
        _networkControllers[config.network] = {};
        _networkFocusNodes[config.network] = {};
        for (final field in config.fields) {
          _networkControllers[config.network]![field.type] =
              TextEditingController();
          _networkFocusNodes[config.network]![field.type] = FocusNode();
        }
      }
      final state = context.read<TradeSettingCubit>().state;
      _updateControllersFromState(state);
      _setupListeners();
    }
  }

  void _updateControllersFromState(TradeSettingState state) {
    for (final config in _networkConfigs) {
      final setting = state.customSettings[config.key];
      if (setting == null) continue;

      final controllers = _networkControllers[config.network]!;
      final focusNodes = _networkFocusNodes[config.network]!;
      for (final field in config.fields) {
        final controller = controllers[field.type];
        final focusNode = focusNodes[field.type];
        if (controller == null || focusNode == null) continue;
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
            break;
        }
      }
    }
  }

  void _setupListeners() {
    for (final config in _networkConfigs) {
      final controllers = _networkControllers[config.network]!;
      final networkKey = config.key; //  key

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
            break;
        }
      }
    }
  }

  void _debounceUpdate(VoidCallback callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), callback);
  }

  void _updateCustomSettingForNetwork(
    String networkKey,
    Function(dynamic) update,
  ) {
    if (!mounted) return;

    final cubit = context.read<TradeSettingCubit>();
    final current =
        cubit.state.customSettings[networkKey.toLowerCase()] ??
        const TradeCustomSetting();

    debugPrint('🔧 _updateCustomSettingForNetwork - networkKey: $networkKey');
    debugPrint('🔧 Current setting: $current');

    final updated = update(current);

    debugPrint('🔧 Updated setting: $updated');

    cubit.updateCustomSettingForNetwork(networkKey, updated);
    cubit.updateTradeMode(TradeMode.custom);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
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

  Widget _buildCustomSettings(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox.shrink();
    }

    return BlocSelector<TradeSettingCubit, TradeSettingState, String>(
      selector: (state) => state.network.toString(),
      builder: (context, networkString) {
        final config = _networkConfigs.firstWhere(
          (config) => networkString.toLowerCase() == config.network.value,
          orElse: () => _networkConfigs.first,
        );

        final controllers = _networkControllers[config.network];
        final focusNodes = _networkFocusNodes[config.network];
        if (controllers == null || focusNodes == null) {
          return const SizedBox.shrink();
        }

        return NetworkSettingsBuilder(
          config: config,
          controllers: controllers,
          focusNodes: focusNodes,
        );
      },
    );
  }
}
