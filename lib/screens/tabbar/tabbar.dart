import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aigun/cubits/index.dart';
import 'package:flutter_aigun/l10n/l10n.dart';
import 'package:flutter_aigun/routing/routes_path.dart';
import 'package:flutter_aigun/screens/intel/intel.dart';
import 'package:flutter_aigun/screens/invite/invite.dart';
import 'package:flutter_aigun/screens/trade/trade.dart';
import 'package:flutter_aigun/screens/trending/trending.dart';
import 'package:flutter_aigun/screens/wallet/wallet.dart';
import 'package:flutter_aigun/themes/themes.dart';
import 'package:flutter_aigun/widgets/drawer/drawer_setting.dart';
import 'package:flutter_aigun/widgets/keep_alive_page.dart';
import 'package:flutter_aigun/features/update/presentation/cubit/update_cubit.dart';
import 'package:flutter_aigun/features/update/presentation/cubit/update_state.dart';
import 'package:flutter_aigun/utils/sheet/sheet.dart';
import 'package:flutter_aigun/core/cubit_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  TabbarScreenState createState() => TabbarScreenState();
}

class TabbarScreenState extends State<TabbarScreen> {
  int _selectedIndex = 0;
  bool _isFirstLoad = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 使用 IndexedStack 来保持页面状态
  late final List<Widget> _pages = <Widget>[
    const KeepAlivePage(child: IntelScreen()),
    KeepAlivePage(
        child: TrendingScreen(
            openDrawer: () => _scaffoldKey.currentState?.openDrawer())),
    const KeepAlivePage(child: TradeScreen()),
    const KeepAlivePage(child: InviteScreen()),
    // 通过回调函数的形式传入 openDrawer
    KeepAlivePage(
        child: WalletScreen(
            openDrawer: () => _scaffoldKey.currentState?.openDrawer())),
  ];

  final List<String> _iconPaths = [
    'assets/tabbar/intel.svg',
    'assets/tabbar/trending.svg',
    'assets/tabbar/trade.svg',
    'assets/tabbar/invite.svg',
    'assets/tabbar/wallet.svg',
  ];

  final List<String> _selectedIconPaths = [
    'assets/tabbar/intel-active.json',
    'assets/tabbar/trending-active.json',
    'assets/tabbar/trade-active.json',
    'assets/tabbar/invite-active.json',
    'assets/tabbar/wallet-active.json',
  ];

  @override
  void initState() {
    super.initState();
    // 延迟执行更新检查，等待首页加载完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdate();
    });
  }

  @override
  void didChangeDependencies() {
    // 如果路由有 extra，则更新选中的索引
    super.didChangeDependencies();

    // 每次依赖变化时都检查 extra 参数
    // 这样可以支持从其他页面跳转并指定 tab index
    try {
      final routerState = GoRouterState.of(context);
      if (routerState.extra is int) {
        final newIndex = routerState.extra as int;
        // 只在首次加载或者 index 不同时才更新
        if (_isFirstLoad || newIndex != _selectedIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _updateSelectedIndex(newIndex);
            }
          });
        }
      }
    } catch (e) {
      // GoRouter 上下文未准备好时忽略错误
      debugPrint('GoRouterState.of failed: $e');
    }

    _isFirstLoad = false;
  }

  void _updateSelectedIndex(int index) {
    final isLoggedIn = context.read<UserCubit>().state.isLoggedIn;

    if (index != 0) {
      if (!isLoggedIn) {
        // 使用 WidgetsBinding.instance.addPostFrameCallback 延迟执行
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.push(Routes.login);
          }
        });
      } else {
        setState(() {
          _selectedIndex = index;
          context.read<IntelCubit>().clearUnreadIds();
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
        context.read<IntelCubit>().clearUnreadIds();
      });
    }
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      BuildContext context) {
    final labels = [
      S.of(context).intel,
      S.of(context).trending,
      S.of(context).trade,
      S.of(context).invite,
      S.of(context).wallet,
    ];

    final items = List<BottomNavigationBarItem>.generate(
      _iconPaths.length,
      (index) {
        return BottomNavigationBarItem(
          icon: SvgPicture.asset(
            _iconPaths[index],
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              AppColors.textPrimary(context),
              BlendMode.srcATop,
            ),
          ),
          activeIcon: TabActiveIcon(
              path: _selectedIconPaths[index],
              isSelected: _selectedIndex == index),
          label: labels[index],
        );
      },
    );

    return items;
  }

  /// 检查更新
  void _checkForUpdate() {
    final updateCubit = getIt<UpdateCubit>();

    // 监听更新状态
    updateCubit.stream.listen((state) {
      if (!mounted) return;

      state.maybeWhen(
        available: (info, force) {
          // 有可用更新，弹出更新弹窗
          ShowSheet.upgrade(
            context,
            info: info,
            force: force,
          );
        },
        orElse: () {},
      );
    });

    // 开始检查更新
    updateCubit.checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerSetting(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.borderSecondary(context), // 使用应用主题的边框颜色
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: _buildBottomNavigationBarItems(context),
          currentIndex: _selectedIndex,
          onTap: _updateSelectedIndex,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.svgPath,
      required this.lottiePath,
      required this.unselectedColor,
      required this.isSelected});
  final String svgPath;
  final String lottiePath;
  final Color unselectedColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(microseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
      child: isSelected
          ? TabActiveIcon(path: lottiePath, isSelected: isSelected)
          : SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(unselectedColor, BlendMode.srcATop),
            ),
    );
  }
}

class TabActiveIcon extends StatefulWidget {
  const TabActiveIcon(
      {super.key, required this.path, required this.isSelected});
  final String path;
  final bool isSelected;

  @override
  State<TabActiveIcon> createState() => _TabActiveIconState();
}

class _TabActiveIconState extends State<TabActiveIcon>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(TabActiveIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSelected && !oldWidget.isSelected) {
      _controller?.forward(from: 0.0);
    } else if (!widget.isSelected && oldWidget.isSelected) {
      _controller?.reset();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: DotLottieLoader.fromAsset(widget.path,
          frameBuilder: (context, dotlottie) {
        if (dotlottie != null) {
          return Lottie.memory(dotlottie.animations.values.single,
              width: 24,
              height: 24,
              controller: _controller,
              animate: widget.isSelected, onLoaded: (composition) {
            if (_controller?.duration != composition.duration) {
              _controller?.duration = composition.duration;
            }

            if (widget.isSelected &&
                _controller?.status != AnimationStatus.completed) {
              _controller?.forward();
            }
          });
        }

        return const SizedBox.shrink();
      }),
    );
  }
}
