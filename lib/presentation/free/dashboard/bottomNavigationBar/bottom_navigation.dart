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
// import '../free/dashboard/scan/scan_screen.dart';
// import '../free/dashboard/wallet/wallet_screen.dart';
// import '../free/dashboard/profile/profile_screen.dart';

/// Entry-point widget that wraps every dashboard screen with the custom
/// bottom navigation bar.
///
/// To add a new screen:
/// 1. Create your screen Widget.
/// 2. Import it above.
/// 3. Add a [_NavItem] entry to [_items].
/// 4. Add your Widget instance to [_screens].
/// That's it – navigation works automatically.
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

  // ── Nav items configuration ───────────────────────────────────────────────
  static const List<_NavItem> _items = [
    _NavItem(label: 'Home', assetIcon: 'assets/images/home.png'),
    _NavItem(label: 'Markets', assetIcon: 'assets/images/markets.png'),
    _NavItem(label: 'Scan', assetIcon: 'assets/images/scan.png'),
    _NavItem(label: 'Wallet', assetIcon: 'assets/images/wallet.png'),
    _NavItem(label: 'Profile', assetIcon: 'assets/images/profile.png'),
  ];

  // ── Screens list – each index corresponds to a nav item ───────────────────
  // Replace the placeholder Containers with real screen widgets as you build them.
  late final List<Widget> _screens = [
    const HomeScreen(),
    const MarketsScreen(),
    _placeholder('Scan'),
    _placeholder('Wallet'),
    _placeholder('Profile'),
  ];

  static Widget _placeholder(String name) => Center(
    child: Text(
      name,
      style: TextStyle(color: AppColors.textSecondary, fontSize: 20.sp),
    ),
  );

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: IndexedStack(index: _currentIndex, children: _screens),
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

  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navBarBackground,
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
