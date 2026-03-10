/// Chart data for a specific time period.
/// [points] are normalised 0.0–1.0 Y-values (left→right on the chart).
class ChartDataModel {
  const ChartDataModel({required this.period, required this.points});

  /// Label shown on the period button, e.g. "3M"
  final String period;

  /// Normalised Y positions (0 = bottom, 1 = top of chart area)
  final List<double> points;
}
