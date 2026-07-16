// Centralized color palette for the AayaPath app
// USAGE
//   Don't reference AppColors.light / AppColors.dark directly in widgets.
//   Instead read colors via the active Theme (see app_theme.dart), e.g.:
//     Theme.of(context).colorScheme.primary
//     Theme.of(context).extension<AppColorsExtension>()!.success
//
//   This file just defines the raw palette + a ThemeExtension so custom,
//   non-Material colors (chart colors, badge colors, etc.) can also be
//   themed and hot-swapped between light/dark.
// -----------------------------------------------------------------------

import 'package:flutter/material.dart';

/// Raw, static color values. Grouped by theme (light/dark) and then by
/// semantic role (background, surface, text, brand, chart, status...).
///
/// Keep this class free of any Flutter Theme logic — it is pure data.
/// All Theme wiring happens in [AppTheme] (see app_theme.dart).
class AppColors {
  AppColors._(); // no instances — static palette only

  // ===========================================================================
  // BRAND / PRIMARY
  // ===========================================================================
  // The signature mint/emerald green.Dark mode uses a brighter, more saturated mint
  // so it glows against the near-black background; light mode uses a
  // deeper forest green so it holds contrast against white cards.

  /// Bright mint-green used in DARK theme (rings, buttons, active icons).
  static const Color primaryMintDark = Color(0xFF4ADE9E);

  /// Deeper forest-green used in LIGHT theme for the same brand role.
  static const Color primaryForestLight = Color(0xFF178A4C);

  /// Secondary accent blue (used for "Savings" segments, info icons).
  static const Color accentBlueDark = Color(0xFF4FA8FF);
  static const Color accentBlueLight = Color(0xFF2563EB);

  /// Tertiary accent red/coral (used for "Emergency" segment + destructive
  /// actions like Sign Out / Logout).
  static const Color accentRedDark = Color(0xFFFF7A7A);
  static const Color accentRedLight = Color(0xFFDC2626);

  /// Neutral slate accent (used for "Investment" segment in light theme
  /// donut charts).
  static const Color accentSlateDark = Color(0xFF8B95A5);
  static const Color accentSlateLight = Color(0xFF475569);

  // ===========================================================================
  // DARK THEME NEUTRALS
  // ===========================================================================

  /// App scaffold background — near-black navy.
  static const Color darkBackground = Color(0xFF0B1220);

  /// Card / surface background — one step lighter than scaffold.
  static const Color darkSurface = Color(0xFF141E2E);

  /// Elevated surface (e.g. input fields, nested cards, pills).
  static const Color darkSurfaceElevated = Color(0xFF1B2637);

  /// Subtle border/divider color on dark surfaces.
  static const Color darkBorder = Color(0xFF263244);

  /// Primary text (headlines, big numbers like "84").
  static const Color darkTextPrimary = Color(0xFFF5F7FA);

  /// Secondary text (labels like "FINANCIAL HEALTH", captions).
  static const Color darkTextSecondary = Color(0xFF97A2B4);

  /// Muted / disabled text (timestamps, tertiary hints).
  static const Color darkTextMuted = Color(0xFF667085);

  // ===========================================================================
  // LIGHT THEME NEUTRALS
  // ===========================================================================
  // Sampled from Emergency Fund / Financial Health / Salary Planner /
  // Home / Onboarding light screens.

  /// App scaffold background — soft off-white/blue-gray.
  static const Color lightBackground = Color(0xFFF4F6F9);

  /// Card / surface background — pure white cards on the gray scaffold.
  static const Color lightSurface = Color(0xFFFFFFFF);

  /// Elevated / nested surface (e.g. "Recommendation" chips, input fields).
  static const Color lightSurfaceElevated = Color(0xFFF0F3F1);

  /// Subtle border/divider color on light surfaces.
  static const Color lightBorder = Color(0xFFE3E7ED);

  /// Primary text (headlines, big numbers).
  static const Color lightTextPrimary = Color(0xFF16202D);

  /// Secondary text (labels, captions).
  static const Color lightTextSecondary = Color(0xFF5B6472);

  /// Muted / disabled text.
  static const Color lightTextMuted = Color(0xFF8A93A2);

  // ===========================================================================
  // STATUS / SEMANTIC COLORS (shared meaning across themes, tuned per theme)
  // ===========================================================================

  static const Color successDark = Color(0xFF4ADE9E);
  static const Color successLight = Color(0xFF178A4C);

  static const Color warningDark = Color(0xFFFFC24B);
  static const Color warningLight = Color(0xFFB45309);

  static const Color errorDark = Color(0xFFFF6B6B);
  static const Color errorLight = Color(0xFFDC2626);

  static const Color infoDark = Color(0xFF4FA8FF);
  static const Color infoLight = Color(0xFF2563EB);

  // ===========================================================================
  // GRADIENT / HERO BANNER COLORS
  // ===========================================================================
  // Used by the "Today's Pro Tip" and "You're almost there!" success banners.

  static const List<Color> proTipGradientDark = [
    Color(0xFF12A66E),
    Color(0xFF0C8C5C),
  ];

  static const List<Color> proTipGradientLight = [
    Color(0xFF1B9E5A),
    Color(0xFF12693C),
  ];

  // ===========================================================================
  // CHART / DATA-VIZ PALETTE
  // ===========================================================================
  // Salary Allocation donut chart + bar chart segments, indexed by category.
  // Order: Needs, Savings/Investment, Emergency, Lifestyle.

  static const List<Color> chartPaletteDark = [
    primaryMintDark, // Needs
    accentBlueDark, // Savings
    Color(0xFF8B95A5), // Investment
    accentRedDark, // Emergency
    Color(0xFF6EE7B7), // Lifestyle
  ];

  static const List<Color> chartPaletteLight = [
    primaryForestLight, // Needs
    accentBlueLight, // Savings
    accentSlateLight, // Investment
    accentRedLight, // Emergency
    Color(0xFF34D399), // Lifestyle
  ];

  /// Faint track color behind progress rings (the "empty" 100% base ring).
  static const Color ringTrackDark = Color(0xFF1E2A3D);
  static const Color ringTrackLight = Color(0xFFE6EAEE);
}

/// A [ThemeExtension] that exposes AayaPath's custom semantic colors
/// (the ones that don't map cleanly onto Flutter's [ColorScheme]) so they
/// can be looked up via `Theme.of(context).extension<AppColorsExtension>()`
/// and automatically animate/swap when the theme changes.
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.success,
    required this.warning,
    required this.info,
    required this.surfaceElevated,
    required this.border,
    required this.textMuted,
    required this.ringTrack,
    required this.chartPalette,
    required this.proTipGradient,
  });

  final Color success;
  final Color warning;
  final Color info;
  final Color surfaceElevated;
  final Color border;
  final Color textMuted;
  final Color ringTrack;
  final List<Color> chartPalette;
  final List<Color> proTipGradient;

  /// Pre-built instance for dark mode, sourced from [AppColors].
  static const dark = AppColorsExtension(
    success: AppColors.successDark,
    warning: AppColors.warningDark,
    info: AppColors.infoDark,
    surfaceElevated: AppColors.darkSurfaceElevated,
    border: AppColors.darkBorder,
    textMuted: AppColors.darkTextMuted,
    ringTrack: AppColors.ringTrackDark,
    chartPalette: AppColors.chartPaletteDark,
    proTipGradient: AppColors.proTipGradientDark,
  );

  /// Pre-built instance for light mode, sourced from [AppColors].
  static const light = AppColorsExtension(
    success: AppColors.successLight,
    warning: AppColors.warningLight,
    info: AppColors.infoLight,
    surfaceElevated: AppColors.lightSurfaceElevated,
    border: AppColors.lightBorder,
    textMuted: AppColors.lightTextMuted,
    ringTrack: AppColors.ringTrackLight,
    chartPalette: AppColors.chartPaletteLight,
    proTipGradient: AppColors.proTipGradientLight,
  );

  @override
  AppColorsExtension copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? surfaceElevated,
    Color? border,
    Color? textMuted,
    Color? ringTrack,
    List<Color>? chartPalette,
    List<Color>? proTipGradient,
  }) {
    return AppColorsExtension(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      border: border ?? this.border,
      textMuted: textMuted ?? this.textMuted,
      ringTrack: ringTrack ?? this.ringTrack,
      chartPalette: chartPalette ?? this.chartPalette,
      proTipGradient: proTipGradient ?? this.proTipGradient,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      border: Color.lerp(border, other.border, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      ringTrack: Color.lerp(ringTrack, other.ringTrack, t)!,
      // Lists don't lerp meaningfully color-by-color here; snap at t >= 0.5.
      chartPalette: t < 0.5 ? chartPalette : other.chartPalette,
      proTipGradient: t < 0.5 ? proTipGradient : other.proTipGradient,
    );
  }
}
