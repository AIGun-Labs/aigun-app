import 'package:flutter/material.dart';
import 'package:flutter_aigun/utils/resource.dart';
import 'package:flutter_aigun/widgets/smart_network_image.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ClipOval(
        child: SmartNetworkImage(
          height: 48,
          width: 48,
          url: getImageUrl("https://cdn.idogex.ai/assets/chain/ink.png") ?? "",
        ),
      )),
    );
  }
}
