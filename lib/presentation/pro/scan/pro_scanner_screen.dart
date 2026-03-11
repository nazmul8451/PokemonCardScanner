import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProScannerScreen extends StatelessWidget {
  const ProScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 16.h),
              _buildProBanner(),
              SizedBox(height: 16.h),
              _buildCardAnalysisSummary(),
              SizedBox(height: 24.h),
              _buildPriceGrid(),
              SizedBox(height: 24.h),
              _buildPriceHistoryChart(),
              SizedBox(height: 24.h),
              _buildSectionTitle('Algorithm Price Predictions'),
              SizedBox(height: 16.h),
              _buildAlgorithmPredictionsGrid(),
              SizedBox(height: 24.h),
              _buildActionButtons(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20.r, backgroundColor: const Color(0xFF1A1A1A), child: const Icon(Icons.person, color: Colors.white24)),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ibrahim', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  Text('Professional', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 11.sp, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 24.sp)),
        ],
      ),
    );
  }

  Widget _buildProBanner() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1A170F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFD700), size: 28),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Unlimited Pro Scanning', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w800)),
                Text('Advanced AI condition analysis', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12.sp)),
              ],
            ),
          ),
          const Icon(Icons.star_rounded, color: Color(0xFFFFD700), size: 24),
        ],
      ),
    );
  }

  Widget _buildCardAnalysisSummary() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.w,
            height: 140.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.white12, size: 40),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Charizard VMAX', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
                Text("Champion's Path", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp)),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1C12),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Condition Rating', style: TextStyle(color: const Color(0xFFFFD700).withOpacity(0.6), fontSize: 10.sp, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4.h),
                      Text('8.5/10', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 24.sp, fontWeight: FontWeight.w900)),
                      Text('(82%) 7/10 Near Mint', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Text('Current Market Value', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11.sp, fontWeight: FontWeight.w600)),
                Text('\$589.99', style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w900, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Average Price'),
        SizedBox(height: 12.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 2.2,
          children: [
            _buildPriceCard('Tcgplayer', '\$595'),
            _buildPriceCard('Ebay', '\$580'),
            _buildPriceCard('Cardmarket', '\$592.5'),
            _buildPriceCard('JustTCG', '\$587'),
          ],
        ),
        SizedBox(height: 12.h),
        Center(child: Text('Average: \$589.99', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12.sp, fontWeight: FontWeight.w600))),
      ],
    );
  }

  Widget _buildPriceCard(String platform, String price) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(platform, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp)),
          const Spacer(),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildPriceHistoryChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Price History (6 Months)'),
        SizedBox(height: 16.h),
        Container(
          height: 180.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Icon(Icons.auto_graph_rounded, color: const Color(0xFFFFD700).withOpacity(0.2), size: 100.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildAlgorithmPredictionsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.2,
      children: [
        _buildPredictCard('3M', '\$650', '+10.2%', '97%'),
        _buildPredictCard('6M', '\$720', '+22.0%', '88%'),
        _buildPredictCard('1Y', '\$820', '+39.0%', '87%'),
        _buildPredictCard('3Y', '\$1200', '+103.4%', '79%', isRisk: true),
      ],
    );
  }

  Widget _buildPredictCard(String time, String price, String change, String conf, {bool isRisk = false}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp)),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900)),
          Text(change, style: TextStyle(color: Colors.greenAccent, fontSize: 13.sp, fontWeight: FontWeight.w700)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(isRisk ? 'Risk: $conf' : 'Confidence: $conf', style: TextStyle(color: isRisk ? Colors.redAccent : Colors.white24, fontSize: 10.sp, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildSmallButton('New Scan', Colors.white10),
        SizedBox(width: 8.w),
        _buildSmallButton('Add to Wallet', Colors.white10),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFFCC00), Color(0xFFFFD700)]),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [BoxShadow(color: const Color(0xFFFFD700).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Center(
              child: Text('Export', style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallButton(String label, Color color) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12.r)),
      child: Center(
        child: Text(label, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        if (title == 'Algorithm Price Predictions')
          const Icon(Icons.insights_rounded, color: Color(0xFFFFD700), size: 18),
        if (title == 'Algorithm Price Predictions') SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
