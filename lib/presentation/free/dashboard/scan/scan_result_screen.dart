import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

import '../../../commonWidgets/common_widgets.dart';
import '../professional/professional_screen.dart';

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    _buildLimitCard(context),
                    SizedBox(height: 16.h),
                    _buildResultCard(context),
                    SizedBox(height: 24.h),
                    _buildPriceGrid(context),
                    SizedBox(height: 24.h),
                    _buildPriceHistoryChart(context),
                    SizedBox(height: 24.h),
                    _buildAlgorithmPredictionsSection(context),
                    SizedBox(height: 24.h),
                    _buildScanAnotherButton(context),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
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
                  hintText: 'Search cards...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14.sp),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitCard(BuildContext context) {
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

  Widget _buildResultCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.w,
            height: 165.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.image_outlined,
              color: Colors.white.withOpacity(0.2),
              size: 40.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Charizard\nVMAX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Champion's Path",
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Basic Condition\nRating',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '8.5',
                            style: TextStyle(
                              color: const Color(0xFFFFD740),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            '/10',
                            style: TextStyle(
                              color: const Color(0xFFFFD740).withOpacity(0.5),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '(82%) 7/10 Near Mint',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Current Market Value',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '€589.99',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceGrid(BuildContext context) {
    return _buildLockedOverlay(
      context,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Average Price',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 2.0,
              children: [
                _buildPriceCard('Tcgplayer', '€595'),
                _buildPriceCard('Ebay', '€580'),
                _buildPriceCard('Cardmarket', '€592.5'),
                _buildPriceCard('JustTCG', '€587'),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  'Average:  ',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  '€589.99',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard(String platform, String price) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            platform,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceHistoryChart(BuildContext context) {
    return _buildLockedOverlay(
      context,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price History (6 Months)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 180.h,
              width: double.infinity,
              child: CustomPaint(
                painter: _ProChartPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedOverlay(BuildContext context, {required Widget child}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfessionalScreen()),
        );
      },
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141414),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFFD700).withOpacity(0.2),
                    ),
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: const Color(0xFFFFD700),
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlgorithmPredictionsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: const Color(0xFFFFD700), size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Algorithm Price Predictions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildAlgorithmPredictionsGrid(context),
        ],
      ),
    );
  }

  Widget _buildAlgorithmPredictionsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildPredictionCard(context, '3M', '€650', '+10.2%', 'Confidence', '92%', isBlocked: true)),
            SizedBox(width: 12.w),
            Expanded(child: _buildPredictionCard(context, '6M', '€720', '+22.0%', 'Confidence', '89%', isBlocked: true)),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildPredictionCard(context, '1Y', '€820', '+39.0%', 'Confidence', '87%', isBlocked: true)),
            SizedBox(width: 12.w),
            Expanded(child: _buildPredictionCard(context, '3Y', '€1200', '+103.4%', 'Risk', '78%', isRisk: true, isBlocked: true)),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildPredictionCard(context, '5Y', '€1650', '+179.7%', 'Confidence', '72%', isBlocked: false)),
            SizedBox(width: 12.w),
            Expanded(child: const SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildPredictionCard(BuildContext context, String duration, String price, String change, String metricsType, String metricsValue, {bool isRisk = false, bool isBlocked = false}) {
    return GestureDetector(
      onTap: isBlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfessionalScreen()),
              );
            }
          : null,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isBlocked 
                  ? Colors.white.withOpacity(0.05) 
                  : const Color(0xFFFFD700).withOpacity(0.15)
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(duration, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp)),
                SizedBox(height: 6.h),
                Text(price, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.call_made, color: const Color(0xFFFFD700), size: 10.sp),
                    SizedBox(width: 4.w),
                    Text(change, style: TextStyle(color: const Color(0xFFFFD700), fontSize: 11.sp, fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: Colors.white.withOpacity(0.05), height: 1),
                SizedBox(height: 8.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '$metricsType: ', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp)),
                      TextSpan(text: metricsValue, style: TextStyle(color: isRisk ? Colors.redAccent : const Color(0xFFFFD700), fontSize: 10.sp, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
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
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.2)),
                    ),
                    child: Icon(Icons.lock_outline_rounded, color: const Color(0xFFFFD700), size: 16.sp),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScanAnotherButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.w),
        ),
        child: Center(
          child: Text(
            'Scan Another Card',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final activeColor = const Color(0xFFFFD700);
    final axisPaint = Paint()
      ..color = Colors.white12
      ..strokeWidth = 1.0;
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 0.5;
    final linePaint = Paint()
      ..color = activeColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final textStyle = TextStyle(
      color: Colors.white.withOpacity(0.3),
      fontSize: 8.sp,
      fontWeight: FontWeight.w600,
    );

    final marginLeft = 40.w;
    final marginBottom = 30.h;
    final chartWidth = size.width - marginLeft;
    final chartHeight = size.height - marginBottom;

    // Draw grid & axes
    canvas.drawLine(Offset(marginLeft, 0), Offset(marginLeft, chartHeight), axisPaint);
    canvas.drawLine(Offset(marginLeft, chartHeight), Offset(size.width, chartHeight), axisPaint);

    // Data points (mock)
    final points = [
      Offset(marginLeft + 0, chartHeight - 30.h),
      Offset(marginLeft + chartWidth * 0.16, chartHeight - 40.h),
      Offset(marginLeft + chartWidth * 0.33, chartHeight - 50.h),
      Offset(marginLeft + chartWidth * 0.5, chartHeight - 60.h),
      Offset(marginLeft + chartWidth * 0.66, chartHeight - 65.h),
      Offset(marginLeft + chartWidth * 0.83, chartHeight - 75.h),
      Offset(size.width, chartHeight - 85.h),
    ];

    final path = Path();
    if (points.isNotEmpty) {
      path.moveTo(points.first.dx, points.first.dy);
      
      for (int i = 0; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        
        final cp1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
        final cp2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
        
        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
        canvas.drawLine(Offset(points[i].dx, 0), Offset(points[i].dx, chartHeight), gridPaint);
      }
    }
    
    canvas.drawPath(path, linePaint);

    // Y-Axis Labels
    final yLabels = ['€600', '€450', '€300', '€150', '€0'];
    final yStep = chartHeight / 4;
    for (int i = 0; i < yLabels.length; i++) {
      final tp = TextPainter(text: TextSpan(text: yLabels[i], style: textStyle), textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(marginLeft - tp.width - 8.w, i * yStep - 4.h));
      canvas.drawLine(Offset(marginLeft - 4.w, i * yStep), Offset(marginLeft, i * yStep), axisPaint);
    }

    // X-Axis Labels
    final xLabels = ['1D', '7D', '1M', '3M', '6M', '1Y', 'All'];
    final xStep = chartWidth / 6;
    for (int i = 0; i < xLabels.length; i++) {
      final tp = TextPainter(text: TextSpan(text: xLabels[i], style: textStyle), textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(marginLeft + (i * xStep) - tp.width / 2, chartHeight + 8.h));
      canvas.drawLine(Offset(marginLeft + (i * xStep), chartHeight), Offset(marginLeft + (i * xStep), chartHeight + 4.h), axisPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
