/// Wallet summary shown at the top of the Home dashboard.
/// Replace fields from API response in [HomeController.fetchDashboardData].
class WalletModel {
  const WalletModel({
    required this.name,
    required this.currency,
    required this.balance,
    required this.change30d,
  });

  /// Wallet name label, e.g. "Main"
  final String name;

  /// ISO currency code, e.g. "EUR"
  final String currency;

  /// Current total balance
  final double balance;

  /// Absolute change over the last 30 days (positive or negative)
  final double change30d;

  bool get isPositiveChange => change30d >= 0;

  /// Formatted balance string, e.g. "€64,650.03"
  String get formattedBalance =>
      '€${balance.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},')}';

  /// Formatted change string, e.g. "+€10,000.00 in the last 30 days"
  String get formattedChange {
    final sign = change30d >= 0 ? '+' : '';
    final abs = change30d
        .abs()
        .toStringAsFixed(2)
        .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');
    return '${sign}€$abs in the last 30 days';
  }
}
