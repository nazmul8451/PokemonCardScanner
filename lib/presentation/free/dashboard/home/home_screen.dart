import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/top_performer_model.dart';
import '../../../../core/models/market_volume_model.dart';
import '../../../../core/models/chart_data_model.dart';
import '../../../../core/models/wallet_model.dart';
import '../../../../controller/free/home_controller.dart';
import '../../../commonWidgets/common_widgets.dart';
import '../../../../presentation/commonWidgets/section_header.dart';
import '../professional/professional_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<String> _periods = ['1D', '7D', '1M', '3M', '6M', 'ALL'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>().fetchDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return _LoadingSkeleton();
            }
            if (controller.wallet == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return _DashboardBody(controller: controller, periods: _periods);
          },
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Loading Skeleton
// ─────────────────────────────────────────────────────────────────────────────

class _LoadingSkeleton extends StatefulWidget {
  @override
  State<_LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<_LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _shimmer = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, __) {
        final shimmerColor = AppColors.cardBackground.withOpacity(
          _shimmer.value + 0.3,
        );
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _skeletonBox(height: 40.h, width: 200.w, color: shimmerColor),
              const SizedBox(height: 20),
              _skeletonBox(height: 20.h, width: 120.w, color: shimmerColor),
              const SizedBox(height: 8),
              _skeletonBox(height: 40.h, width: 220.w, color: shimmerColor),
              const SizedBox(height: 8),
              _skeletonBox(height: 16.h, width: 180.w, color: shimmerColor),
              const SizedBox(height: 20),
              _skeletonBox(
                height: 130.h,
                width: double.infinity,
                color: shimmerColor,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  6,
                  (_) => _skeletonBox(
                    height: 28.h,
                    width: 36.w,
                    color: shimmerColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ..._skeletonCards(shimmerColor),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _skeletonCards(Color color) => List.generate(
    3,
    (_) => Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: _skeletonBox(height: 64.h, width: double.infinity, color: color),
    ),
  );

  Widget _skeletonBox({
    required double height,
    required double width,
    required Color color,
  }) => Container(
    height: height,
    width: width,
    margin: EdgeInsets.only(bottom: 4.h),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12.r),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Dashboard body (data-driven)
// ─────────────────────────────────────────────────────────────────────────────

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.controller, required this.periods});

  final HomeController controller;
  final List<String> periods;

  @override
  Widget build(BuildContext context) {
    final wallet = controller.wallet!;
    final chartData = controller.chartData!;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _TabRow()),
        SliverToBoxAdapter(child: _WalletSection(wallet: wallet)),
        SliverToBoxAdapter(
          child: _ChartSection(
            chartData: chartData,
            periods: periods,
            selectedPeriod: controller.selectedPeriod,
            onPeriodChanged: controller.changePeriod,
          ),
        ),
        // Top Performer
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'Top Performer',
            actionLabel: 'View All',
            onActionTap: () {},
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) =>
                _TopPerformerCard(item: controller.topPerformers[i]),
            childCount: controller.topPerformers.length,
          ),
        ),
        // Market Volume
        SliverToBoxAdapter(
          child: SectionHeader(
            title: 'Market Volume',
            actionLabel: 'Last 30 Days',
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => _MarketVolumeCard(item: controller.marketVolume[i]),
            childCount: controller.marketVolume.length,
          ),
        ),
        // Explore All Markets button
        SliverToBoxAdapter(child: _ExploreButton()),
        SliverToBoxAdapter(
          child: ProfessionalInsightsCard(
            margin: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

// ── Tab row ──────────────────────────────────────────────────────────────────

class _TabRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _Tab(label: 'Dashboard', isActive: true),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfessionalScreen(),
                ),
              );
            },
            child: _Tab(label: 'Professional', isActive: false, hasBadge: true),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.isActive,
    this.hasBadge = false,
  });
  final String label;
  final bool isActive;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: isActive
                  ? AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    )
                  : AppTextStyles.bodySmall.copyWith(fontSize: 12.sp),
            ),
            if (hasBadge) ...[
              SizedBox(width: 4.w),
              Icon(Icons.bolt_rounded, size: 14.sp, color: AppColors.primary),
            ],
          ],
        ),
        if (isActive)
          Container(
            margin: EdgeInsets.only(top: 4.h),
            height: 2.h,
            width: 72.w,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
      ],
    );
  }
}

// ── Wallet ────────────────────────────────────────────────────────────────────

class _WalletSection extends StatelessWidget {
  const _WalletSection({required this.wallet});
  final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Wallet ',
                style: AppTextStyles.bodySmall.copyWith(fontSize: 12.sp),
              ),
              Text(
                wallet.name,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontSize: 12.sp,
                ),
              ),
              const Spacer(),
              Text(
                wallet.currency,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                wallet.formattedBalance,
                style: AppTextStyles.displayLarge.copyWith(fontSize: 28.sp),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.remove_red_eye_outlined,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            wallet.formattedChange,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12.sp,
              color: wallet.isPositiveChange
                  ? AppColors.positive
                  : AppColors.negative,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Chart + period ────────────────────────────────────────────────────────────

class _ChartSection extends StatelessWidget {
  const _ChartSection({
    required this.chartData,
    required this.periods,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final ChartDataModel chartData;
  final List<String> periods;
  final String selectedPeriod;
  final Future<void> Function(String) onPeriodChanged;

  String _formattedDate() {
    final now = DateTime.now();
    final d = now.day.toString().padLeft(2, '0');
    final m = now.month.toString().padLeft(2, '0');
    final y = now.year;
    return '$d/$m/$y';
  }

  double _priceChange() {
    if (chartData.points.length < 2) return 0.0;
    final first = chartData.points.first;
    final last = chartData.points.last;
    if (first == 0) return 0.0;
    return ((last - first) / first) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final change = _priceChange();
    final changeText =
        (change >= 0 ? '+' : '') + change.toStringAsFixed(1) + '%';
    final isPositive = change >= 0;

    return Column(
      children: [
        SizedBox(
          height: 140.h,
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: CustomPaint(
                  key: ValueKey(chartData.period),
                  size: Size(double.infinity, 140.h),
                  painter: _ChartPainter(points: chartData.points),
                ),
              ),
              // ── Date + Price Change overlay ──────────────────────────────
              Positioned(
                top: 10.h,
                left: 16.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B0E11).withOpacity(0.82),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                      width: 0.8.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formattedDate(),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10.sp,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Price change ',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: changeText,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10.sp,
                                color: isPositive
                                    ? AppColors.accent
                                    : AppColors.negative,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: periods
                .map(
                  (p) => _PeriodButton(
                    label: p,
                    isActive: p == selectedPeriod,
                    onTap: () => onPeriodChanged(p),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.background : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ── Top Performer Card ────────────────────────────────────────────────────────

class _TopPerformerCard extends StatelessWidget {
  const _TopPerformerCard({required this.item});
  final TopPerformerModel item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          // Avatar – shows image when URL available, else colour box
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: item.imageUrl != null
                ? (item.imageUrl!.startsWith('assets/')
                      ? Image.asset(
                          item.imageUrl!,
                          width: 48.w,
                          height: 48.h,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          item.imageUrl!,
                          width: 48.w,
                          height: 48.h,
                          fit: BoxFit.cover,
                        ))
                : Container(
                    width: 48.w,
                    height: 48.h,
                    color: item.avatarColor.withOpacity(0.85),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 14.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  item.subtitle,
                  style: AppTextStyles.caption.copyWith(fontSize: 11.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.formattedValue,
                style: AppTextStyles.bodyMedium.copyWith(fontSize: 14.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                item.formattedChange,
                style:
                    (item.isPositive
                            ? AppTextStyles.positive
                            : AppTextStyles.negative)
                        .copyWith(fontSize: 13.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Market Volume Card ────────────────────────────────────────────────────────

class _MarketVolumeCard extends StatelessWidget {
  const _MarketVolumeCard({required this.item});
  final MarketVolumeModel item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          // Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: item.imageUrl != null
                ? (item.imageUrl!.startsWith('assets/')
                      ? Image.asset(
                          item.imageUrl!,
                          width: 52.w,
                          height: 52.h,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          item.imageUrl!,
                          width: 52.w,
                          height: 52.h,
                          fit: BoxFit.cover,
                        ))
                : Container(
                    width: 52.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: item.avatarColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: item.avatarColor.withOpacity(0.5),
                        width: 1.w,
                      ),
                    ),
                    child: Icon(
                      Icons.style_rounded,
                      color: item.avatarColor,
                      size: 26.sp,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: AppTextStyles.titleMedium.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 3.h),
                Text(
                  item.formattedSold,
                  style: AppTextStyles.caption.copyWith(fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.formattedVolume,
                style: AppTextStyles.titleMedium.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 3.h),
              Text(
                item.formattedAvg,
                style: AppTextStyles.caption.copyWith(fontSize: 11.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Explore All Markets button ────────────────────────────────────────────────

class _ExploreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.divider, width: 0.8.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Explore All Markets',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Chart Painter ─────────────────────────────────────────────────────────────

class _ChartPainter extends CustomPainter {
  const _ChartPainter({required this.points});
  final List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    // ── Outer glow (wide, soft) ───────────────────────────────────────────
    final glowPaintOuter = Paint()
      ..color = AppColors.accent.withOpacity(0.18)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    // ── Inner glow (tighter, brighter) ───────────────────────────────────
    final glowPaintInner = Paint()
      ..color = AppColors.accent.withOpacity(0.45)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // ── Crisp top line ───────────────────────────────────────────────────
    final linePaint = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.accent.withOpacity(0.35),
          AppColors.accent.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Convert normalised points to canvas coordinates
    final step = size.width / (points.length - 1);
    final offsets = List.generate(
      points.length,
      (i) => Offset(i * step, size.height * (1.0 - points[i])),
    );

    final path = _buildCurvedPath(offsets);

    // Gradient fill
    final fillPath = Path()..addPath(path, Offset.zero);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, gradientPaint);

    // Glow layers (drawn before the crisp line so line sits on top)
    canvas.drawPath(path, glowPaintOuter);
    canvas.drawPath(path, glowPaintInner);

    // Crisp line on top
    canvas.drawPath(path, linePaint);
  }

  Path _buildCurvedPath(List<Offset> pts) {
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = pts[i];
      final p1 = pts[i + 1];
      final mid = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      path.quadraticBezierTo(p0.dx, p0.dy, mid.dx, mid.dy);
    }
    path.lineTo(pts.last.dx, pts.last.dy);
    return path;
  }

  @override
  bool shouldRepaint(_ChartPainter old) => old.points != points;
}
