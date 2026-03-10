import 'package:flutter/material.dart';

/// Represents a single item in the "Top Performer" list.
/// [avatarColor] is used as a placeholder until [imageUrl] comes from the API.
class TopPerformerModel {
  const TopPerformerModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.value,
    required this.changePercent,
    required this.avatarColor,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String subtitle;

  /// Portfolio value in EUR
  final double value;

  /// Percentage change (positive = gain, negative = loss)
  final double changePercent;

  /// Fallback colour until real image is loaded
  final Color avatarColor;

  /// Future API image URL – null until API integration
  final String? imageUrl;

  bool get isPositive => changePercent >= 0;

  String get formattedValue => '€${(value / 1000).toStringAsFixed(1)}K';

  String get formattedChange =>
      '${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%';
}
