import 'package:flutter/material.dart';

class TrendingTabBar extends StatelessWidget {
  const TrendingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Trending'),
              Text('AI Agents'),
            ],
          ),
          Column(
            children: [
              Text('Trending'),
              Text('AI Agents'),
            ],
          ),
          Column(
            children: [
              Text('Trending'),
              Text('AI Agents'),
            ],
          )
        ],
      ),
    );
  }
}
