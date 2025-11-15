import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/index.dart';

class NetworkLogo extends StatelessWidget {
  final String chainId;
  const NetworkLogo({super.key, required this.chainId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChainCubit, ChainState>(
      builder: (context, state) {
        // final chain =
        //     state.chains.firstWhere((chain) => chain.chainId == chainId);
        // return CachedImage(
        //   width: 70.w,
        //   height: 70.w,
        //   imageUrl: chain.logo  ,
        // );
        return const SizedBox.shrink();
      },
    );
  }
}
