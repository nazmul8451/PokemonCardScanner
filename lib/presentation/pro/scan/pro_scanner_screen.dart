import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProScannerScreen extends StatefulWidget {
  final VoidCallback? onAddToWallet;

  const ProScannerScreen({super.key, this.onAddToWallet});

  @override
  State<ProScannerScreen> createState() => _ProScannerScreenState();
}

class _ProScannerScreenState extends State<ProScannerScreen> {
  bool _showResult = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildHeader(context),
            ),
            Divider(color: Colors.white.withOpacity(0.05), height: 1),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    _buildProBanner(),
                    SizedBox(height: 24.h),
                    if (!_showResult) ...[
                      _buildScannerPlaceholder(context),
                    ] else ...[
                      _buildCardAnalysisSummary(),
                      SizedBox(height: 24.h),
                      _buildPriceGrid(),
                      SizedBox(height: 24.h),
                      _buildPriceHistoryChart(),
                      SizedBox(height: 24.h),
                      _buildAlgorithmPredictionsSection(),
                      SizedBox(height: 48.h),
                    ],
                  ],
                ),
              ),
            ),
            if (_showResult) _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFCC00), width: 1.5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.person, color: Colors.white24, size: 20.sp),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ibrahim', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
                  Row(
                    children: [
                      Icon(Icons.diamond_outlined, color: const Color(0xFFFFCC00), size: 10.sp),
                      SizedBox(width: 4.w),
                      Text('Professional', style: TextStyle(color: const Color(0xFFFFCC00), fontSize: 11.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.search, color: Colors.white, size: 24.sp),
              SizedBox(width: 16.w),
              Stack(
                children: [
                  Icon(Icons.notifications_none_rounded, color: Colors.white, size: 24.sp),
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFCC00),
                        shape: BoxShape.circle,
                      ),
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

  Widget _buildProBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141208),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.diamond_outlined, color: const Color(0xFFFFCC00), size: 32.sp), 
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Unlimited Pro Scanning', style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800)),
                Text('Advanced AI condition analysis', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13.sp)),
              ],
            ),
          ),
          Icon(Icons.star_rounded, color: const Color(0xFFFFCC00), size: 28.sp),
        ],
      ),
    );
  }

  Widget _buildScannerPlaceholder(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF161719),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.15)),
            ),
            child: Column(
              children: [
                Icon(Icons.camera_alt_outlined, color: const Color(0xFFFFCC00), size: 72.sp),
                SizedBox(height: 24.h),
                Text(
                  'Advanced Card Scanner',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8.h),
                Text(
                  'AI-powered condition\nanalysis • Grading\nsuggestions',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14.sp, height: 1.4),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _showResult = true;
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFEA75), Color(0xFFFFCC00)]),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(color: const Color(0xFFFFCC00).withOpacity(0.2), blurRadius: 20, spreadRadius: 2),
                ],
              ),
              child: Center(
                child: Text(
                  'Start Pro Scanning',
                  style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardAnalysisSummary() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              'assets/images/card1.png', 
              width: 120.w, 
              height: 170.h, 
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 120.w,
                height: 170.h,
                color: const Color(0xFF1A1A1A),
                child: Icon(Icons.image, color: Colors.white24, size: 40.sp),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Charizard\nVMAX', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800, height: 1.2)),
                SizedBox(height: 4.h),
                Text("Champion's Path", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp)),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1C12),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Condition\nRating', style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1.2)),
                      SizedBox(height: 8.h),
                      Text('8.5/10', style: TextStyle(color: const Color(0xFFFFCC00), fontSize: 26.sp, fontWeight: FontWeight.w800)),
                      SizedBox(height: 4.h),
                      Text('(82%) 7/10 Near Mint', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 9.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Current Market Value', style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                Text('\$589.99', style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w900, fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceGrid() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Average Price', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 2.0,
            children: [
              _buildPriceCard('Tcgplayer', '\$595'),
              _buildPriceCard('Ebay', '\$580'),
              _buildPriceCard('Cardmarket', '\$592.5'),
              _buildPriceCard('JustTCG', '\$587'),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text('Average:  ', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp)),
              Text('\$589.99', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(String platform, String price) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(platform, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11.sp)),
          SizedBox(height: 4.h),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
        ],
      ),
    );
  }

  Widget _buildPriceHistoryChart() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price History (6 Months)', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
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
    );
  }

  Widget _buildAlgorithmPredictionsSection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: const Color(0xFFFFCC00), size: 20.sp),
              SizedBox(width: 8.w),
              Text('Algorithm Price Predictions', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w800)),
            ],
          ),
          SizedBox(height: 16.h),
          _buildAlgorithmPredictionsGrid(),
        ],
      ),
    );
  }

  Widget _buildAlgorithmPredictionsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildPredictionCard('3M', '\$650', '+10.2%', 'Confidence', '92%')),
            SizedBox(width: 12.w),
            Expanded(child: _buildPredictionCard('6M', '\$720', '+22.0%', 'Confidence', '89%')),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildPredictionCard('1Y', '\$820', '+39.0%', 'Confidence', '87%')),
            SizedBox(width: 12.w),
            Expanded(child: _buildPredictionCard('3Y', '\$1200', '+103.4%', 'Risk', '78%', isRisk: true)),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildPredictionCard('5Y', '\$1650', '+179.7%', 'Confidence', '72%')),
            SizedBox(width: 12.w),
            Expanded(child: const SizedBox.shrink()),
          ],
        ),
      ],
    );
  }

  Widget _buildPredictionCard(String duration, String price, String change, String metricsType, String metricsValue, {bool isRisk = false}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(duration, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11.sp)),
          SizedBox(height: 8.h),
          Text(price, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w900, fontFamily: 'Inter')),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.call_made, color: const Color(0xFFFFCC00), size: 12.sp),
              SizedBox(width: 4.w),
              Text(change, style: TextStyle(color: const Color(0xFFFFCC00), fontSize: 13.sp, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.white.withOpacity(0.1), height: 1),
          SizedBox(height: 12.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '$metricsType: ', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11.sp)),
                TextSpan(text: metricsValue, style: TextStyle(color: isRisk ? Colors.redAccent : const Color(0xFFFFCC00), fontSize: 11.sp, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 12.h, bottom: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0E11),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showResult = false;
                });
              },
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Center(child: Text('New Scan', style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600))),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: widget.onAddToWallet,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1C12),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFFFCC00).withOpacity(0.2)),
                ),
                child: Center(child: Text('Add to Wallet', style: TextStyle(color: const Color(0xFFFFCC00), fontSize: 14.sp, fontWeight: FontWeight.w600))),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFEA75), Color(0xFFFFCC00)]),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: Text('Export', style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w800))),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFFFCC00)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    final axisPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1;

    final textStyle = TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10.sp);

    // Chart Area Boundaries
    final marginLeft = 40.w;
    final marginBottom = 20.h;
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
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
      // Draw grid lines
      canvas.drawLine(Offset(points[i].dx, 0), Offset(points[i].dx, chartHeight), gridPaint);
    }
    canvas.drawPath(path, linePaint);

    // Draw dots
    for (final point in points) {
      canvas.drawCircle(point, 4.r, Paint()..color = const Color(0xFFFFCC00));
    }

    // Y-Axis Labels
    final yLabels = ['\$600', '\$450', '\$300', '\$150', '\$0'];
    final yStep = chartHeight / 4;
    for (int i = 0; i < yLabels.length; i++) {
      final tp = TextPainter(text: TextSpan(text: yLabels[i], style: textStyle), textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(marginLeft - tp.width - 8.w, i * yStep - 6.h));
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
