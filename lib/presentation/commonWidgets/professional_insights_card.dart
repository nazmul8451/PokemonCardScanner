import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'app_premium_button.dart';
import '../free/dashboard/professional/professional_screen.dart';

class ProfessionalInsightsCard extends StatelessWidget {
  const ProfessionalInsightsCard({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.4),
          width: 1.2.w,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1E1E1E),
            const Color(0xFFFFD700).withOpacity(0.04),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/diamond_icon.png',
                  width: 26.w,
                  height: 26.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Professional Insights',
                style: AppTextStyles.titleMedium.copyWith(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Unlock real-time market movers, depth charts, and AI-powered buying signals.',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          AppPremiumButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfessionalScreen(),
                ),
              );
            },
            label: 'Go Professional',
          ),
        ],
      ),
    );
  }
}
