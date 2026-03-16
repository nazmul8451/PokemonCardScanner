import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

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
  String? _scrubPrice; // Dynamically displayed price when scrubbing
  String? _scrubDate; // Dynamically displayed date when scrubbing
  String? _scrubChange; // Dynamically displayed change when scrubbing
  bool _scrubIsPositive = true;

  // Mock data for the chart based on the selected time filter
  final Map<String, Map<String, dynamic>> _chartMockDataPredict = {
    '+1M': {
      'apri': '64,150.00 €',
      'chiudi': '64,650.03 €',
      'alto': '65,000.00 €',
      'basso': '63,500.00 €',
      'modifica': '0.78%',
      'points': [0.5, 0.4, 0.6, 0.3, 0.5, 0.7, 0.8],
    },
    '+3M': {
      'apri': '62,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '65,200.00 €',
      'basso': '61,000.00 €',
      'modifica': '4.27%',
      'points': [0.2, 0.3, 0.5, 0.4, 0.6, 0.7, 0.8],
    },
    '+6M': {
      'apri': '58,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '66,000.00 €',
      'basso': '55,000.00 €',
      'modifica': '11.46%',
      'points': [0.1, 0.2, 0.4, 0.3, 0.6, 0.5, 0.8],
    },
    '+1Y': {
      'apri': '50,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '68,000.00 €',
      'basso': '45,000.00 €',
      'modifica': '29.30%',
      'points': [0.8, 0.6, 0.4, 0.5, 0.7, 0.6, 0.8],
    },
    '+3Y': {
      'apri': '485,1 €',
      'chiudi': '541,3 €',
      'alto': '568,8 €',
      'basso': '438,6 €',
      'modifica': '11,59%',
      'points': [0.2, 0.3, 0.4, 0.6, 0.8, 0.9, 1.0],
    },
    '+5Y': {
      'apri': '30,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '70,000.00 €',
      'basso': '25,000.00 €',
      'modifica': '115.5%',
      'points': [0.1, 0.2, 0.1, 0.4, 0.6, 0.7, 0.8],
    },
  };

  final Map<String, Map<String, dynamic>> _chartMockDataCore = {
    '1D': {
      'apri': '64,150.00 €',
      'chiudi': '64,650.03 €',
      'alto': '65,000.00 €',
      'basso': '63,500.00 €',
      'modifica': '0.78%',
      'points': [0.1, 0.2, 0.3, 0.1, 0.4, 0.5, 0.6],
    },
    '7D': {
      'apri': '62,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '65,200.00 €',
      'basso': '61,000.00 €',
      'modifica': '4.27%',
      'points': [0.3, 0.2, 0.4, 0.5, 0.3, 0.6, 0.7],
    },
    '1M': {
      'apri': '58,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '66,000.00 €',
      'basso': '55,000.00 €',
      'modifica': '11.46%',
      'points': [0.2, 0.1, 0.3, 0.6, 0.5, 0.7, 0.8],
    },
    '3M': {
      'apri': '50,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '68,000.00 €',
      'basso': '45,000.00 €',
      'modifica': '29.30%',
      'points': [0.3, 0.4, 0.2, 0.5, 0.6, 0.4, 0.9],
    },
    '6M': {
      'apri': '485,1 €',
      'chiudi': '541,3 €',
      'alto': '568,8 €',
      'basso': '438,6 €',
      'modifica': '11,59%',
      'points': [0.2, 0.3, 0.4, 0.55, 0.65, 0.7, 0.75],
    },
    'ALL': {
      'apri': '30,000.00 €',
      'chiudi': '64,650.03 €',
      'alto': '70,000.00 €',
      'basso': '25,000.00 €',
      'modifica': '115.5%',
      'points': [0.1, 0.2, 0.4, 0.5, 0.7, 0.8, 1.0],
    },
  };

  double _parseValue(String val) {
    String s = val.replaceAll('€', '').trim();
    if (s.contains(',') && s.contains('.')) {
      s = s.replaceAll(',', '');
    } else if (s.contains(',')) {
      s = s.replaceAll(',', '.');
    }
    s = s.replaceAll('%', '').trim();
    return double.tryParse(s) ?? 0.0;
  }

  String _formatValue(double val, String original) {
    bool hasEuroSymbolEnd = original.endsWith('€');
    bool hasEuroSymbolStart = original.startsWith('€');
    bool hasSpace = original.contains(' €');

    String formatted;
    if (original.contains(',') && original.contains('.')) {
      formatted = val.toStringAsFixed(2);
      List<String> parts = formatted.split('.');
      String intPart = parts[0];
      bool isNegative = intPart.startsWith('-');
      if (isNegative) intPart = intPart.substring(1);

      String res = '';
      for (int i = 0; i < intPart.length; i++) {
        if (i > 0 && i % 3 == 0) {
          res = ',' + res;
        }
        res = intPart[intPart.length - 1 - i] + res;
      }
      if (isNegative) res = '-' + res;
      formatted = res + '.' + parts[1];
    } else if (original.contains(',')) {
      formatted = val.toStringAsFixed(1).replaceAll('.', ',');
    } else {
      formatted = val.toStringAsFixed(2);
    }

    if (hasEuroSymbolEnd) {
      return formatted + (hasSpace ? ' €' : '€');
    } else if (hasEuroSymbolStart) {
      return '€' + formatted;
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Colors based on active tab
    final primaryColor = _isProfessionalTab
        ? const Color(0xFFFFD700)
        : const Color(0xFF00E5FF); // Gold : Cyan

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
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
                      _buildMarketCard(
                        'Pokémon',
                        'assets/images/pokemon.png',
                        'assets/images/Container.png',
                        '1,300',
                      ),
                      SizedBox(height: 16.h),
                      _buildMarketCard(
                        'One Piece',
                        'assets/images/Container_1.png',
                        'assets/images/Container_1.png',
                        '850',
                      ),
                      SizedBox(height: 16.h),
                      _buildMarketCard(
                        'Yu-Gi-Oh!',
                        'assets/images/Container_2.png',
                        'assets/images/Container_2.png',
                        '620',
                      ),
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
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    color: !_isProfessionalTab
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                    fontSize: 18.sp,
                    fontWeight: !_isProfessionalTab
                        ? FontWeight.w800
                        : FontWeight.w600,
                  ),
                ),
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
                    Text(
                      'Professional',
                      style: TextStyle(
                        color: _isProfessionalTab
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        fontSize: 18.sp,
                        fontWeight: _isProfessionalTab
                            ? FontWeight.w800
                            : FontWeight.w600,
                        shadows: _isProfessionalTab
                            ? [
                                Shadow(
                                  color: Colors.white.withOpacity(0.6),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.diamond_rounded,
                      color: const Color(0xFFFFD700),
                      size: 14.sp,
                      shadows: _isProfessionalTab
                          ? [
                              Shadow(
                                color: const Color(0xFFFFD700).withOpacity(0.8),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (!_isProfessionalTab) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Icon(Icons.search, color: Colors.white54, size: 20.sp),
              ),
            ],
          ],
        ),
        Stack(
          children: [
            // Background line
            Container(
              width: double.infinity,
              height: 1.h,
              color: Colors.white.withOpacity(0.1),
            ),
            // Active indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: _isProfessionalTab ? 115.w : 0,
              child: Container(
                width: 100.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: activeColor,
                  boxShadow: [
                    BoxShadow(
                      color: activeColor.withOpacity(0.8),
                      blurRadius: 10,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletHeader(Color activeColor) {
    final bool isScrubbing = _scrubX != null;
    final String displayPrice = isScrubbing
        ? (_scrubPrice ?? '€64,650.03')
        : '€64,650.03';
    final String displayChange = isScrubbing
        ? (_scrubChange ?? '+€10,000.00 in the last 30 days')
        : '+€10,000.00 in the last 30 days';
    final bool changePositive = isScrubbing ? _scrubIsPositive : true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: isScrubbing
                  ? Text(
                      _scrubDate ?? '',
                      key: ValueKey(_scrubDate),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Row(
                      key: const ValueKey('title'),
                      children: [
                        Text(
                          'Wallet ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _isProfessionalTab ? 'Predict' : 'Core',
                          style: TextStyle(
                            color: activeColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'EUR',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // ── Main price ─────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: price + eye icon
            Row(
              children: [
                Text(
                  displayPrice,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                if (!isScrubbing) ...[
                  SizedBox(width: 12.w),
                  Icon(
                    Icons.visibility_outlined,
                    color: Colors.white.withOpacity(0.3),
                    size: 22.sp,
                  ),
                ],
              ],
            ),
            // Right: PREDICT badge
            if (_isProfessionalTab && !isScrubbing)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: activeColor.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.diamond_outlined,
                      color: activeColor,
                      size: 12.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'PREDICT',
                      style: TextStyle(
                        color: activeColor,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 4.h),
        // ── Change text (keyed with color to prevent red flash) ─────────────
        Text(
          displayChange,
          style: TextStyle(
            color: isScrubbing
                ? (changePositive
                      ? const Color(0xFF00FF87)
                      : const Color(0xFFFF4C4C))
                : const Color(0xFF00FF87),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection(Color chartColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentDataMap = _isProfessionalTab
            ? _chartMockDataPredict
            : _chartMockDataCore;
        final currentFilter = _isProfessionalTab
            ? _selectedTimeFilterPredict
            : _selectedTimeFilterCore;
        final currentData = currentDataMap[currentFilter]!;
        final List<double> chartPoints = currentData['points'];

        String displayApri = currentData['apri'];
        String displayChiudi = currentData['chiudi'];
        String displayAlto = currentData['alto'];
        String displayBasso = currentData['basso'];
        String displayModifica = currentData['modifica'];

        if (_scrubX != null && chartPoints.isNotEmpty) {
          final chartWidth = constraints.maxWidth + 40.w;
          final stepX = chartWidth / (chartPoints.length - 1);
          final dotX = _scrubX!.clamp(0.0, chartWidth);

          int segmentIndex = (dotX / stepX).floor();
          if (segmentIndex < 0) segmentIndex = 0;
          if (segmentIndex >= chartPoints.length - 1)
            segmentIndex = chartPoints.length - 2;

          final p0 = chartPoints[segmentIndex];
          final p1 = chartPoints[segmentIndex + 1];

          double t = (dotX - segmentIndex * stepX) / stepX;
          t = t.clamp(0.0, 1.0);

          double currentPt;
          if (_isProfessionalTab) {
            currentPt = p0 + (p1 - p0) * t;
          } else {
            final u = 1 - t;
            final tt = t * t;
            final uu = u * u;
            final uuu = uu * u;
            final ttt = tt * t;
            currentPt = (uuu + 3 * uu * t) * p0 + (3 * u * tt + ttt) * p1;
          }

          double minPt = chartPoints.reduce(math.min);
          double maxPt = chartPoints.reduce(math.max);
          double valAlto = _parseValue(displayAlto);
          double valBasso = _parseValue(displayBasso);
          double range = valAlto - valBasso;
          double ptRange = maxPt - minPt;

          double currentPrice;
          if (ptRange > 0) {
            double normalizedPt = (currentPt - minPt) / ptRange;
            currentPrice = valBasso + range * normalizedPt;
          } else {
            currentPrice = _parseValue(displayChiudi);
          }

          displayChiudi = _formatValue(currentPrice, displayChiudi);

          double valApri = _parseValue(displayApri);
          if (valApri > 0) {
            double pctChange = ((currentPrice - valApri) / valApri) * 100;
            String pctStr = pctChange.toStringAsFixed(2);
            if (displayModifica.contains(',')) {
              pctStr = pctStr.replaceAll('.', ',');
            }
            displayModifica = pctStr + '%';
          }
        }

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
                    _updateScrubPosition(details.localPosition.dx, constraints);
                  },
                  onTapDown: (details) {
                    _updateScrubPosition(details.localPosition.dx, constraints);
                  },
                  onHorizontalDragEnd: (_) {
                    setState(() {
                      _scrubX = null;
                      _scrubPrice = null;
                      _scrubDate = null;
                      _scrubChange = null;
                      _scrubIsPositive = true;
                    });
                  },
                  onTapUp: (_) {
                    setState(() {
                      _scrubX = null;
                      _scrubPrice = null;
                      _scrubDate = null;
                      _scrubChange = null;
                      _scrubIsPositive = true;
                    });
                  },
                  child: Container(
                    color:
                        Colors.transparent, // Capture gestures across full area
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
                      _buildChartRow('Apri:', displayApri),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              'Chiudi:',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            _scrubX != null ? (_scrubPrice ?? displayChiudi) : displayChiudi,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _buildChartRow('Alto:', displayAlto),
                      SizedBox(height: 12.h),
                      _buildChartRow('Basso:', displayBasso),
                      SizedBox(height: 12.h),
                      Divider(color: Colors.white.withOpacity(0.1), height: 1),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              'Modifica:',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            _scrubX != null && _scrubChange != null
                                ? _scrubChange!.split('  ').last
                                : displayModifica,
                            style: TextStyle(
                              color: chartColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  Widget _buildChartRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color ?? Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  void _updateScrubPosition(double localX, BoxConstraints constraints) {
    if (_scrubX == localX) return;

    final currentDataMap = _isProfessionalTab
        ? _chartMockDataPredict
        : _chartMockDataCore;
    final currentFilter = _isProfessionalTab
        ? _selectedTimeFilterPredict
        : _selectedTimeFilterCore;
    final currentData = currentDataMap[currentFilter]!;
    final List<double> chartPoints = currentData['points'];
    final String baseApri = currentData['apri'];
    final String baseAlto = currentData['alto'];
    final String baseBasso = currentData['basso'];
    final String baseChiudi = currentData['chiudi'];

    // Compute chart width (same bleed logic as painter)
    final chartWidth = constraints.maxWidth + 40.w;
    final stepX = chartWidth / (chartPoints.length - 1);
    final dotX = localX.clamp(0.0, chartWidth);

    // Which segment
    int segIdx = (dotX / stepX).floor().clamp(0, chartPoints.length - 2);
    double t = ((dotX - segIdx * stepX) / stepX).clamp(0.0, 1.0);
    final p0 = chartPoints[segIdx];
    final p1 = chartPoints[segIdx + 1];
    final currentPt = _isProfessionalTab
        ? p0 + (p1 - p0) * t
        : _cubicInterp(p0, p1, t);

    // Map normalised chart value → price
    final minPt = chartPoints.reduce(math.min);
    final maxPt = chartPoints.reduce(math.max);
    final valAlto = _parseValue(baseAlto);
    final valBasso = _parseValue(baseBasso);
    final valApri = _parseValue(baseApri);
    final ptRange = maxPt - minPt;
    double currentPrice;
    if (ptRange > 0) {
      currentPrice =
          valBasso + (valAlto - valBasso) * ((currentPt - minPt) / ptRange);
    } else {
      currentPrice = _parseValue(baseChiudi);
    }

    // Format price (manual comma insertion — no regex escape issues)
    final priceStr = _formatPrice(currentPrice);

    // Compute change vs open
    double pctChange = valApri > 0
        ? ((currentPrice - valApri) / valApri) * 100
        : 0;
    double absChange = currentPrice - valApri;
    bool isPos = absChange >= 0;
    final changeStr =
        '${isPos ? '+' : ''}€${absChange.abs().toStringAsFixed(2)}  ${isPos ? '+' : ''}${pctChange.toStringAsFixed(2)}%';

    // Compute date label
    final dateStr = _dateForIndex(segIdx, chartPoints.length, currentFilter);

    setState(() {
      _scrubX = localX;
      _scrubPrice = priceStr;
      _scrubChange = changeStr;
      _scrubDate = dateStr;
      _scrubIsPositive = isPos;
    });
  }

  /// Formats a double as €X,XXX.XX without regex to avoid escape issues.
  String _formatPrice(double price) {
    final raw = price.toStringAsFixed(2);
    final parts = raw.split('.');
    final intPart = parts[0];
    final dec = parts.length > 1 ? parts[1] : '00';
    final buf = StringBuffer();
    final len = intPart.length;
    for (int i = 0; i < len; i++) {
      if (i > 0 && (len - i) % 3 == 0) buf.write(',');
      buf.write(intPart[i]);
    }
    return '\u20ac${buf.toString()}.$dec';
  }

  double _cubicInterp(double p0, double p1, double t) {
    final u = 1 - t;
    return (u * u * u + 3 * u * u * t) * p0 + (3 * u * t * t + t * t * t) * p1;
  }

  String _dateForIndex(int segIdx, int totalPts, String filter) {
    final now = DateTime.now();
    Duration span;
    switch (filter) {
      case '1D':
        span = const Duration(days: 1);
        break;
      case '7D':
        span = const Duration(days: 7);
        break;
      case '1M':
      case '+1M':
        span = const Duration(days: 30);
        break;
      case '3M':
      case '+3M':
        span = const Duration(days: 90);
        break;
      case '6M':
      case '+6M':
        span = const Duration(days: 180);
        break;
      case '1Y':
      case '+1Y':
        span = const Duration(days: 365);
        break;
      case '+3Y':
        span = const Duration(days: 1095);
        break;
      case '+5Y':
        span = const Duration(days: 1825);
        break;
      default:
        span = const Duration(days: 180);
    }
    final start = now.subtract(span);
    final ratio = totalPts > 1 ? segIdx / (totalPts - 1) : 0.0;
    final dt = start.add(
      Duration(milliseconds: (span.inMilliseconds * ratio).round()),
    );
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    return '$d/$m/${dt.year}';
  }

  Widget _buildTimeFilter() {
    final filters = _isProfessionalTab
        ? ['+1M', '+3M', '+6M', '+1Y', '+3Y', '+5Y']
        : ['1D', '7D', '1M', '3M', '6M', 'ALL'];

    final selectedFilter = _isProfessionalTab
        ? _selectedTimeFilterPredict
        : _selectedTimeFilterCore;

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
            child: Text(
              t,
              style: TextStyle(
                color: isSelected
                    ? Colors.black
                    : Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMarketVolumeHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Market Volume',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'Last 30 Days',
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildMarketCard(
    String name,
    String iconPath,
    String bgPath,
    String sold,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1C),
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: AssetImage(bgPath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
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
                    image: DecorationImage(
                      image: AssetImage(iconPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.white.withOpacity(0.4),
                  size: 24.sp,
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(child: _buildMarketStat('VOLUME', '€120K')),
                Container(
                  width: 1,
                  height: 30.h,
                  color: Colors.white.withOpacity(0.1),
                ),
                Expanded(child: _buildMarketStat('SOLD', sold)),
                Container(
                  width: 1,
                  height: 30.h,
                  color: Colors.white.withOpacity(0.1),
                ),
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
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 10.sp,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
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
            Text(
              'Explore All Markets',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withOpacity(0.6),
              size: 12.sp,
            ),
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

  _DashboardChartPainter(
    this.chartColor,
    this.normalizedPoints,
    this.isStraightLine,
    this.scrubX,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (normalizedPoints.isEmpty) return;

    // ── Glow paints ────────────────────────────────────────────────────────
    final glowOuter = Paint()
      ..color = chartColor.withOpacity(0.35) // Increased glow brightness
      ..strokeWidth = 18 // Increased glow width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16); // More blur

    final glowInner = Paint()
      ..color = chartColor.withOpacity(0.75) // Increased glow brightness
      ..strokeWidth = 6 // Increased inner glow width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

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
        colors: [chartColor.withOpacity(0.3), chartColor.withOpacity(0.0)],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, gradientPaint);

    // Draw glow layers then crisp line on top
    canvas.drawPath(path, glowOuter);
    canvas.drawPath(path, glowInner);
    canvas.drawPath(path, paint);

    // Calculate Dot Position
    double dotX;
    double dotY;

    if (scrubX != null) {
      dotX = scrubX!.clamp(0.0, size.width);

      // Interpolate exact Y value
      int segmentIndex = (dotX / stepX).floor();
      if (segmentIndex < 0) segmentIndex = 0;
      if (segmentIndex >= pointCoordinates.length - 1)
        segmentIndex = pointCoordinates.length - 2;

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
      int defaultIndex = normalizedPoints.length > 3
          ? 3
          : normalizedPoints.length - 1;
      dotX = pointCoordinates[defaultIndex].dx;
      dotY = pointCoordinates[defaultIndex].dy;
    }

    final dotPaint = Paint()
      ..color = chartColor
      ..style = PaintingStyle.fill;
    final dotShadow = Paint()
      ..color = chartColor.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    Offset dotPos = Offset(dotX, dotY);

    // Vertical line behind dot
    final gridPaint = Paint()
      ..color = chartColor
          .withOpacity(0.5) // Brighter line
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(dotPos.dx, 0),
      Offset(dotPos.dx, size.height),
      gridPaint,
    );

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
