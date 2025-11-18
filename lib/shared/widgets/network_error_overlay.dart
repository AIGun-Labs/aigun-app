import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/network/network_cubit.dart';
import '../../cubits/network/network_state.dart';
import '../../l10n/l10n.dart';
import '../../utils/toast.dart';

class NetworkErrorOverlay extends StatelessWidget {
  const NetworkErrorOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<NetworkCubit, NetworkState>(
      listenWhen: (previous, current) =>
          previous.isConnected != current.isConnected ||
          previous.isServicesHealthy != current.isServicesHealthy,
      listener: (context, state) {
        if (false) {
          if (state.isConnected == false) {
            NetworkToastUtils.dismiss();
            NetworkToastUtils.showNetworkFailed(
                context, S.of(context).networkIsNotConnected);
          } else if (state.isServicesHealthy == false &&
              state.isConnected == true) {
            NetworkToastUtils.dismiss();
            NetworkToastUtils.showNetworkFailed(
                context, S.of(context).servicesAreNotHealthy);
          } else if (state.isConnected == true &&
              state.isServicesHealthy == true) {
            NetworkToastUtils.dismiss();
          }
        }
      },
      child: child,
    ));
  }
}
