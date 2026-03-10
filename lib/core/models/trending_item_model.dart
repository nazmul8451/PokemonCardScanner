/// Represents a single item in the "Trending Now" list.
class TrendingItemModel {
  const TrendingItemModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.value,
    required this.changePercent,
  });

  final String id;
  final String name;
  final String subtitle;

  /// Price or value in EUR
  final double value;

  /// Percentage change
  final double changePercent;

  bool get isPositive => changePercent >= 0;

  String get formattedValue => '€${value.toStringAsFixed(2)}';

  String get formattedChange =>
      '${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(1)}%';
}
