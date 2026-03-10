import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../controller/free/scan_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../commonWidgets/common_widgets.dart';
import '../professional/professional_screen.dart';
import 'camera_scan_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    _buildLimitCard(context),
                    SizedBox(height: 24.h),
                    _buildScannerArea(context),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1.w),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: const Color(0xFF2A2D3E),
            child: Text(
              'F',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scanner',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Free Account',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white.withOpacity(0.8),
              size: 24.sp,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white.withOpacity(0.8),
                  size: 24.sp,
                ),
              ),
              Positioned(
                right: 12.w,
                top: 12.h,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLimitCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A170F), // Dark gold hint
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.15),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Free Tier Limit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Scans used this month',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
          AppPremiumButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfessionalScreen(),
                ),
              );
            },
            label: 'Get Unlimited Scans - Upgrade Pro',
            height: 46.h,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildScannerArea(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 280.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFFFFD700).withOpacity(0.2),
                width: 1.w,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 64.sp,
                  color: const Color(0xFFFFD700).withOpacity(0.8),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Scan Your Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    'Position card in frame for best results',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Consumer<ScanController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  AppPremiumButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraScanScreen(),
                        ),
                      );
                      if (!controller.isScanning) {
                        controller.startScanning();
                      }
                    },
                    label: controller.isScanning
                        ? 'Scanning...'
                        : 'Start Scanning',
                    icon: controller.isScanning
                        ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.file_upload_outlined,
                            color: Colors.black,
                            size: 22.sp,
                          ),
                    height: 56.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    '${controller.scansRemaining} scans remaining',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
