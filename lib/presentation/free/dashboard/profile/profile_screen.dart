import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../commonWidgets/common_widgets.dart';
import '../professional/professional_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                    _buildAccountStatusCard(),
                    SizedBox(height: 16.h),
                    _buildUpgradeProCard(context),
                    SizedBox(height: 24.h),
                    _buildLanguageSection(),
                    SizedBox(height: 24.h),
                    _buildAppearanceSection(),
                    SizedBox(height: 24.h),
                    _buildOtherSettingsSection(),
                    SizedBox(height: 24.h),
                    _buildLogOutButton(),
                    SizedBox(height: 32.h),
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
                  'Settings',
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

  Widget _buildAccountStatusCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.star_outline_rounded,
                  color: Colors.white.withOpacity(0.5),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Free Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Limited features',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeProCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A170F),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFFFFCC00).withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.diamond_outlined,
                  color: Colors.black,
                  size: 28.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upgrade to Pro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '\$9.99',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '/mo',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text(
            'Unlock all premium features',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          _buildFeatureItem('Unlimited card scans'),
          _buildFeatureItem('Advanced forecasts (5 years)'),
          _buildFeatureItem('Personalized alerts'),
          _buildFeatureItem('Detailed analytics'),
          _buildFeatureItem('Blue checkmark verification'),
          _buildFeatureItem('Priority support'),
          _buildFeatureItem('Export reports'),
          _buildFeatureItem('API access'),
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
            label: 'Upgrade Now',
            height: 52.h,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(
            Icons.check_rounded,
            color: const Color(0xFFFFD700),
            size: 16.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.public_rounded,
              color: const Color(0xFFFFD700),
              size: 18.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF15181D),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'English',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white70,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppearanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.dark_mode_outlined,
              color: const Color(0xFFFFD700),
              size: 18.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Appearance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildThemeToggle(
                label: 'Light',
                icon: Icons.wb_sunny_outlined,
                isSelected: false,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildThemeToggle(
                label: 'Dark',
                icon: Icons.nightlight_round_outlined,
                isSelected: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeToggle({
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: const Color(0xFF15181D),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFFFD700).withOpacity(0.4)
              : Colors.white.withOpacity(0.05),
          width: isSelected ? 1.5.w : 1.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFFFD700) : Colors.white38,
            size: 20.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white38,
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              _buildSettingsItem('Help & Support'),
              Divider(color: Colors.white.withOpacity(0.05), height: 1),
              _buildSettingsItem('Privacy Policy'),
              Divider(color: Colors.white.withOpacity(0.05), height: 1),
              _buildSettingsItem('Terms of Service'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      title: Text(
        title,
        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15.sp),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: Colors.white24,
        size: 20.sp,
      ),
      onTap: () {},
    );
  }

  Widget _buildLogOutButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1212),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: Colors.redAccent.withOpacity(0.8),
              size: 18.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Log Out',
              style: TextStyle(
                color: Colors.redAccent.withOpacity(0.8),
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
