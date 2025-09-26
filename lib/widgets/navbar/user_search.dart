import 'package:flutter/material.dart';
import 'package:flutter_aigun/widgets/user_search.dart';

class NavbarUserSearch extends StatefulWidget implements PreferredSizeWidget {
  const NavbarUserSearch({super.key, required this.openDrawer});
  final VoidCallback? openDrawer;

  @override
  State<NavbarUserSearch> createState() => _NavUserSearchState();

  // 实现PreferredSizeWidget接口，定义AppBar的高度
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavUserSearchState extends State<NavbarUserSearch> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false, // 只处理顶部安全区域
      child: UserSearch(searchController: searchController),
    );
  }
}
