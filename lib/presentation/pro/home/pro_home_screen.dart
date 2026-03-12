import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProHomeScreen extends StatefulWidget {
  final VoidCallback? onProfileTap;

  const ProHomeScreen({super.key, this.onProfileTap});

  @override
  State<ProHomeScreen> createState() => _ProHomeScreenState();
}

class _ProHomeScreenState extends State<ProHomeScreen> {
  bool _isProfessionalTab = true;
  String _selectedTimeFilterCore = '6M';
  String _selectedTimeFilterPredict = '+3Y';
  double? _scrubX; // Track exact X pixel coordinate for smooth scrubbing

  // Mock data for the chart based on the selected time filter
  final Map<String, Map<String, dynamic>> _chartMockDataPredict = {
    '+1M': {'apri': '64,150.00 €', 'chiudi': '64,650.03 €', 'alto': '65,000.00 €', 'basso': '63,500.00 €', 'modifica': '0.78%', 'points': [0.5, 0.4, 0.6, 0.3, 0.5, 0.7, 0.8]},
    '+3M': {'apri': '62,000.00 €', 'chiudi': '64,650.03 €', 'alto': '65,200.00 €', 'basso': '61,000.00 €', 'modifica': '4.27%', 'points': [0.2, 0.3, 0.5, 0.4, 0.6, 0.7, 0.8]},
    '+6M': {'apri': '58,000.00 €', 'chiudi': '64,650.03 €', 'alto': '66,000.00 €', 'basso': '55,000.00 €', 'modifica': '11.46%', 'points': [0.1, 0.2, 0.4, 0.3, 0.6, 0.5, 0.8]},
    '+1Y': {'apri': '50,000.00 €', 'chiudi': '64,650.03 €', 'alto': '68,000.00 €', 'basso': '45,000.00 €', 'modifica': '29.30%', 'points': [0.8, 0.6, 0.4, 0.5, 0.7, 0.6, 0.8]},
    '+3Y': {'apri': '485,1 €', 'chiudi': '541,3 €', 'alto': '568,8 €', 'basso': '438,6 €', 'modifica': '11,59%', 'points': [0.2, 0.3, 0.4, 0.6, 0.8, 0.9, 1.0]},
    '+5Y': {'apri': '30,000.00 €', 'chiudi': '64,650.03 €', 'alto': '70,000.00 €', 'basso': '25,000.00 €', 'modifica': '115.5%', 'points': [0.1, 0.2, 0.1, 0.4, 0.6, 0.7, 0.8]},
  };

  final Map<String, Map<String, dynamic>> _chartMockDataCore = {
    '1D': {'apri': '64,150.00 €', 'chiudi': '64,650.03 €', 'alto': '65,000.00 €', 'basso': '63,500.00 €', 'modifica': '0.78%', 'points': [0.1, 0.2, 0.3, 0.1, 0.4, 0.5, 0.6]},
    '7D': {'apri': '62,000.00 €', 'chiudi': '64,650.03 €', 'alto': '65,200.00 €', 'basso': '61,000.00 €', 'modifica': '4.27%', 'points': [0.3, 0.2, 0.4, 0.5, 0.3, 0.6, 0.7]},
    '1M': {'apri': '58,000.00 €', 'chiudi': '64,650.03 €', 'alto': '66,000.00 €', 'basso': '55,000.00 €', 'modifica': '11.46%', 'points': [0.2, 0.1, 0.3, 0.6, 0.5, 0.7, 0.8]},
    '3M': {'apri': '50,000.00 €', 'chiudi': '64,650.03 €', 'alto': '68,000.00 €', 'basso': '45,000.00 €', 'modifica': '29.30%', 'points': [0.3, 0.4, 0.2, 0.5, 0.6, 0.4, 0.9]},
    '6M': {'apri': '485,1 €', 'chiudi': '541,3 €', 'alto': '568,8 €', 'basso': '438,6 €', 'modifica': '11,59%', 'points': [0.2, 0.3, 0.4, 0.55, 0.65, 0.7, 0.75]},
    'ALL': {'apri': '30,000.00 €', 'chiudi': '64,650.03 €', 'alto': '70,000.00 €', 'basso': '25,000.00 €', 'modifica': '115.5%', 'points': [0.1, 0.2, 0.4, 0.5, 0.7, 0.8, 1.0]},
  };

  @override
  Widget build(BuildContext context) {
    // Dynamic Colors based on active tab
    final primaryColor = _isProfessionalTab ? const Color(0xFFFFD700) : const Color(0xFF00E5FF); // Gold : Cyan

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: _buildTabs(primaryColor),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32.h),
                      _buildWalletHeader(primaryColor),
                      SizedBox(height: 24.h),
                      _buildChartSection(primaryColor),
                      SizedBox(height: 24.h),
                      _buildTimeFilter(),
                      SizedBox(height: 32.h),
                      _buildMarketVolumeHeader(),
                      SizedBox(height: 16.h),
                      _buildMarketCard('Pokémon', 'assets/images/pokemon.png', 'assets/images/Container.png', '1,300'),
                      SizedBox(height: 16.h),
                      _buildMarketCard('One Piece', 'assets/images/Container_1.png', 'assets/images/Container_1.png', '850'),
                      SizedBox(height: 16.h),
                      _buildMarketCard('Yu-Gi-Oh!', 'assets/images/Container_2.png', 'assets/images/Container_2.png', '620'),
                      SizedBox(height: 24.h),
                      _buildExploreButton(),
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

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           GestureDetector(
             onTap: widget.onProfileTap,
             child: Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5)),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ibrahim', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    Row(
                      children: [
                        Icon(Icons.diamond_rounded, color: const Color(0xFFFFD700), size: 12.sp),
                        SizedBox(width: 4.w),
                        Text('Professional', style: TextStyle(color: const Color(0xFFFFD700), fontSize: 11.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ],
                     ),
           ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search, color: Colors.white54, size: 24.sp)),
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_rounded, color: Colors.white54, size: 24.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(Color activeColor) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isProfessionalTab = false;
                  _scrubX = null; // Reset selection
                });
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h, right: 16.w),
                child: Text('Dashboard', style: TextStyle(color: !_isProfessionalTab ? Colors.white : Colors.white.withOpacity(0.4), fontSize: 18.sp, fontWeight: !_isProfessionalTab ? FontWeight.w800 : FontWeight.w600)),
              ),
            ),
            GestureDetector(
              onTap: () {
                 setState(() {
                  _isProfessionalTab = true;
                  _scrubX = null; // Reset selection
                });
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h, left: 16.w),
                child: Row(
                  children: [
                    Text('Professional', style: TextStyle(color: _isProfessionalTab ? Colors.white : Colors.white.withOpacity(0.4), fontSize: 18.sp, fontWeight: _isProfessionalTab ? FontWeight.w800 : FontWeight.w600)),
                    SizedBox(width: 4.w),
                    Icon(Icons.diamond_rounded, color: const Color(0xFFFFD700), size: 14.sp),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (!_isProfessionalTab) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Icon(Icons.search, color: Colors.white54, size: 20.sp),
              )
            ]
          ],
        ),
        Stack(
          children: [
            // Background line
            Container(width: double.infinity, height: 1.h, color: Colors.white.withOpacity(0.1)),
            // Active indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: _isProfessionalTab ? 115.w : 0,
              child: Container(width: 100.w, height: 2.h, color: activeColor),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildWalletHeader(Color activeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Wallet ', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                Text(_isProfessionalTab ? 'Predict' : 'Core', style: TextStyle(color: activeColor, fontSize: 14.sp, fontWeight: FontWeight.w800)),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(4.r)),
              child: Text('EUR', style: TextStyle(color: Colors.blueAccent, fontSize: 10.sp, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text('€64,650.03', style: TextStyle(color: Colors.white, fontSize: 34.sp, fontWeight: FontWeight.w900, letterSpacing: -1)),
            SizedBox(width: 12.w),
            Icon(Icons.visibility_outlined, color: Colors.white.withOpacity(0.3), size: 22.sp),
            const Spacer(),
            if (_isProfessionalTab) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: activeColor.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.diamond_outlined, color: activeColor, size: 12.sp),
                  SizedBox(width: 4.w),
                  Text('PREDICT', style: TextStyle(color: activeColor, fontSize: 8.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
                ],
              ),
            ),
            ]
          ],
        ),
        SizedBox(height: 4.h),
        Text('+€10,000.00 in the last 30 days', style: TextStyle(color: const Color(0xFF00FF87), fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildChartSection(Color chartColor) {
    final currentDataMap = _isProfessionalTab ? _chartMockDataPredict : _chartMockDataCore;
    final currentFilter = _isProfessionalTab ? _selectedTimeFilterPredict : _selectedTimeFilterCore;
    final currentData = currentDataMap[currentFilter]!;
    final List<double> chartPoints = currentData['points'];

    return SizedBox(
      height: 250.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -20.w,
            right: -20.w, // bleed to edge
            bottom: 0,
            top: 20.h,
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
                color: Colors.transparent, // Capture gestures across full area
                child: CustomPaint(
                  painter: _DashboardChartPainter(
                    chartColor,
                    chartPoints,
                    _isProfessionalTab,
                    _scrubX,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 10.h,
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E).withOpacity(0.85),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChartRow('Apri:', currentData['apri']),
                  SizedBox(height: 12.h),
                  _buildChartRow('Chiudi:', currentData['chiudi']),
                  SizedBox(height: 12.h),
                  _buildChartRow('Alto:', currentData['alto']),
                  SizedBox(height: 12.h),
                  _buildChartRow('Basso:', currentData['basso']),
                  SizedBox(height: 12.h),
                  _buildChartRow('Modifica:', currentData['modifica'], color: chartColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 80.w, child: Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13.sp, fontWeight: FontWeight.w500))),
        Text(value, style: TextStyle(color: color ?? Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w800)),
      ],
    );
  }

  void _updateScrubPosition(double localX) {
    if (_scrubX != localX) {
      setState(() {
        _scrubX = localX; // Do not hard clamp here; let painter clamp against exact size
      });
    }
  }

  Widget _buildTimeFilter() {
    final filters = _isProfessionalTab 
        ? ['+1M', '+3M', '+6M', '+1Y', '+3Y', '+5Y']
        : ['1D', '7D', '1M', '3M', '6M', 'ALL'];
        
    final selectedFilter = _isProfessionalTab ? _selectedTimeFilterPredict : _selectedTimeFilterCore;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: filters.map((t) {
        bool isSelected = t == selectedFilter;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (_isProfessionalTab) {
                _selectedTimeFilterPredict = t;
              } else {
                _selectedTimeFilterCore = t;
              }
              _scrubX = null; // Reset selection
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(t, style: TextStyle(color: isSelected ? Colors.black : Colors.white.withOpacity(0.4), fontSize: 12.sp, fontWeight: FontWeight.w800)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMarketVolumeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Market Volume', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
        Text('Last 30 Days', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildMarketCard(String name, String iconPath, String bgPath, String sold) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: AssetImage(bgPath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage(iconPath), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(name, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800)),
                ),
                Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.4), size: 24.sp),
              ],
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(child: _buildMarketStat('VOLUME', '€120K')),
                Container(width: 1, height: 30.h, color: Colors.white.withOpacity(0.1)),
                Expanded(child: _buildMarketStat('SOLD', sold)),
                Container(width: 1, height: 30.h, color: Colors.white.withOpacity(0.1)),
                Expanded(child: _buildMarketStat('AVG PRICE', '€200')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarketStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10.sp, fontWeight: FontWeight.w800, letterSpacing: 1)),
        SizedBox(height: 8.h),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildExploreButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Explore All Markets', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13.sp, fontWeight: FontWeight.w600)),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.6), size: 12.sp),
          ],
        ),
      ),
    );
  }
}

class _DashboardChartPainter extends CustomPainter {
  final Color chartColor;
  final List<double> normalizedPoints;
  final bool isStraightLine;
  final double? scrubX;

  _DashboardChartPainter(this.chartColor, this.normalizedPoints, this.isStraightLine, this.scrubX);

  @override
  void paint(Canvas canvas, Size size) {
    if (normalizedPoints.isEmpty) return;

    final paint = Paint()
      ..color = chartColor
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final fillPath = Path();
    
    final double stepX = size.width / (normalizedPoints.length - 1);
    
    // Start at bottom left then go to first point
    double startY = size.height - (normalizedPoints[0] * size.height);
    path.moveTo(0, startY);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, startY);

    // Lists to store calculated segments for exact scrubbing interpolation later
    List<Offset> pointCoordinates = [Offset(0, startY)];

    for (int i = 1; i < normalizedPoints.length; i++) {
        final x = i * stepX;
        final y = size.height - (normalizedPoints[i] * size.height);
        pointCoordinates.add(Offset(x, y));
        
        if (isStraightLine) {
           path.lineTo(x, y);
           fillPath.lineTo(x, y);
        } else {
           // Smooth Bezier Curve for Dashboard/Core
           final prevX = (i - 1) * stepX;
           final prevY = size.height - (normalizedPoints[i - 1] * size.height);
           
           final controlPointX = prevX + (x - prevX) / 2;
           
           path.cubicTo(controlPointX, prevY, controlPointX, y, x, y);
           fillPath.cubicTo(controlPointX, prevY, controlPointX, y, x, y);
        }
    }
    
    // Draw Gradient Fill
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
    
    // Draw Stroke Line
    canvas.drawPath(path, paint);

    // Calculate Dot Position
    double dotX;
    double dotY;

    if (scrubX != null) {
      dotX = scrubX!.clamp(0.0, size.width);
      
      // Interpolate exact Y value
      int segmentIndex = (dotX / stepX).floor();
      if (segmentIndex < 0) segmentIndex = 0;
      if (segmentIndex >= pointCoordinates.length - 1) segmentIndex = pointCoordinates.length - 2;

      Offset p0 = pointCoordinates[segmentIndex];
      Offset p1 = pointCoordinates[segmentIndex + 1];
      
      double t = (dotX - p0.dx) / (p1.dx - p0.dx);
      t = t.clamp(0.0, 1.0);

      if (isStraightLine) {
        // Linear interpolation
        dotY = p0.dy + (p1.dy - p0.dy) * t;
      } else {
        // Cubic bezier interpolation (approximation matching the path.cubicTo used above)
        double cpX = p0.dx + (p1.dx - p0.dx) / 2;
        Offset cp1 = Offset(cpX, p0.dy);
        Offset cp2 = Offset(cpX, p1.dy);

        // Standard bezier formula
        final u = 1 - t;
        final tt = t * t;
        final uu = u * u;
        final uuu = uu * u;
        final ttt = tt * t;

        dotY = uuu * p0.dy;
        dotY += 3 * uu * t * cp1.dy;
        dotY += 3 * u * tt * cp2.dy;
        dotY += ttt * p1.dy;
      }
    } else {
      // Default position (e.g., index 3 out of 7)
      int defaultIndex = normalizedPoints.length > 3 ? 3 : normalizedPoints.length - 1;
      dotX = pointCoordinates[defaultIndex].dx;
      dotY = pointCoordinates[defaultIndex].dy;
    }

    final dotPaint = Paint()..color = chartColor..style = PaintingStyle.fill;
    final dotShadow = Paint()..color = chartColor.withOpacity(0.4)..style = PaintingStyle.fill;
    
    Offset dotPos = Offset(dotX, dotY);
    
    // Vertical line behind dot
    final gridPaint = Paint()
      ..color = chartColor.withOpacity(0.5) // Brighter line
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(dotPos.dx, 0), Offset(dotPos.dx, size.height), gridPaint);
    
    // Draw Dot
    canvas.drawCircle(dotPos, scrubX != null ? 24 : 16, dotShadow); 
    canvas.drawCircle(dotPos, 5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _DashboardChartPainter oldDelegate) {
    return oldDelegate.chartColor != chartColor || 
           oldDelegate.normalizedPoints != normalizedPoints ||
           oldDelegate.isStraightLine != isStraightLine ||
           oldDelegate.scrubX != scrubX;
  }
}
