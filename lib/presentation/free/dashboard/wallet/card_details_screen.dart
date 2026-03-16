import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDetailsScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String price;
  final String changeAmt;
  final bool isUp;
  final String? imagePath;

  const CardDetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.changeAmt,
    required this.isUp,
    this.imagePath,
  });

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  String _selectedTimeFilter = '1M';
  double? _scrubX;

  // Mock Data for the chart mapped to filters
  final Map<String, List<double>> _chartDataByFilter = {
    '1D': [0.5, 0.55, 0.48, 0.6, 0.65, 0.58, 0.7, 0.75, 0.68, 0.8, 0.85, 0.9],
    '1W': [0.2, 0.25, 0.15, 0.3, 0.4, 0.35, 0.5, 0.45, 0.6, 0.7, 0.65, 0.8],
    '1M': [0.2, 0.25, 0.23, 0.4, 0.5, 0.48, 0.55, 0.7, 0.65, 0.8, 0.85, 0.8], // Default
    '6M': [0.1, 0.3, 0.2, 0.5, 0.4, 0.7, 0.6, 0.8, 0.75, 0.9, 0.8, 0.95],
    'ALL': [0.05, 0.1, 0.08, 0.2, 0.3, 0.25, 0.4, 0.35, 0.6, 0.7, 0.8, 0.9],
  };

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
      backgroundColor: const Color(0xFF0B0E11), // App dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Card Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, color: Colors.white, size: 20.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              _buildCardImage(),
              SizedBox(height: 32.h),
              _buildTitleAndPrice(),
              SizedBox(height: 24.h),
              _buildDetailsGrid(),
              SizedBox(height: 32.h),
              _buildHistoricalHeader(),
              SizedBox(height: 16.h),
              _buildChartSection(),
              SizedBox(height: 16.h),
              _buildXAxisLabels(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage() {
    return Center(
      child: Container(
        width: 250.w,
        height: 350.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            )
          ],
          image: widget.imagePath != null
              ? DecorationImage(
                  image: AssetImage(widget.imagePath!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: widget.imagePath == null
            ? Icon(
                Icons.image_outlined,
                color: Colors.white.withOpacity(0.2),
                size: 64.sp,
              )
            : null,
      ),
    );
  }

  Widget _buildTitleAndPrice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                widget.price,
                style: TextStyle(
                  color: const Color(0xFF00E5FF),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                widget.isUp ? Icons.trending_up : Icons.trending_down,
                color: widget.isUp ? Colors.greenAccent : Colors.redAccent,
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                '${widget.changeAmt} this month',
                style: TextStyle(
                  color: widget.isUp ? Colors.greenAccent : Colors.redAccent,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid() {
    final parts = widget.subtitle.split('\n');
    final setInfo = parts.isNotEmpty ? parts[0] : widget.subtitle;
    
    // Attempt to extract number and rarity from the subtitle if separated by bullet
    String numPart = '150/147';
    String rarityPart = 'Secret Rare';
    
    if (parts.length > 1) {
      final subParts = parts[1].split(' • ');
      if (subParts.length > 1) {
         rarityPart = subParts[0].trim();
         numPart = subParts[1].trim();
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGridItem('SET', setInfo),
            _buildGridItem('NUMBER', numPart),
            _buildGridItem('RARITY', rarityPart),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 80.w,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoricalHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Historical\nValue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          _buildTimeFilterInline(),
        ],
      ),
    );
  }

  Widget _buildTimeFilterInline() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ['1D', '1W', '1M', '6M', 'ALL'].map((t) {
          bool isSelected = _selectedTimeFilter == t;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTimeFilter = t;
                _scrubX = null;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF00E5FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                t,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF0B0E11) : Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChartSection() {
    return SizedBox(
      height: 180.h,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background grid lines
          Positioned.fill(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(height: 1, color: Colors.white.withOpacity(0.05)),
                   Container(height: 1, color: Colors.white.withOpacity(0.05)),
                   Container(height: 1, color: Colors.white.withOpacity(0.05)),
                ],
             ),
          ),
          Positioned.fill(
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
                child: CustomPaint(
                  painter: _CardDetailsChartPainter(
                    const Color(0xFF00E5FF),
                    _chartDataByFilter[_selectedTimeFilter] ?? _chartDataByFilter['1M']!,
                    _scrubX,
                    widget.price,
                    _selectedTimeFilter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXAxisLabels() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Sep 15', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10.sp)),
          Text('Sep 30', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10.sp)),
          Text('Oct 15', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10.sp)),
        ],
      ),
    );
  }
}

class _CardDetailsChartPainter extends CustomPainter {
  final Color chartColor;
  final List<double> normalizedPoints;
  final double? scrubX;
  final String currentPrice;
  final String filter;

  _CardDetailsChartPainter(this.chartColor, this.normalizedPoints, this.scrubX, this.currentPrice, this.filter);

  @override
  void paint(Canvas canvas, Size size) {
    if (normalizedPoints.isEmpty) return;

    final glowOuter = Paint()
      ..color = chartColor.withOpacity(0.2)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final paint = Paint()
      ..color = chartColor
      ..strokeWidth = 3.0
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

      final controlPointX = prevX + (x - prevX) / 2;

      path.cubicTo(controlPointX, prevY, controlPointX, y, x, y);
      fillPath.cubicTo(controlPointX, prevY, controlPointX, y, x, y);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          chartColor.withOpacity(0.25),
          chartColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, gradientPaint);
    canvas.drawPath(path, glowOuter);
    canvas.drawPath(path, paint);

    if (scrubX != null) {
      double dotX = scrubX!.clamp(0.0, size.width);

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

      double dotY = uuu * p0.dy;
      dotY += 3 * uu * t * cp1.dy;
      dotY += 3 * u * tt * cp2.dy;
      dotY += ttt * p1.dy;

      Offset dotPos = Offset(dotX, dotY);

      // Vertical line
      final gridPaint = Paint()
        ..color = Colors.white.withOpacity(0.4)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(dotPos.dx, 0), Offset(dotPos.dx, size.height), gridPaint);

      final dotShadow = Paint()..color = chartColor.withOpacity(0.4)..style = PaintingStyle.fill;
      final dotInner = Paint()..color = chartColor..style = PaintingStyle.fill;
      final dotCore = Paint()..color = const Color(0xFF0B0E11)..style = PaintingStyle.fill;

      canvas.drawCircle(dotPos, 12, dotShadow);
      canvas.drawCircle(dotPos, 6, dotInner);
      canvas.drawCircle(dotPos, 3, dotCore);
      
      // Calculate dynamic price based on y position interpolation
      double yValue = 1.0 - (dotY / size.height);
      double valMultiplier = 1.0;
      if (normalizedPoints.isNotEmpty && normalizedPoints.last != 0) {
        valMultiplier = yValue / normalizedPoints.last;
      }
      
      String displayPrice = currentPrice;
      try {
        final double basePrice = double.parse(currentPrice.replaceAll(RegExp(r'[^0-9.]'), ''));
        final double calculatedPrice = basePrice * valMultiplier;
        displayPrice = '\$${calculatedPrice.toStringAsFixed(2)}';
      } catch (e) {
        // Fallback to static price if parsing fails
      }

      // Tooltip
      _drawTooltip(canvas, size, dotX, dotY, displayPrice);
    }
  }
  
  void _drawTooltip(Canvas canvas, Size size, double x, double y, String priceText) {
     final textPainter = TextPainter(
        text: TextSpan(
           text: 'Oct 14: $priceText',
           style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
     );
     textPainter.layout();
     
     final double paddingH = 8.0;
     final double paddingV = 6.0;
     final double tooltipWidth = textPainter.width + paddingH * 2;
     final double tooltipHeight = textPainter.height + paddingV * 2;
     
     double tooltipX = x - tooltipWidth / 2;
     if (tooltipX < 0) tooltipX = 0;
     if (tooltipX + tooltipWidth > size.width) tooltipX = size.width - tooltipWidth;
     
     double tooltipY = 0; // Fixed at top
     
     final RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(tooltipX, tooltipY - 20, tooltipWidth, tooltipHeight),
        const Radius.circular(4),
     );
     
     canvas.drawRRect(rrect, Paint()..color = const Color(0xFF00E5FF));
     textPainter.paint(canvas, Offset(tooltipX + paddingH, tooltipY - 20 + paddingV));
  }

  @override
  bool shouldRepaint(covariant _CardDetailsChartPainter oldDelegate) {
    return oldDelegate.chartColor != chartColor ||
        oldDelegate.normalizedPoints != normalizedPoints ||
        oldDelegate.scrubX != scrubX ||
        oldDelegate.filter != filter;
  }
}
