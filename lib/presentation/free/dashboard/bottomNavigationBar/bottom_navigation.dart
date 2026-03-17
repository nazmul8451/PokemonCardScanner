import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../commonWidgets/app_bottom_nav_item.dart';
import '../home/home_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ADD YOUR OTHER SCREENS HERE – just import them and place them in _screens list
// ─────────────────────────────────────────────────────────────────────────────
import '../markets/markets_screen.dart';
import '../scan/scan_screen.dart';
import '../wallet/wallet_screen.dart';
import '../profile/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../../../controller/subscription_controller.dart';
import '../../../pro/home/pro_home_screen.dart';
import '../../../pro/market/pro_market_screen.dart';
import '../../../pro/scan/pro_scanner_screen.dart';
import '../../../pro/wallet/pro_wallet_screen.dart';
import '../../../pro/profile/pro_profile_screen.dart';

/// Entry-point widget that wraps every dashboard screen with the custom
/// bottom navigation bar.
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

// ── Model ─────────────────────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({required this.label, this.assetIcon});

  final String label;
  final String? assetIcon;
}

// ── State ─────────────────────────────────────────────────────────────────────

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  late SubscriptionController _subscriptionController;
  
  @override
  void initState() {
    super.initState();
    _subscriptionController = context.read<SubscriptionController>();
    _subscriptionController.addListener(_onSubscriptionChanged);
  }

  @override
  void dispose() {
    _subscriptionController.removeListener(_onSubscriptionChanged);
    super.dispose();
  }

  void _onSubscriptionChanged() {
    // If upgraded to Pro, reset to home tab
    if (_subscriptionController.isPro && _currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  // ── Nav items configuration ───────────────────────────────────────────────
  static const List<_NavItem> _items = [
    _NavItem(label: 'Home', assetIcon: 'assets/images/home.png'),
    _NavItem(label: 'Markets', assetIcon: 'assets/images/markets.png'),
    _NavItem(label: 'Scan', assetIcon: 'assets/images/scan.png'),
    _NavItem(label: 'Wallet', assetIcon: 'assets/images/wallet.png'),
    _NavItem(label: 'Profile', assetIcon: 'assets/images/profile.png'),
  ];

  // ── Screens list – each index corresponds to a nav item ───────────────────
  List<Widget> _getScreens(bool isPro) {
    if (isPro) {
      return [
        ProHomeScreen(
          onProfileTap: () {
            _onItemTapped(4); // Navigation to Profile Tab
          },
        ),
        const ProMarketAnalysisScreen(),
        ProScannerScreen(
          onAddToWallet: () {
            _onItemTapped(3); // Navigation to Wallet Tab
          },
          onProfileTap: () {
            _onItemTapped(4); // Navigation to Profile Tab
          },
        ),
        const ProWalletScreen(),
        const ProProfileScreen(),
      ];
    }
    return [
      const HomeScreen(),
      const MarketsScreen(),
      const ScanScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isPro = context.watch<SubscriptionController>().isPro;
    final screens = _getScreens(isPro);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(index: _currentIndex, children: screens),
        bottomNavigationBar: _AppBottomNavBar(
          currentIndex: _currentIndex,
          items: _items,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

// ── Bottom Nav Bar Widget ──────────────────────────────────────────────────────

class _AppBottomNavBar extends StatelessWidget {
  const _AppBottomNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap, 
  }); 
  
  
  final ValueChanged<int> onTap;
  final int currentIndex;
  final List<_NavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E11),
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 0.8.w),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (i) => AppBottomNavItem(
                assetIcon: items[i].assetIcon,
                label: items[i].label,
                isActive: i == currentIndex,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
