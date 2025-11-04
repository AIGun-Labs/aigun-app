import 'package:flutter/services.dart';
import 'package:flutter_aigun/core/enums/network.dart';
import 'package:flutter_aigun/utils/format/input_formatters.dart';

/// 网络交易配置模型
class NetworkConfig {
  final Network network;
  final String displayName;
  final List<NetworkField> fields;

  const NetworkConfig({
    required this.network,
    required this.displayName,
    required this.fields,
  });

  /// 获取网络配置的键（用于访问state中的customSettings）
  String get key => network.value;
}

/// 网络配置字段类型
enum NetworkFieldType {
  slippage,
  mevProtect,
  priorityFee,
  tipFee,
  gasPrice,
}

/// 网络配置字段模型
class NetworkField {
  final NetworkFieldType type;
  final String Function(dynamic context) titleBuilder; // 使用函数而不是直接字符串，支持国际化
  final String? suffix;
  final List<TextInputFormatter> formatters;
  final bool showLiveData;

  const NetworkField({
    required this.type,
    required this.titleBuilder,
    this.suffix,
    required this.formatters,
    this.showLiveData = false,
  });
}

/// 预定义的网络配置
class NetworkConfigs {
  NetworkConfigs._();
  
  static final decimalFormatter = FilteringTextInputFormatter.allow(RegExp("[0-9.]"));
  static final integerFormatter = InputFormatters.numberInputFormatters();

  static List<NetworkConfig> getAllConfigs(dynamic context) {
    // 从 context 获取 S (国际化)
    final s = _getS(context);
    
    return [
      NetworkConfig(
        network: Network.solana,
        displayName: 'Solana',
        fields: [
          NetworkField(
            type: NetworkFieldType.slippage,
            titleBuilder: (_) => s.slippage,
            suffix: '%',
            formatters: integerFormatter,
          ),
          NetworkField(
            type: NetworkFieldType.mevProtect,
            titleBuilder: (_) => s.mevProtect,
            formatters: [],
          ),
          NetworkField(
            type: NetworkFieldType.priorityFee,
            titleBuilder: (_) => s.priorityFee,
            suffix: 'SOL',
            formatters: [decimalFormatter],
            showLiveData: true,
          ),
          NetworkField(
            type: NetworkFieldType.tipFee,
            titleBuilder: (_) => s.bribeFee,
            suffix: 'SOL',
            formatters: [decimalFormatter],
            showLiveData: true,
          ),
        ],
      ),
      NetworkConfig(
        network: Network.eth,
        displayName: 'Ethereum',
        fields: [
          NetworkField(
            type: NetworkFieldType.slippage,
            titleBuilder: (_) => s.slippage,
            suffix: '%',
            formatters: integerFormatter,
          ),
          NetworkField(
            type: NetworkFieldType.mevProtect,
            titleBuilder: (_) => s.mevProtect,
            formatters: [],
          ),
          NetworkField(
            type: NetworkFieldType.gasPrice,
            titleBuilder: (_) => 'Gas',
            suffix: ' ',
            formatters: [decimalFormatter],
            showLiveData: true,
          ),
        ],
      ),
      NetworkConfig(
        network: Network.bsc,
        displayName: 'BNB Chain',
        fields: [
          NetworkField(
            type: NetworkFieldType.slippage,
            titleBuilder: (_) => s.slippage,
            suffix: '%',
            formatters: integerFormatter,
          ),
          NetworkField(
            type: NetworkFieldType.mevProtect,
            titleBuilder: (_) => s.mevProtect,
            formatters: [],
          ),
          NetworkField(
            type: NetworkFieldType.gasPrice,
            titleBuilder: (_) => 'Gas',
            suffix: ' ',
            formatters: [decimalFormatter],
            showLiveData: true,
          ),
        ],
      ),
      NetworkConfig(
        network: Network.base,
        displayName: 'Base',
        fields: [
          NetworkField(
            type: NetworkFieldType.slippage,
            titleBuilder: (_) => s.slippage,
            suffix: '%',
            formatters: integerFormatter,
          ),
          NetworkField(
            type: NetworkFieldType.gasPrice,
            titleBuilder: (_) => 'Gas',
            suffix: ' ',
            formatters: [decimalFormatter],
            showLiveData: true,
          ),
        ],
      ),
    ];
  }

  /// 辅助方法：从 context 获取国际化对象
  static dynamic _getS(dynamic context) {
    // 这里需要导入 l10n，但为了避免循环依赖，我们在使用时传入
    // 在实际使用中，调用方会传入 S.of(context)
    return context;
  }
}


