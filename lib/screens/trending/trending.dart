import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:provider/provider.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Trending"),
      ),
    );
  }
}
