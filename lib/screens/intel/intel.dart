import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/screens/intel/widgets/header.dart';
import 'package:flutter_aigun/screens/intel/widgets/intel_list.dart';
import 'package:flutter_aigun/screens/intel/widgets/top_header.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:provider/provider.dart';

class IntelScreen extends StatefulWidget {
  const IntelScreen({super.key});

  @override
  State<IntelScreen> createState() => _IntelScreenState();
}

class _IntelScreenState extends State<IntelScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = const [
    'AI',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // IntelHeader(),
            const LatestDiscoveriesSection(),
            Divider(
              color: AppColors.card(context),
              thickness: 10,
              height: 10,
              // indent: 16, //
              // endIndent: 16,
            ),
            const Expanded(child: IntelList())
          ],
        ),
      ),
    );
  }
}
