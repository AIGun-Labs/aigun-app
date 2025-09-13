import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_aigun/config/nav.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/send_token_state/widgets/send_token_state_content.dart';
import 'package:flutter_aigun/widgets/appbar.dart';
import 'package:flutter_aigun/widgets/bottom_button.dart';
import 'package:flutter_aigun/widgets/button.dart';
import 'package:flutter_aigun/widgets/toast.dart';
import 'package:go_router/go_router.dart';

class SendTokenStateScreen extends StatelessWidget {
  const SendTokenStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).transfer_sendToken,
        onPressed: () => {
          context.go(Routes.home),
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
                  context.go(Routes.home, extra: {
                    "index": NavIndex.wallet,
                    "toast": S.of(context).transfer_sendToken,
                  });

                  showTransferSuccessToast(
                    context,
                    state.amount,
                    state.selectedToken?.symbol ?? "",
                    state.transaction?.txHash ?? "",
                  );

                  return;
                }

                context.go(Routes.home, extra: NavIndex.wallet);
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
