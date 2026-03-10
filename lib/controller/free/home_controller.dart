import 'package:flutter/material.dart';
import '../../core/models/wallet_model.dart';
import '../../core/models/top_performer_model.dart';
import '../../core/models/chart_data_model.dart';
import '../../core/models/market_volume_model.dart';

/// Dashboard HomeController.
///
/// Currently uses mock data for client review.
/// When the API is ready, replace the body of [fetchDashboardData] with
/// real HTTP calls — the HomeScreen UI does not need to change at all.
class HomeController extends ChangeNotifier {
  // ── State ────────────────────────────────────────────────────────────────

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WalletModel? _wallet;
  WalletModel? get wallet => _wallet;

  List<TopPerformerModel> _topPerformers = [];
  List<TopPerformerModel> get topPerformers => _topPerformers;

  List<MarketVolumeModel> _marketVolume = [];
  List<MarketVolumeModel> get marketVolume => _marketVolume;

  String _selectedPeriod = '3M';
  String get selectedPeriod => _selectedPeriod;

  ChartDataModel? _chartData;
  ChartDataModel? get chartData => _chartData;

  // ── Period change ─────────────────────────────────────────────────────────

  Future<void> changePeriod(String period) async {
    if (_selectedPeriod == period) return;
    _selectedPeriod = period;
    _chartData = _mockChartData[period];
    notifyListeners();
  }

  // ── Fetch (mock → swap with real HTTP later) ──────────────────────────────

  Future<void> fetchDashboardData() async {
    _isLoading = true;
    notifyListeners();

    // Simulated network latency – remove when real API is connected
    await Future.delayed(const Duration(milliseconds: 800));

    // ── MOCK DATA ─────────────────────────────────────────────────────────
    _wallet = const WalletModel(
      name: 'Main',
      currency: 'EUR',
      balance: 64650.03,
      change30d: 10000.00,
    );

    _topPerformers = [
      TopPerformerModel(
        id: '1',
        name: 'Monkey D. Luffy (Manga)',
        subtitle: 'PSA 10 (GEM - MT) • Foil',
        value: 15100,
        changePercent: -2.13,
        avatarColor: const Color(0xFF7B68EE),
        imageUrl: 'assets/images/Container.png',
      ),
      TopPerformerModel(
        id: '2',
        name: 'Monkey.D.Luffy (Oda Sign)',
        subtitle: 'PSA 10 (GEM - MT) • Foil',
        value: 12000,
        changePercent: -17.39,
        avatarColor: const Color(0xFF20B2AA),
        imageUrl: 'assets/images/Container_1.png',
      ),
      TopPerformerModel(
        id: '3',
        name: 'Pokemon Center 15th Ann',
        subtitle: 'Sealed',
        value: 11800,
        changePercent: 0,
        avatarColor: const Color(0xFFFF6347),
        imageUrl: 'assets/images/Container_2.png',
      ),
      TopPerformerModel(
        id: '4',
        name: 'Romance Dawn Booster Box',
        subtitle: 'Sealed',
        value: 6500,
        changePercent: 8.01,
        avatarColor: const Color(0xFF2ECC71),
        imageUrl: 'assets/images/Container_3.png',
      ),
    ];

    _marketVolume = [
      MarketVolumeModel(
        id: '1',
        category: 'Pokémon',
        totalSold: 1300,
        totalVolume: 120000,
        avgPrice: 200,
        avatarColor: const Color(0xFFFFCB05),
        changePercent: 12.5,
        imageUrl: 'assets/images/pokemon.png',
      ),
      MarketVolumeModel(
        id: '2',
        category: 'One Piece',
        totalSold: 850,
        totalVolume: 95000,
        avgPrice: 112,
        avatarColor: const Color(0xFFE74C3C),
        changePercent: 12.5,
        imageUrl: 'assets/images/img.png',
      ),
      MarketVolumeModel(
        id: '3',
        category: 'Yu-Gi-Oh!',
        totalSold: 620,
        totalVolume: 45000,
        avgPrice: 72,
        avatarColor: const Color(0xFF9B59B6),
        changePercent: -3.2,
        imageUrl: 'assets/images/Container_4.png',
      ),
    ];

    _chartData = _mockChartData[_selectedPeriod];
    // ── END MOCK DATA ─────────────────────────────────────────────────────

    _isLoading = false;
    notifyListeners();
  }

  // ── Mock chart data per period ────────────────────────────────────────────

  static final Map<String, ChartDataModel> _mockChartData = {
    '1D': const ChartDataModel(
      period: '1D',
      points: [0.55, 0.52, 0.58, 0.54, 0.60, 0.57, 0.62, 0.65],
    ),
    '7D': const ChartDataModel(
      period: '7D',
      points: [0.40, 0.45, 0.35, 0.50, 0.55, 0.60, 0.58, 0.70],
    ),
    '1M': const ChartDataModel(
      period: '1M',
      points: [0.30, 0.40, 0.35, 0.50, 0.45, 0.60, 0.65, 0.75],
    ),
    '3M': const ChartDataModel(
      period: '3M',
      points: [0.15, 0.20, 0.35, 0.45, 0.60, 0.75, 0.85, 0.95],
    ),
    '6M': const ChartDataModel(
      period: '6M',
      points: [0.10, 0.25, 0.20, 0.40, 0.50, 0.65, 0.80, 0.95],
    ),
    'ALL': const ChartDataModel(
      period: 'ALL',
      points: [0.05, 0.10, 0.20, 0.30, 0.45, 0.60, 0.80, 0.95],
    ),
  };
}
