import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/string.dart';
import '../../../../widgets/token/models/token.dart';
import '../cubit/swap/swap_cubit.dart';
import '../cubit/swap/swap_state.dart';
import 'swap_converters.dart';
import 'swap_divider.dart';
import 'token_card/index.dart';

///
class SwapTokenPair extends StatelessWidget {
  const SwapTokenPair({
    super.key,
    required this.onSelectSourceToken,
    required this.onSelectTargetToken,
  });
  final void Function(List<Token> availableTokens) onSelectSourceToken;
  final void Function(List<Token> availableTokens) onSelectTargetToken;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      buildWhen: _shouldRebuild,
      builder: (context, state) {
        final availableTokens = _buildAvailableTokens(state);
        final fromTokenConfig = _buildFromTokenConfig(state);
        final toTokenConfig = _buildToTokenConfig(state);

        return Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TokenCard(
                  config: fromTokenConfig,
                  interaction: TokenCardInteraction(
                    isEditable: true,
                    isSourceToken: true,
                    onSelectToken: () => onSelectSourceToken(availableTokens),
                    onAmountChanged: (amount) =>
                        context.read<SwapCubit>().updateAmount(amount),
                  ),
                ),
                const SwapTokenDivider(),
                TokenCard(
                  config: toTokenConfig,
                  interaction: TokenCardInteraction(
                    isEditable: false,
                    isSourceToken: false,
                    onSelectToken: () => onSelectTargetToken(availableTokens),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool _shouldRebuild(SwapState previous, SwapState current) {
    return previous.quote != current.quote ||
        previous.fromToken != current.fromToken ||
        previous.toToken != current.toToken ||
        previous.availableTokens != current.availableTokens ||
        previous.nativeTokens != current.nativeTokens ||
        previous.amount != current.amount;
  }

  List<Token> _buildAvailableTokens(SwapState state) {
    return state.availableTokens.map((e) => e.toToken()).toList();
  }

  TokenCardConfig _buildFromTokenConfig(SwapState state) {
    final inAmount =
        ((double.tryParse(state.amount) ?? 0) *
                (state.fromToken?.tokenPrice ?? 0))
            .toString();

    return state.fromToken.toTokenCardConfig(
      amount: state.amount,
      dollarValue: state.quote?.inUsdValue?.toString() ?? inAmount,
    );
  }

  TokenCardConfig _buildToTokenConfig(SwapState state) {
    final outAmount = state.quote?.outAmount.toString().divideByDecimalPower(
      state.toToken?.decimals ?? 18,
    );

    return state.toToken.toTokenCardConfig(
      amount: outAmount,
      dollarValue: state.quote?.outUsdValue?.toString() ?? '',
    );
  }
}
