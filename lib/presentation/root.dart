import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike_store_flutter/presentation/home/home.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

const homeScreenIndex = 0;
const cartScreenIndex = 1;
const profileScreenIndex = 2;

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeScreenIndex;

  final List<int> _history = [];

  final _homeKey = GlobalKey<NavigatorState>();
  final _cartKey = GlobalKey<NavigatorState>();
  final _profileKey = GlobalKey<NavigatorState>();

  bool _showBottomNav = true;

  Future<void> _handleRootBack() async {
    final currentNavigatorKey = _navigatorKeyForIndex(selectedScreenIndex);

    if (currentNavigatorKey.currentState?.canPop() ?? false) {
      currentNavigatorKey.currentState?.pop();
      return;
    }

    debugPrint(
      '_handleRootBack called, history=$_history, selected=$selectedScreenIndex',
    );
    if (_history.isEmpty) {
      if (selectedScreenIndex == homeScreenIndex) {
        final shouldExit = await _showExitConfirmDialog();
        if (shouldExit == true) {
          SystemNavigator.pop();
        }
      }
      return;
    }

    setState(() {
      selectedScreenIndex = _history.removeLast();
    });
  }

  GlobalKey<NavigatorState> _navigatorKeyForIndex(int index) {
    switch (index) {
      case homeScreenIndex:
        return _homeKey;
      case cartScreenIndex:
        return _cartKey;
      case profileScreenIndex:
        return _profileKey;
      default:
        return _homeKey;
    }
  }

  void _selectTab(int index) {
    if (index == selectedScreenIndex) return;

    setState(() {
      _history.remove(selectedScreenIndex);
      _history.add(selectedScreenIndex);
      selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        debugPrint('onPopInvokedWithResult: didPop=$didPop');
        if (didPop) return;
        _handleRootBack();
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _buildTabNavigator(
              index: homeScreenIndex,
              navigatorKey: _homeKey,
              child: const HomeScreen(),
            ),
            _buildTabNavigator(
              index: cartScreenIndex,
              navigatorKey: _cartKey,
              child: const Center(child: Text('cart')),
            ),
            _buildTabNavigator(
              index: profileScreenIndex,
              navigatorKey: _profileKey,
              child: const Center(child: Text('profile')),
            ),
          ],
        ),
        bottomNavigationBar: _showBottomNav
            ? BottomNavigationBar(
                currentIndex: selectedScreenIndex,
                onTap: _selectTab,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: 'خانه',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart),
                    label: 'سبد خرید',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: 'پروفایل',
                  ),
                ],
              )
            : null,
      ),
    );
  }

  void _updateBottomNavVisibility() {
    final navigatorKey = _navigatorKeyForIndex(selectedScreenIndex);
    final canPop = navigatorKey.currentState?.canPop() ?? false;
    if (_showBottomNav == canPop) {
      setState(() {
        _showBottomNav = !canPop;
      });
    }
  }

  Widget _buildTabNavigator({
    required int index,
    required GlobalKey<NavigatorState> navigatorKey,
    required Widget child,
  }) {
    return Navigator(
      observers: [_TabNavigatorObserver(onChanged: _updateBottomNavVisibility)],
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => child,
        );
      },
    );
  }

  Future<bool?> _showExitConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خروج از برنامه'),
        content: const Text('آیا می‌خواهید از برنامه خارج شوید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('انصراف'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('خروج'),
          ),
        ],
      ),
    );
  }
}

class _TabNavigatorObserver extends NavigatorObserver {
  final VoidCallback onChanged;

  _TabNavigatorObserver({required this.onChanged});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onChanged());
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onChanged());
  }
}
