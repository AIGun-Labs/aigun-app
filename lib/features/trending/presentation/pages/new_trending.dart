import 'package:flutter/material.dart';

class NewTrendingScreen extends StatefulWidget {
  const NewTrendingScreen({super.key});

  @override
  State<NewTrendingScreen> createState() => _NewTrendingScreenState();
}

class _NewTrendingScreenState extends State<NewTrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Trending'),
      ),
      body: Container(),
    );
  }
}
