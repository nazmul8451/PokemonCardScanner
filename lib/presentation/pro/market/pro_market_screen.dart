import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProMarketAnalysisScreen extends StatelessWidget {
  const ProMarketAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchBar(),
                      SizedBox(height: 24.h),
                      _buildSectionHeader('Market Analysis', showTimer: true),
                      SizedBox(height: 16.h),
                      _buildMarketCard(
                        'Pokémon',
                        'assets/images/pokemon_bg.png', // Placeholder
                        '€120K',
                        '1,300',
                        '€200',
                      ),
                      SizedBox(height: 12.h),
                      _buildMarketCard(
                        'One Piece',
                        'assets/images/one_piece_bg.png', // Placeholder
                        '€120K',
                        '850',
                        '€200',
                      ),
                      SizedBox(height: 12.h),
                      _buildMarketCard(
                        'Yu-Gi-Oh!',
                        'assets/images/yugioh_bg.png', // Placeholder
                        '€120K',
                        '620',
                        '€200',
                      ),
                      SizedBox(height: 32.h),
                      _buildSectionHeader('Trending Now', showTimer: false),
                      SizedBox(height: 16.h),
                      _buildTrendingItem(
                        'Luffy Gear 5',
                        'OP-05',
                        '€245.5',
                        '+67.8%',
                        true,
                      ),
                      SizedBox(height: 12.h),
                      _buildTrendingItem(
                        'Charizard VMAX',
                        'CP',
                        '€589.99',
                        '-15.2%',
                        false,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=ibrahim'), // Placeholder
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ibrahim',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.diamond_outlined, color: Color(0xFFFFD700), size: 12),
                    SizedBox(width: 4.w),
                    Text(
                      'Professional',
                      style: TextStyle(
                        color: const Color(0xFFFFD700),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 24.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white.withOpacity(0.5), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search markets...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14.sp),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required bool showTimer}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (title == 'Market Analysis')
              const Icon(Icons.bar_chart_rounded, color: Color(0xFFFFCC00), size: 20),
            if (title == 'Trending Now')
              const Icon(Icons.whatshot_rounded, color: Colors.redAccent, size: 20),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        if (showTimer)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 8.sp),
                SizedBox(width: 6.w),
                Text(
                  'Last 30D',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMarketCard(String name, String bgImg, String vol, String sold, String avg) {
    return Container(
      height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          // Background text/image placeholder
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.1,
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.sp,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.image, color: Colors.white30, size: 20),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.3)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMarketStat('VOLUME', vol),
                    _buildMarketStat('SOLD', sold, isCenter: true),
                    _buildMarketStat('AVG PRICE', avg),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStat(String label, String value, {bool isCenter = false}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingItem(String name, String set, String price, String change, bool isUp) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.white24),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
                Text(
                  set,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'VOL: €125K',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10.sp),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
              ),
              Row(
                children: [
                  Icon(isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: isUp ? Colors.greenAccent : Colors.redAccent, size: 20),
                  Text(
                    change,
                    style: TextStyle(color: isUp ? Colors.greenAccent : Colors.redAccent, fontSize: 12.sp, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                'PROFESSIONAL DATA',
                style: TextStyle(color: const Color(0xFFFFD700), fontSize: 9.sp, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
