import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../professional/professional_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSettingsTab = true;
  int _selectedAppIconIndex = 0;

  void _navigateToPro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfessionalScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(height: 16.h),
            _buildProfileHeader(),
            SizedBox(height: 24.h),
            _buildTabs(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: _isSettingsTab ? _buildSettingsTab() : _buildFollowUsTab(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 44.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white38, size: 20.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search settings...',
                      hintStyle: TextStyle(
                        color: Colors.white30,
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.person, color: Colors.white24, size: 30.sp),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 10.sp),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Ibrahim',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Text(
                      'FREE MEMBER',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                'alex.rivera@predictcg.com',
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isSettingsTab = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _isSettingsTab ? const Color(0xFFFFD700) : Colors.transparent,
                      width: 2.w,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                      color: _isSettingsTab ? Colors.white : Colors.white.withOpacity(0.4),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isSettingsTab = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: !_isSettingsTab ? const Color(0xFFFFD700) : Colors.transparent,
                      width: 2.w,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'FOLLOW US',
                    style: TextStyle(
                      color: !_isSettingsTab ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.4),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListTile('Language', trailingText: 'English'),
        SizedBox(height: 24.h),
        _buildSectionHeader('WALLET SHARING'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFF141414),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Icon(Icons.link, color: Colors.white.withOpacity(0.3), size: 16.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'predictcg.com/w/ale...',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: _navigateToPro,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFCC00),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Generate Link',
                    style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: _navigateToPro,
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFF141414),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_none_rounded, color: Colors.white.withOpacity(0.5), size: 20.sp),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TCG Alert',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'PRO FEATURE',
                          style: TextStyle(color: const Color(0xFFFFCC00), fontSize: 9.sp, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.lock_rounded, color: const Color(0xFFFFCC00), size: 18.sp),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            _buildSectionHeader('APP ICONS'),
            SizedBox(width: 8.w),
            Icon(Icons.diamond_outlined, color: const Color(0xFFFFCC00), size: 12.sp),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAppIcon(0, const Color(0xFFFFCC00), Colors.black, true, isBlocked: false),
            _buildAppIcon(1, Colors.black, const Color(0xFFFFCC00), true, isBlocked: true, borderColor: const Color(0xFFFFCC00)),
            _buildAppIcon(2, const Color(0xFF2A3A4A), Colors.white, false, isBlocked: true),
            _buildAppIcon(3, const Color(0xFF8A2BE2), Colors.white, false, isBlocked: true),
            _buildAppIcon(4, const Color(0xFF8B4513), Colors.white, false, isBlocked: true),
          ],
        ),
        SizedBox(height: 32.h),
        _buildListTile('Enable 2FA', icon: Icons.shield_outlined),
        SizedBox(height: 32.h),
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Center(
          child: Text(
            'Delete Account',
            style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 14.sp, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget _buildFollowUsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSimpleTile('Support', Icons.email_outlined, trailingText: 'support@photopia.com'),
        SizedBox(height: 16.h),
        _buildSimpleTile('About us', Icons.info_outline, trailingIcon: Icons.open_in_new),
        SizedBox(height: 16.h),
        _buildSimpleTile('Privacy Policy', Icons.privacy_tip_outlined, trailingIcon: Icons.chevron_right),
        SizedBox(height: 16.h),
        _buildSimpleTile('Terms and Conditions', Icons.gavel_outlined, trailingIcon: Icons.chevron_right),
        SizedBox(height: 40.h),
        Center(
          child: Text(
            'SOCIAL MEDIA',
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12.sp, fontWeight: FontWeight.w800, letterSpacing: 1),
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon('X'),
            SizedBox(width: 24.w),
            _buildSocialIcon('ig'),
            SizedBox(width: 24.w),
            _buildSocialIcon('in'),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11.sp, fontWeight: FontWeight.w800, letterSpacing: 1),
    );
  }

  Widget _buildListTile(String title, {String? trailingText, IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon ?? Icons.language, color: Colors.white.withOpacity(0.5), size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              if (trailingText != null)
                Text(
                  trailingText,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp),
                ),
              SizedBox(width: 8.w),
              Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3), size: 20.sp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleTile(String title, IconData icon, {String? trailingText, IconData? trailingIcon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.5), size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (trailingText != null)
            Text(
              trailingText,
              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp),
            )
          else if (trailingIcon != null)
            Icon(trailingIcon, color: trailingIcon == Icons.open_in_new ? const Color(0xFFFFCC00).withOpacity(0.8) : Colors.white.withOpacity(0.3), size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildAppIcon(int index, Color bgColor, Color iconColor, bool isDynamic, {Color? borderColor, bool isBlocked = false}) {
    bool isSelected = _selectedAppIconIndex == index;
    return GestureDetector(
      onTap: isBlocked ? _navigateToPro : () => setState(() => _selectedAppIconIndex = index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16.r),
              border: borderColor != null ? Border.all(color: borderColor, width: 2) : null,
              boxShadow: isSelected
                  ? [BoxShadow(color: bgColor.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)]
                  : null,
            ),
            child: Center(
              child: Icon(Icons.style, color: iconColor, size: 24.sp),
            ),
          ),
          if (isSelected)
            Positioned(
              bottom: -8,
              left: 0,
              right: 0,
              child: Center(
                child: Icon(Icons.check_circle, color: Colors.greenAccent, size: 16.sp),
              ),
            ),
          if (isBlocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Icon(Icons.lock_rounded, color: const Color(0xFFFFCC00), size: 16.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String platform) {
    String assetName = '';
    if (platform == 'X') {
      assetName = 'assets/images/x.png';
    } else if (platform == 'in') {
      assetName = 'assets/images/l.png';
    } else {
      assetName = 'assets/images/v.png';
    }

    return Container(
      width: 48.r,
      height: 48.r,
      decoration: const BoxDecoration(
        color: Color(0xFF141414),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(assetName, width: 24.r, height: 24.r, fit: BoxFit.contain, color: Colors.white.withOpacity(0.6)),
      ),
    );
  }
}
