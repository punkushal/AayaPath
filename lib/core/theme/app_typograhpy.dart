// -----------------------------------------------------------------------
// Typography scale for the AayaPath app.
//
// The screens show a clean, geometric sans-serif with:
//   - Very large, heavy numerals for hero stats (the "84" score, EMI
//     amount, Rs. income figure) — tight letter spacing, bold weight.
//   - Bold, slightly condensed headlines ("Salary Allocation",
//     "Build your profile").
//   - Medium-weight section titles ("Quick Actions", "Active Goals").
//   - Regular body text for descriptions/notes.
//   - Small, wide-tracked uppercase labels/eyebrows ("FINANCIAL HEALTH",
//     "STEP 1 OF 4", "TODAY'S PRO TIP").
//
// This maps well onto Google Fonts' "Inter" (or "Manrope" — both are
// close matches to the geometric grotesque look in the screens). Swap the
// `_fontFamily` constant below if you'd rather use a bundled font asset.
//
// USAGE
//   Don't construct TextStyles ad hoc in widgets. Use:
//     Theme.of(context).textTheme.displayLarge   // hero numbers
//     Theme.of(context).textTheme.headlineMedium // section headlines
//     Theme.of(context).textTheme.bodyMedium      // body copy
//   or the AayaPath-specific extras via:
//     AppTypography.overline / AppTypography.numeralHero
// -----------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../extension/responsive_extension.dart';

class AppTypography {
  AppTypography._();

  /// Change this single constant to swap the app's font family everywhere.
  /// Requires adding `google_fonts` package or bundling the font in
  /// pubspec.yaml if not using a platform default.
  static const String fontFamily = 'Inter';

  // ===========================================================================
  // BASE TEXT THEME (color-agnostic — colors are applied in AppTheme per
  // light/dark, so these only define size / weight / spacing / height).
  // ===========================================================================

  /// Hero numerals — e.g. the "84" health score ring, "Rs. 1,25,000"
  /// income figure, "₹21,696" EMI amount.
  static TextStyle get displayLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 44.sp,
    fontWeight: FontWeight.w800,
    height: 1.1,
    letterSpacing: -0.5,
  );

  /// Slightly smaller hero numerals (e.g. "$8,450" monthly net).
  static TextStyle get displayMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.4,
  );

  /// Card/stat numerals (e.g. "$4,225.00" allocation amounts).
  static TextStyle get displaySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.2,
  );

  /// Page-level headline (e.g. "Salary Allocation", "Build your profile").
  static TextStyle get headlineLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.3,
  );

  /// Section headline (e.g. "Quick Actions", "Achievements").
  static TextStyle get headlineMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Card title (e.g. "Emergency Fund", "EMI Calculator", "Needs").
  static TextStyle get headlineSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  /// Primary UI titles inside components (e.g. app bar "Planner", "Settings").
  static TextStyle get titleLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 19.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  /// Sub-titles (e.g. "Aarav Sharma" name under avatar).
  static TextStyle get titleMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  /// List item titles (e.g. "Bank Accounts", "Security & Privacy").
  static TextStyle get titleSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  /// Body copy — descriptions, note boxes, recommendation text.
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Default body copy (most paragraph/description text in the screens).
  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  /// Small body copy (e.g. "Reason: Covers essential survival expenses...").
  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  /// Button label text (e.g. "View Detailed Report", "Save Plan").
  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.1,
  );

  /// Medium label (e.g. nav bar labels "Home", "Planner", "Goals").
  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  /// Small label / caption (e.g. "Next salary in 12 days", timestamps).
  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // ===========================================================================
  // AAYAPATH-SPECIFIC EXTRAS (not part of Flutter's default TextTheme)
  // ===========================================================================

  /// Wide-tracked uppercase eyebrow/overline text, e.g. "FINANCIAL HEALTH",
  /// "TODAY'S PRO TIP", "STEP 1 OF 4", "APPEARANCE" section headers.
  static TextStyle get overline => TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    height: 1.4,
  );

  /// The single biggest numeral style in the app — the health-score ring
  /// ("84") and similarly hero-sized figures.
  static TextStyle get numeralHero => TextStyle(
    fontFamily: fontFamily,
    fontSize: 56.sp,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: -1.0,
  );

  /// Pill/badge text, e.g. "+12% vs last mo", "EXCELLENT (+4 pts this month)".
  static TextStyle get badge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  /// Builds a complete [TextTheme] by applying [color] and [secondaryColor]
  /// to the base styles above. Called from AppTheme for both light & dark.
  static TextTheme buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: primaryColor),
      displayMedium: displayMedium.copyWith(color: primaryColor),
      displaySmall: displaySmall.copyWith(color: primaryColor),
      headlineLarge: headlineLarge.copyWith(color: primaryColor),
      headlineMedium: headlineMedium.copyWith(color: primaryColor),
      headlineSmall: headlineSmall.copyWith(color: primaryColor),
      titleLarge: titleLarge.copyWith(color: primaryColor),
      titleMedium: titleMedium.copyWith(color: primaryColor),
      titleSmall: titleSmall.copyWith(color: primaryColor),
      bodyLarge: bodyLarge.copyWith(color: primaryColor),
      bodyMedium: bodyMedium.copyWith(color: secondaryColor),
      bodySmall: bodySmall.copyWith(color: secondaryColor),
      labelLarge: labelLarge.copyWith(color: primaryColor),
      labelMedium: labelMedium.copyWith(color: secondaryColor),
      labelSmall: labelSmall.copyWith(color: secondaryColor),
    );
  }
}
