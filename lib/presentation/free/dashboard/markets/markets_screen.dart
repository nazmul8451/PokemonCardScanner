import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../controller/free/markets_controller.dart';
import '../../../../core/models/market_volume_model.dart';
import '../../../../core/models/trending_item_model.dart';
import '../../../commonWidgets/common_widgets.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  final TextEditingController _searchController = TextEditingController();

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
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Consumer<MarketsController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _MarketsBody(
              controller: controller,
              searchController: _searchController,
            );
          },
        ),
      ),
    );
  }
}

class _MarketsBody extends StatelessWidget {
  const _MarketsBody({
    required this.controller,
    required this.searchController,
  });
  final MarketsController controller;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _AppBar(searchController: searchController)),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
        SliverToBoxAdapter(
          child: ProfessionalInsightsCard(
            margin: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
          ),
        ),
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
  const _AppBar({required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 44.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white38, size: 20.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search markets...',
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
          SizedBox(height: 12.h),
          Text(
            'Markets',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
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
    return Container(
      height: 160.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.05,
              child: Text(
                item.category.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.sp,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: item.imageUrl != null
                                ? Colors.transparent
                                : item.avatarColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: item.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20.r),
                                  child: Image.asset(item.imageUrl!,
                                      fit: BoxFit.cover),
                                )
                              : Icon(Icons.style_rounded,
                                  color: item.avatarColor, size: 20),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          item.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.more_horiz, color: Colors.white.withOpacity(0.3)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMarketStat('VOLUME', item.formattedVolume),
                    _buildMarketStat('SOLD', item.formattedSold, isCenter: true),
                    _buildMarketStat('AVG PRICE', item.formattedAvg),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStat(String label, String value, {bool isCenter = false}) {
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.item});
  final TrendingItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.white24),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  item.subtitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4), fontSize: 12.sp),
                ),
                SizedBox(height: 4.h),
                Text(
                  'VOL: €125K',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.4), fontSize: 10.sp),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.formattedValue,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800),
              ),
              Row(
                children: [
                  Icon(
                      item.isPositive
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: item.isPositive
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      size: 20),
                  Text(
                    item.formattedChange,
                    style: TextStyle(
                        color: item.isPositive
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                'FREE INSIGHTS',
                style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
