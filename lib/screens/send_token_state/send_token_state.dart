import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/nav.dart';
import '../../core/router/constants.dart';
import '../../cubits/index.dart';
import '../../l10n/l10n.dart';
import '../../widgets/appbar.dart';
import '../../widgets/bottom_button.dart';
import '../../widgets/button.dart';
import '../../widgets/toast.dart';
import 'widgets/send_token_state_content.dart';

class SendTokenStateScreen extends StatelessWidget {
  const SendTokenStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).transfer_sendToken,
        onPressed: () => {
          context.goNamed(RouteNames.intel),
        },
      ),
      body: const SendTokenStateContent(), // 提交发送 token 之后显示状态
      bottomNavigationBar: BlocBuilder<TransferCubit, TransferState>(
        builder: (context, state) {
          return BottomButton(
            child: CustomButton(
              text: state.isSending
                  ? S.of(context).common_confirm
                  : S.of(context).common_back,
              onPressed: () {
                if (state.isSent) {
                  context.goNamed(RouteNames.wallet, extra: {
                    'index': NavIndex.wallet,
                    'toast': S.of(context).transfer_sendToken,
                  });

                  showTransferSuccessToast(
                    context,
                    state.amount,
                    state.selectedToken?.symbol ?? '',
                    state.transaction?.txUrl ?? '',
                  );

                  return;
                }

                context.goNamed(RouteNames.wallet, extra: NavIndex.wallet);
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
              isBottomButton: true,
            ),
          );
        },
      ),
    );
  }
}
