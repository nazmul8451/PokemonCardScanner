import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProWalletScreen extends StatelessWidget {
  const ProWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _buildBalanceHeader(),
                    SizedBox(height: 24.h),
                    _buildChartPlaceholder(),
                    SizedBox(height: 24.h),
                    _buildTimeFilter(),
                    SizedBox(height: 32.h),
                    Text(
                      'Market Volume',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionItem('Pokémon', '1.3K Sold', '\$120K Vol'),
                    _buildSectionItem('One Piece', '850 Sold', '\$120K Vol'),
                    SizedBox(height: 32.h),
                    _buildAlgorithmPredictions(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
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
              CircleAvatar(radius: 18.r, backgroundColor: const Color(0xFF121212), child: Icon(Icons.person, size: 18.sp, color: Colors.white24)),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ibrahim', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
                  Text('Professional', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 10.sp, fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 24.sp)),
        ],
      ),
    );
  }

  Widget _buildBalanceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Wallet ', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16.sp)),
            Text('Predict', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 16.sp, fontWeight: FontWeight.w700)),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(4.r)),
              child: Text('EUR', style: TextStyle(color: Colors.blue, fontSize: 10.sp, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text('€64,650.03', style: TextStyle(color: Colors.white, fontSize: 36.sp, fontWeight: FontWeight.w900)),
            SizedBox(width: 12.w),
            Icon(Icons.visibility_outlined, color: Colors.white.withOpacity(0.3), size: 24.sp),
          ],
        ),
        SizedBox(height: 4.h),
        Text('+€10,000.00 in the last 30 days', style: TextStyle(color: Colors.greenAccent, fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildChartPlaceholder() {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Center(
        child: Stack(
          children: [
            // Simplified "Chart" using CustomPaint would be better, but for now a styled placeholder
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: CustomPaint(painter: _ChartPainter()),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(16.r), border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildChartRow('Apri:', '485,1 €'),
                    _buildChartRow('Chiudi:', '541,3 €'),
                    _buildChartRow('Modifica:', '11,59%', color: Colors.orange),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartRow(String label, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12.sp)),
          SizedBox(width: 12.w),
          Text(value, style: TextStyle(color: color ?? Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildTimeFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['+1M', '+3M', '+6M', '+1Y', '+3Y', '+5Y'].map((t) {
        bool isSelected = t == '+3Y';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(t, style: TextStyle(color: isSelected ? Colors.black : Colors.white.withOpacity(0.4), fontSize: 12.sp, fontWeight: FontWeight.w800)),
        );
      }).toList(),
    );
  }

  Widget _buildSectionItem(String name, String sold, String vol) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: const Color(0xFF141414), borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Row(
        children: [
          Container(width: 44.r, height: 44.r, decoration: const BoxDecoration(color: Color(0xFF1A1A1A), shape: BoxShape.circle), child: const Icon(Icons.apps, color: Colors.white24)),
          SizedBox(width: 16.w),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
            Text(sold, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp)),
          ]),
          const Spacer(),
          Text(vol, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  Widget _buildAlgorithmPredictions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Algorithm Price Predictions', style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800)),
        SizedBox(height: 16.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.4,
          children: [
            _buildPredictCard('3M', '\$650', '+10.2%', '97%'),
            _buildPredictCard('6M', '\$720', '+22.0%', '88%'),
          ],
        ),
      ],
    );
  }

  Widget _buildPredictCard(String time, String price, String change, String conf) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: const Color(0xFF141414), borderRadius: BorderRadius.circular(20.r), border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp)),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w900)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(change, style: TextStyle(color: Colors.greenAccent, fontSize: 12.sp, fontWeight: FontWeight.w700)),
              Text('Conf: $conf', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFFFD700)..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7, size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.1, size.width, size.height * 0.2);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
