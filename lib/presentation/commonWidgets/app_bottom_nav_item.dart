import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// A single icon+label item used inside [AppBottomNavBar].
/// Extracted as its own widget so it can be reused / tested independently.
class AppBottomNavItem extends StatelessWidget {
  const AppBottomNavItem({
    super.key,
    required this.label,
    required this.isActive,
    this.icon,
    this.activeIcon,
    this.assetIcon,
    this.onTap,
  });

  final IconData? icon;
  final IconData? activeIcon;
  final String? assetIcon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isActive
        ? AppColors.navIconActive
        : AppColors.navIconInactive;
    final TextStyle labelStyle = isActive
        ? AppTextStyles.labelActive.copyWith(fontSize: 11.sp)
        : AppTextStyles.labelInactive.copyWith(fontSize: 11.sp);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetIcon != null)
              Image.asset(
                assetIcon!,
                width: 22.w,
                height: 22.h,
                color: iconColor,
              )
            else
              Icon(
                isActive ? (activeIcon ?? icon) : icon,
                color: iconColor,
                size: 22.sp,
              ),
            SizedBox(height: 4.h),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}
