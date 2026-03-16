import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'app_premium_button.dart';
import '../free/dashboard/professional/professional_screen.dart';

class ProfessionalInsightsCard extends StatefulWidget {
  const ProfessionalInsightsCard({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  State<ProfessionalInsightsCard> createState() =>
      _ProfessionalInsightsCardState();
}

class _ProfessionalInsightsCardState extends State<ProfessionalInsightsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (context, child) {
        return Container(
          margin: widget.margin ?? EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color:
                  const Color(0xFFFFD700).withOpacity(0.35 + 0.25 * _glowAnim.value),
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
            boxShadow: [
              // Wide outer glow
              BoxShadow(
                color: const Color(0xFFFFD700)
                    .withOpacity(0.10 * _glowAnim.value),
                blurRadius: 32,
                spreadRadius: 4,
              ),
              // Tight inner glow
              BoxShadow(
                color: const Color(0xFFFFD700)
                    .withOpacity(0.20 * _glowAnim.value),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: child,
        );
      },
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
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD700).withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
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
