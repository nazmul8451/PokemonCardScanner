import 'package:flutter/material.dart';

/// Represents a single row in the "Market Volume" section.
class MarketVolumeModel {
  const MarketVolumeModel({
    required this.id,
    required this.category,
    required this.totalSold,
    required this.totalVolume,
    required this.avgPrice,
    required this.avatarColor,
    this.imageUrl,
  });

  final String id;

  /// Category name, e.g. "Pokémon"
  final String category;

  /// Number of items sold in the period
  final int totalSold;

  /// Total volume in EUR
  final double totalVolume;

  /// Average sale price in EUR
  final double avgPrice;

  /// Placeholder colour until image loads from API
  final Color avatarColor;

  /// Future API image URL
  final String? imageUrl;

  String get formattedVolume {
    if (totalVolume >= 1000) {
      return '€${(totalVolume / 1000).toStringAsFixed(0)}K';
    }
    return '€${totalVolume.toStringAsFixed(0)}';
  }

  String get formattedAvg => 'AVG €${avgPrice.toStringAsFixed(0)}';
  String get formattedSold => '${totalSold.toString()} SOLD';
}
