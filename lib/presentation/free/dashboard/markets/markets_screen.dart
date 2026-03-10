import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../controller/free/markets_controller.dart';
import '../../../../core/models/market_volume_model.dart';
import '../../../../core/models/trending_item_model.dart';
import '../../../commonWidgets/app_card.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MarketsController>().fetchMarketsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<MarketsController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _MarketsBody(controller: controller);
          },
        ),
      ),
    );
  }
}

class _MarketsBody extends StatelessWidget {
  const _MarketsBody({required this.controller});
  final MarketsController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _AppBar()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: AppColors.accent,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Market Volumes',
                  style: AppTextStyles.titleLarge.copyWith(fontSize: 22.sp),
                ),
                const Spacer(),
                Text(
                  '30D ANALYSIS',
                  style: AppTextStyles.caption.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) =>
                _MarketVolumeCard(item: controller.marketVolumes[i]),
            childCount: controller.marketVolumes.length,
          ),
        ),
        SliverToBoxAdapter(child: _ProfessionalInsightsCard()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 16.h),
            child: Row(
              children: [
                Icon(
                  Icons.whatshot_rounded,
                  color: AppColors.negative,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Trending Now',
                  style: AppTextStyles.titleLarge.copyWith(fontSize: 22.sp),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) => _TrendingCard(item: controller.trendingItems[i]),
            childCount: controller.trendingItems.length,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 32.h)),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider),
            ),
            child: Center(
              child: Text(
                'F',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Markets',
                style: AppTextStyles.titleMedium.copyWith(fontSize: 16.sp),
              ),
              Text(
                'Free Account',
                style: AppTextStyles.caption.copyWith(fontSize: 11.sp),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.textSecondary,
              size: 24.sp,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textSecondary,
                  size: 24.sp,
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: AppColors.negative,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MarketVolumeCard extends StatelessWidget {
  const _MarketVolumeCard({required this.item});
  final MarketVolumeModel item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: item.imageUrl != null
                ? Image.asset(
                    item.imageUrl!,
                    width: 52.w,
                    height: 52.h,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 52.w,
                    height: 52.h,
                    color: item.avatarColor.withOpacity(0.2),
                    child: Icon(
                      Icons.style_rounded,
                      color: item.avatarColor,
                      size: 26.sp,
                    ),
                  ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: AppTextStyles.titleMedium.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 4.h),
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
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: AppColors.positive,
                    size: 12.sp,
                  ),
                  Text(
                    ' 12.5%',
                    style: AppTextStyles.positive.copyWith(fontSize: 11.sp),
                  ),
                ],
              ),
              Text(
                item.formattedAvg,
                style: AppTextStyles.caption.copyWith(fontSize: 10.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfessionalInsightsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      padding: EdgeInsets.all(20.r),
      color: Colors.transparent,
      border: Border.all(
        color: const Color(0xFFFFD700).withOpacity(0.3),
        width: 1.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A1A),
              const Color(0xFFFFD700).withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.diamond_outlined,
                  color: const Color(0xFFFFD700),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Professional Insights',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Unlock real-time market movers, depth charts, and AI-powered buying signals.',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            _GradientButton(onTap: () {}, label: 'Go Professional'),
          ],
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.onTap, required this.label});
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF1C40F), Color(0xFFE67E22)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF39C12).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.item});
  final TrendingItemModel item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.titleMedium.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.subtitle,
                  style: AppTextStyles.caption.copyWith(fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.formattedValue,
                style: AppTextStyles.titleMedium.copyWith(fontSize: 16.sp),
              ),
              SizedBox(height: 4.h),
              Text(
                item.formattedChange,
                style:
                    (item.isPositive
                            ? AppTextStyles.positive
                            : AppTextStyles.negative)
                        .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
