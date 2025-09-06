import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/bottom_sheet/trade.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('showBottomSheet'),
              onPressed: () {
                showBottomSheetTrade(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
