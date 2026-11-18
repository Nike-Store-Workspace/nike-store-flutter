import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike_store_flutter/presentation/cart/cart.dart';
import 'package:nike_store_flutter/presentation/home/home.dart';
import 'package:nike_store_flutter/presentation/settings/app_preferences.dart';

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
              child: const CartScreen(),
            ),
            _buildTabNavigator(
              index: profileScreenIndex,
              navigatorKey: _profileKey,
              child: const _SettingsScreen(),
            ),
          ],
        ),
        bottomNavigationBar: _showBottomNav
            ? BottomNavigationBar(
                currentIndex: selectedScreenIndex,
                onTap: _selectTab,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: AppPreferences.locale.value.languageCode == 'en'
                        ? 'Home'
                        : 'خانه',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.cart),
                    label: AppPreferences.locale.value.languageCode == 'en'
                        ? 'Cart'
                        : 'سبد خرید',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: AppPreferences.locale.value.languageCode == 'en'
                        ? 'Settings'
                        : 'تنظیمات',
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

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen();
  @override
  Widget build(BuildContext context) {
    final en = AppPreferences.locale.value.languageCode == 'en';
    return Scaffold(
      appBar: AppBar(title: Text(en ? 'Settings' : 'تنظیمات')),
      body: ListView(
        children: [
          ListTile(
            title: Text(en ? 'Language' : 'زبان'),
            trailing: DropdownButton<String>(
              value: AppPreferences.locale.value.languageCode,
              items: [
                DropdownMenuItem(
                  value: 'fa',
                  child: Text(en ? 'Persian' : 'فارسی'),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text(en ? 'English' : 'انگلیسی'),
                ),
              ],
              onChanged: (v) {
                if (v != null) AppPreferences.setLocale(Locale(v));
              },
            ),
          ),
          ListTile(
            title: Text(en ? 'Theme' : 'پوسته'),
            trailing: DropdownButton<ThemeMode>(
              value: AppPreferences.themeMode.value,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(en ? 'System' : 'سیستم'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(en ? 'Light' : 'روشن'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(en ? 'Dark' : 'تیره'),
                ),
              ],
              onChanged: (v) {
                if (v != null) AppPreferences.setTheme(v);
              },
            ),
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
