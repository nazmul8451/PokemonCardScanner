import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../../free/dashboard/wallet/card_details_screen.dart';

class ProWalletScreen extends StatefulWidget {
  const ProWalletScreen({super.key});

  @override
  State<ProWalletScreen> createState() => _ProWalletScreenState();
}

class _ProWalletScreenState extends State<ProWalletScreen> {
  String _selectedTimeFilter = '1M';
  double? _scrubX;

  final List<double> chartPoints = [0.2, 0.25, 0.23, 0.4, 0.5, 0.48, 0.55, 0.7, 0.65, 0.8, 0.85, 0.8];

  void _updateScrubPosition(double localX) {
    if (_scrubX != localX) {
      setState(() {
        _scrubX = localX;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11), // Dark background
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 12.h),
                    _buildBalance(),
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildActionsRow(),
                    ),
                    SizedBox(height: 48.h),
                    _buildChart(),
                    SizedBox(height: 32.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildTimeFilter(),
                    ),
                    SizedBox(height: 40.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: _buildGrid(context),
                    ),
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

  Widget _buildAppBar(BuildContext context) {
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
            'Wallet',
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
              color: const Color(0xFF121212),
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
                      hintText: 'Search cards...',
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

  Widget _buildBalance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('€1,312.07',
            style: TextStyle(
                color: Colors.white,
                fontSize: 34.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: -1)),
        SizedBox(width: 12.w),
        Icon(Icons.visibility_outlined,
            color: Colors.white.withOpacity(0.3), size: 22.sp),
      ],
    );
  }

  Widget _buildActionsRow() {
    return Row(
      children: [
        Expanded(child: _buildActionItem(Icons.auto_graph_rounded, 'Top Performers')),
        Expanded(child: _buildActionItem(Icons.add, 'Add')),
        Expanded(child: _buildActionItem(Icons.ios_share, 'Share')),
        Expanded(child: _buildActionItem(Icons.send_rounded, 'Export')),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56.r,
          height: 56.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3), width: 1.5),
          ),
          child: Center(
            child: Icon(icon, color: const Color(0xFF00E5FF), size: 24.sp),
          ),
        ),
        SizedBox(height: 8.h),
        Text(label, style: TextStyle(color: const Color(0xFF00E5FF), fontSize: 11.sp, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 180.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                _updateScrubPosition(details.localPosition.dx);
              },
              onTapDown: (details) {
                _updateScrubPosition(details.localPosition.dx);
              },
              onHorizontalDragEnd: (_) {
                setState(() {
                  _scrubX = null;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _scrubX = null;
                });
              },
              child: Container(
                color: Colors.transparent,
                child: CustomPaint(painter: _WalletChartPainter(const Color(0xFF00E5FF), chartPoints, _scrubX)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ['1D', '7D', '1M', '3M', '6M', 'ALL'].map((t) {
          bool isSelected = _selectedTimeFilter == t;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeFilter = t;
                _scrubX = null;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2A2A2A) : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(t, style: TextStyle(color: isSelected ? Colors.white : Colors.white.withOpacity(0.4), fontSize: 13.sp, fontWeight: FontWeight.w800)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 16.h,
      childAspectRatio: 0.48, // Adjusted for taller cards to match mockup
      children: [
        _buildCardItem(
          context,
          'assets/images/card1.png', 
          'Charizard VMAX', 'Shining Fates: Shiny Vault\nShiny Holo Rare • SV107/SV122',
          'Near Mint', 'Holofoil', '1+', '€158.96', '€8.92 (5.95%)', true,
        ),
        _buildCardItem(
          context,
          'assets/images/card2.png', 
          'Charizard', 'Celebrations: Classic Collection\nClassic Collection • 4/102',
          'Near Mint', 'Holofoil', '1+', '€144.00', '€0.79 (0.55%)', true,
        ),
        _buildCardItem(
          context,
          'assets/images/card3.png', 
          'M Charizard EX', 'Evolutions\nUltra Rare • 13/108',
          'Near Mint', 'Holofoil', '1+', '€84.50', '€2.30 (1.20%)', false,
        ),
        _buildCardItem(
          context,
          'assets/images/card4.png', 
          'Sephiroth - 11-130L (Full Art)', 'Opus XI\nLegend • 11-130L',
          'Near Mint', 'Foil', '1+', '€45.00', '€1.15 (2.10%)', true,
        ),
      ],
    );
  }

  Widget _buildCardItem(BuildContext context, String img, String title, String subtitle, String condition, String attribute, String qty, String price, String changeAmt, bool isUp) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailsScreen(
              title: title,
              subtitle: subtitle.split('\n').first,
              price: price,
              changeAmt: changeAmt,
              isUp: isUp,
              imagePath: img,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF090909), // Very dark card background
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)), // Subtle border from design
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
                  image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w800), maxLines: 1, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 4.h),
                    Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10.sp, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(condition, style: TextStyle(color: const Color(0xFF00E5FF), fontSize: 11.sp, fontWeight: FontWeight.w700)),
                        Text(' • $attribute', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11.sp)),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Qty: $qty', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11.sp)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(price, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w900, fontFamily: 'Inter')),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: isUp ? Colors.greenAccent : Colors.redAccent, size: 14.sp),
                                Text(changeAmt, style: TextStyle(color: isUp ? Colors.greenAccent : Colors.redAccent, fontSize: 10.sp, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletChartPainter extends CustomPainter {
  final Color chartColor;
  final List<double> normalizedPoints;
  final double? scrubX;

  _WalletChartPainter(this.chartColor, this.normalizedPoints, this.scrubX);

  @override
  void paint(Canvas canvas, Size size) {
    if (normalizedPoints.isEmpty) return;

    final paint = Paint()
      ..color = chartColor
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final fillPath = Path();
    
    final double stepX = size.width / (normalizedPoints.length - 1);
    
    double startY = size.height - (normalizedPoints[0] * size.height);
    path.moveTo(0, startY);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, startY);

    List<Offset> pointCoordinates = [Offset(0, startY)];

    for (int i = 1; i < normalizedPoints.length; i++) {
        final x = i * stepX;
        final y = size.height - (normalizedPoints[i] * size.height);
        pointCoordinates.add(Offset(x, y));
        
        final prevX = (i - 1) * stepX;
        final prevY = size.height - (normalizedPoints[i - 1] * size.height);
        
        // High-tension Trading-style Bezier Curve
        final cp1 = Offset(prevX + (x - prevX) * 0.55, prevY);
        final cp2 = Offset(prevX + (x - prevX) * 0.45, y);
        
        path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, x, y);
        fillPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, x, y);
    }
    
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          chartColor.withOpacity(0.3),
          chartColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
      
    canvas.drawPath(fillPath, gradientPaint);
    // Draw the path
    final ui.PathMetrics pathMetrics = path.computeMetrics();
    final Path animatedPath = Path();
    Offset? lastPoint;
    
    // We need an animationValue here too for consistency, but if not provided, we draw fully
    const double animVal = 1.0; 
    
    for (ui.PathMetric pathMetric in pathMetrics) {
      final double extractLength = pathMetric.length * animVal;
      animatedPath.addPath(
        pathMetric.extractPath(0.0, extractLength),
        Offset.zero,
      );
      lastPoint = pathMetric.getTangentForOffset(extractLength)?.position;
    }

    canvas.drawPath(animatedPath, paint);

    // ── Price Label at the end ───────────────────────────────────────────
    if (lastPoint != null) {
      final lastPriceValue = normalizedPoints.last * 1312.07; // Wallet scale
      final priceStr = lastPriceValue.toStringAsFixed(2);
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: priceStr,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12.sp,
            fontWeight: FontWeight.w900,
            fontFamily: 'Inter',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      double textX = lastPoint.dx + 8.w;
      double textY = lastPoint.dy - textPainter.height / 2;

      if (textX + textPainter.width > size.width) {
        textX = lastPoint.dx - textPainter.width - 8.w;
      }

      textPainter.paint(canvas, Offset(textX, textY));
    }

    double dotX;
    double dotY;

    if (scrubX != null) {
      dotX = scrubX!.clamp(0.0, size.width);
      
      int segmentIndex = (dotX / stepX).floor();
      if (segmentIndex < 0) segmentIndex = 0;
      if (segmentIndex >= pointCoordinates.length - 1) segmentIndex = pointCoordinates.length - 2;

      Offset p0 = pointCoordinates[segmentIndex];
      Offset p1 = pointCoordinates[segmentIndex + 1];
      
      double t = (dotX - p0.dx) / (p1.dx - p0.dx);
      t = t.clamp(0.0, 1.0);

      double cpX = p0.dx + (p1.dx - p0.dx) / 2;
      Offset cp1 = Offset(cpX, p0.dy);
      Offset cp2 = Offset(cpX, p1.dy);

      final u = 1 - t;
      final tt = t * t;
      final uu = u * u;
      final uuu = uu * u;
      final ttt = tt * t;

      dotY = uuu * p0.dy;
      dotY += 3 * uu * t * cp1.dy;
      dotY += 3 * u * tt * cp2.dy;
      dotY += ttt * p1.dy;
    } else {
      int defaultIndex = normalizedPoints.length - 1;
      dotX = pointCoordinates[defaultIndex].dx;
      dotY = pointCoordinates[defaultIndex].dy;
    }

    final dotPaint = Paint()..color = chartColor..style = PaintingStyle.fill;
    final dotShadow = Paint()..color = chartColor.withOpacity(0.5)..style = PaintingStyle.fill;
    
    Offset dotPos = Offset(dotX, dotY);
    
    if (scrubX != null) {
      final gridPaint = Paint()
        ..color = chartColor.withOpacity(0.5)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(dotPos.dx, 0), Offset(dotPos.dx, size.height), gridPaint);
    }
    
    canvas.drawCircle(dotPos, scrubX != null ? 24 : 16, dotShadow);
    canvas.drawCircle(dotPos, 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _WalletChartPainter oldDelegate) {
    return oldDelegate.chartColor != chartColor || 
           oldDelegate.normalizedPoints != normalizedPoints ||
           oldDelegate.scrubX != scrubX;
  }
}
