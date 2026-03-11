import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProHomeScreen extends StatelessWidget {
  const ProHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTabs(),
                    SizedBox(height: 24.h),
                    _buildFeaturedInsight(),
                    SizedBox(height: 24.h),
                    _buildQuickStats(),
                    SizedBox(height: 32.h),
                    _buildSectionHeader('Recent Predictions'),
                    SizedBox(height: 16.h),
                    _buildPredictionCard('Luffy Gear 5', '+67.8%', 'Very High'),
                    SizedBox(height: 12.h),
                    _buildPredictionCard('Charizard VMAX', '+12.4%', 'Moderate'),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20.r, backgroundColor: Colors.white10),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ibrahim', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  Row(
                    children: [
                      const Icon(Icons.diamond_outlined, color: Color(0xFFFFD700), size: 12),
                      SizedBox(width: 4.w),
                      Text('Professional', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 11.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.search, color: Colors.white, size: 24.sp)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        Text('Dashboard', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18.sp, fontWeight: FontWeight.w600)),
        SizedBox(width: 24.w),
        Column(
          children: [
            Row(
              children: [
                Text('Professional', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
                SizedBox(width: 4.w),
                const Icon(Icons.diamond_rounded, color: Color(0xFFFFD700), size: 18),
              ],
            ),
            SizedBox(height: 4.h),
            Container(width: 40.w, height: 2.h, color: const Color(0xFFFFD700)),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedInsight() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1E1C12), const Color(0xFF121212)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.2)),
        boxShadow: [BoxShadow(color: const Color(0xFFFFD700).withOpacity(0.05), blurRadius: 20, spreadRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PORTFOLIO SURGE', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 11.sp, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
          SizedBox(height: 8.h),
          Text('Your collection value increased by €10,000 this month.', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700, height: 1.3)),
          SizedBox(height: 16.h),
          Row(
            children: [
              const Icon(Icons.trending_up_rounded, color: Colors.greenAccent),
              SizedBox(width: 8.w),
              Text('Top Performer: Pokémon', style: TextStyle(color: Colors.greenAccent, fontSize: 13.sp, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 20.h),
          Text('View detailed analysis →', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 13.sp, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(child: _buildStatItem('Balance', '€64.6K')),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatItem('Growth', '+32%')),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatItem('Cards', '241')),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800));
  }

  Widget _buildPredictionCard(String name, String trend, String confidence) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(width: 48.r, height: 48.r, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12.r)), child: const Icon(Icons.show_chart_rounded, color: Color(0xFFFFD700))),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                Text('Confidence: $confidence', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12.sp)),
              ],
            ),
          ),
          Text(trend, style: TextStyle(color: Colors.greenAccent, fontSize: 16.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
