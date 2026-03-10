import 'package:flutter/material.dart';
import '../../core/models/market_volume_model.dart';
import '../../core/models/trending_item_model.dart';

class MarketsController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<MarketVolumeModel> _marketVolumes = [];
  List<MarketVolumeModel> get marketVolumes => _marketVolumes;

  List<TrendingItemModel> _trendingItems = [];
  List<TrendingItemModel> get trendingItems => _trendingItems;

  Future<void> fetchMarketsData() async {
    _isLoading = true;
    notifyListeners();

    // Simulated network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Mock Market Volume Data – Using asset images identified earlier
    _marketVolumes = [
      const MarketVolumeModel(
        id: '1',
        category: 'Pokémon',
        totalSold: 1300,
        totalVolume: 120000,
        avgPrice: 200,
        avatarColor: Color(0xFFFFCB05),
        changePercent: 12.5,
        imageUrl: 'assets/images/pokemon.png',
      ),
      const MarketVolumeModel(
        id: '2',
        category: 'One Piece',
        totalSold: 850,
        totalVolume: 120000,
        avgPrice: 200,
        avatarColor: Color(0xFFE74C3C),
        changePercent: 12.5,
        imageUrl: 'assets/images/img.png',
      ),
      const MarketVolumeModel(
        id: '3',
        category: 'Yu-Gi-Oh!',
        totalSold: 620,
        totalVolume: 45000,
        avgPrice: 72,
        avatarColor: Color(0xFF9B59B6),
        changePercent: -3.2,
        imageUrl: 'assets/images/Container_4.png',
      ),
      const MarketVolumeModel(
        id: '4',
        category: 'Magic: The Gathering',
        totalSold: 2100,
        totalVolume: 120000,
        avgPrice: 200,
        avatarColor: Color(0xFF2ECC71),
        changePercent: 12.5,
        imageUrl: 'assets/images/Container_1.png',
      ),
      const MarketVolumeModel(
        id: '5',
        category: 'Lorcana',
        totalSold: 480,
        totalVolume: 120000,
        avgPrice: 200,
        avatarColor: Color(0xFF3498DB),
        changePercent: 12.5,
        imageUrl: 'assets/images/Container.png',
      ),
    ];

    // Mock Trending Item Data
    _trendingItems = [
      const TrendingItemModel(
        id: '1',
        name: 'Luffy Gear 5',
        subtitle: 'OP-05',
        value: 245.50,
        changePercent: 67.8,
      ),
      const TrendingItemModel(
        id: '2',
        name: 'Charizard VMAX',
        subtitle: 'CP',
        value: 589.99,
        changePercent: 15.2,
      ),
      const TrendingItemModel(
        id: '3',
        name: 'The One Ring',
        subtitle: 'LOTR',
        value: 3200,
        changePercent: 8.5,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
