import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../commonWidgets/common_widgets.dart';
import '../professional/professional_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _buildStatsRow(),
                    SizedBox(height: 16.h),
                    _buildLimitedFeaturesCard(context),
                    SizedBox(height: 24.h),
                    _buildSectionHeader(context),
                    SizedBox(height: 16.h),
                    _buildCardList(),
                    SizedBox(height: 24.h),
                    _buildProAnalyticsCard(context),
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
                  'Wallet',
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

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            label: 'Invested',
            value: '\$1,080',
            icon: Icons.attach_money_rounded,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            label: 'Value',
            value: '\$425.48',
            icon: Icons.trending_up_rounded,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            label: 'ROI',
            value: '+32.0%',
            icon: Icons.trending_up_rounded,
            valueColor: const Color(0xFFFFD700),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14.sp,
                color: const Color(0xFFFFCC00).withOpacity(0.7),
              ),
              SizedBox(width: 4.w),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitedFeaturesCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A170F),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.15),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Limited Wallet Features',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Upgrade for alerts, analytics, and ROI predictions',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
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
            label: 'Unlock Pro Features',
            height: 46.h,
            fontSize: 15.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your Cards',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A170F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.2),
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.add, size: 16.sp, color: const Color(0xFFFFD700)),
              SizedBox(width: 4.w),
              Text(
                'Add Card',
                style: TextStyle(
                  color: const Color(0xFFFFD700),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardList() {
    return Column(
      children: [
        _buildCardItem(
          name: 'Charizard VMAX',
          set: "Champion's Path",
          qty: 2,
          price: '\$1,179.98',
          change: '+31.1%',
        ),
        SizedBox(height: 12.h),
        _buildCardItem(
          name: 'Luffy Gear 5',
          set: "OP-05",
          qty: 1,
          price: '\$245.5',
          change: '+36.4%',
        ),
      ],
    );
  }

  Widget _buildCardItem({
    required String name,
    required String set,
    required int qty,
    required String price,
    required String change,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.image_outlined,
              color: Colors.white.withOpacity(0.2),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$set • Qty: $qty',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                change,
                style: TextStyle(
                  color: const Color(0xFFFFD700),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProAnalyticsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/diamond_icon.png',
            width: 70.w,
            height: 70.w,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.diamond_outlined,
              color: const Color(0xFFFFD700),
              size: 40.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Pro Analytics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Get detailed portfolio analytics and predictions',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
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
            label: 'Upgrade to Pro',
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
