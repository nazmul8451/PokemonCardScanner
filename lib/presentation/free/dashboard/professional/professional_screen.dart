import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controller/subscription_controller.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../commonWidgets/common_widgets.dart';

class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  bool isAnnual = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: Container(
        decoration: BoxDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      _buildHeaderIcon(),
                      SizedBox(height: 24.h),
                      _buildHeaderTitle(),
                      SizedBox(height: 32.h),
                      _buildBillingToggle(),
                      SizedBox(height: 32.h),
                      _buildFeaturesList(),
                      SizedBox(height: 40.h),
                      AppPremiumButton(
                        onTap: () {
                          context.read<SubscriptionController>().toggleSubscription();
                        },
                        label: 'Upgrade to Professional',
                        height: 60.h,
                      ),
                      SizedBox(height: 20.h),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Maybe Later',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close_rounded, color: Colors.white, size: 28.sp),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Professional',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.5),
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Transform.rotate(
        angle: 45 * 3.14159 / 180,
        child: Container(
          margin: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
          ),
          child: Transform.rotate(
            angle: -45 * 3.14159 / 180,
            child: Center(
              child: Image.asset(
                'assets/images/diamond_icon.png',
                width: 44.w,
                height: 44.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Column(
      children: [
        Text(
          'Level up your collection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w900,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'Unlock the full power of market analytics',
          style: TextStyle(
            color: const Color(0xFFFFD700),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isAnnual = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !isAnnual
                      ? const Color(0xFF2A2A2A)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    'Monthly',
                    style: TextStyle(
                      color: !isAnnual ? Colors.white : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isAnnual = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isAnnual
                      ? const Color(0xFF2A2A2A)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Annual',
                      style: TextStyle(
                        color: isAnnual
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'SAVE 20%',
                        style: TextStyle(
                          color: const Color(0xFFFFD700),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      _FeatureItem(
        icon: Icons.auto_graph_rounded,
        title: 'Predict all data',
        subtitle:
            'Unlimited access to historical price trends and future forecasts.',
      ),
      _FeatureItem(
        icon: Icons.camera_rounded,
        title: 'Accurate Scan Predictions',
        subtitle:
            'Unlock predictions scan, accurate card recognition for entire folders.',
      ),
      _FeatureItem(
        icon: Icons.palette_rounded,
        title: 'Custom App Icons',
        subtitle: '', // Special handling below
        extra: Row(
          children: [
            _colorBox(const Color(0xFFFFD700)),
            _colorBox(const Color(0xFF1E3A5F)),
            _colorBox(const Color(0xFF6C63FF)),
          ],
        ),
      ),
      _FeatureItem(
        icon: Icons.military_tech_rounded,
        title: 'Unlock Exclusive Badges',
        subtitle:
            'Show off your collector status with professional profile medals.',
      ),
      _FeatureItem(
        icon: Icons.verified_rounded,
        title: 'Blue Checkmarks',
        subtitle:
            'Verified status on the global TCG marketplace and community.',
      ),
      _FeatureItem(
        icon: Icons.notifications_active_rounded,
        title: 'TCG Smart Alerts',
        subtitle: 'If some card is moving for hype or manipulation.',
      ),
    ];

    return Column(children: features.map((f) => _buildFeatureRow(f)).toList());
  }

  Widget _buildFeatureRow(_FeatureItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.white.withOpacity(0.04), width: 1.2.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.1),
              ),
            ),
            child: Icon(item.icon, color: const Color(0xFFFFD700), size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (item.subtitle.isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                      height: 1.4,
                    ),
                  ),
                ],
                if (item.extra != null) ...[
                  SizedBox(height: 12.h),
                  item.extra!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorBox(Color color) {
    return Container(
      width: 24.w,
      height: 24.h,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? extra;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.extra,
  });
}
