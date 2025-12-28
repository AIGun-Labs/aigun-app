import 'package:flutter/services.dart';

import '../../../core/enums/network.dart';
import '../../../utils/format/input_formatters.dart';

class NetworkConfig {
  final Network network;
  final String displayName;
  final List<NetworkField> fields;

  const NetworkConfig({
    required this.network,
    required this.displayName,
    required this.fields,
  });
  String get key => network.value;
}

enum NetworkFieldType { slippage, mevProtect, priorityFee, tipFee, gasPrice }

class NetworkField {
  final NetworkFieldType type;
  final String Function(dynamic context) titleBuilder; // ，
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

class NetworkConfigs {
  NetworkConfigs._();

  static final decimalFormatter = FilteringTextInputFormatter.allow(
    RegExp("[0-9.]"),
  );
  static final integerFormatter = InputFormatters.numberInputFormatters();

  static List<NetworkConfig> getAllConfigs(dynamic context) {
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
    ];
  }

  static dynamic _getS(dynamic context) {
    return context;
  }
}
