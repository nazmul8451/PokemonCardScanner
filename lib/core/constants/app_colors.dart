import 'package:flutter/material.dart';

/// Central color palette for the entire app.
/// Usage: `AppColors.background`, `AppColors.primary`, etc.
class AppColors {
  AppColors._();

  // ── Background ──────────────────────────────────────────────────────────
  /// Main scaffold / app background (very dark navy‑black from the design)
  static const Color background = Color(0xFF0D0F14);

  /// Slightly lighter surface used for cards / nav bar
  static const Color surface = Color(0xFF161A22);

  /// Card background
  static const Color cardBackground = Color(0xFF1C2130);

  // ── Primary accent ───────────────────────────────────────────────────────
  /// Golden‑yellow highlight (active nav icon, tab indicator, etc.)
  static const Color primary = Color(0xFFD4C84F);

  /// Cyan / teal accent used on the portfolio chart and links
  static const Color accent = Color(0xFF3ECFCF);

  // ── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8A8FA8);
  static const Color textTertiary = Color(0xFF555A70);

  // ── Status colours ───────────────────────────────────────────────────────
  static const Color positive = Color(0xFF2ECC71);
  static const Color negative = Color(0xFFE74C3C);
  static const Color neutral = Color(0xFF8A8FA8);

  // ── Bottom nav bar ───────────────────────────────────────────────────────
  static const Color navBarBackground = Color(0xFF161A22);
  static const Color navIconActive = primary;
  static const Color navIconInactive = Color(0xFF555A70);

  // ── Divider ──────────────────────────────────────────────────────────────
  static const Color divider = Color(0xFF252A3A);
}
