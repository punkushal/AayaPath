// -----------------------------------------------------------------------
// Assembles AppColors + AppTypography into two complete `ThemeData`
// objects: `AppTheme.light` and `AppTheme.dark`.
//
// USAGE (in main.dart):
//
//   MaterialApp(
//     theme: AppTheme.light,
//     darkTheme: AppTheme.dark,
//     themeMode: ThemeMode.system, // or ThemeMode.dark to force dark UI
//     ...
//   )
//
// Then anywhere in the widget tree:
//   final colors = Theme.of(context).colorScheme;
//   final text   = Theme.of(context).textTheme;
//   final extra  = Theme.of(context).extension<AppColorsExtension>()!;
// -----------------------------------------------------------------------

import 'package:flutter/material.dart';
import '../extension/responsive_extension.dart';
import 'app_colors.dart';
import 'app_typograhpy.dart';

class AppTheme {
  AppTheme._();

  // ===========================================================================
  // DARK THEME
  // ===========================================================================
  static ThemeData get dark {
    const colorScheme = ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.primaryMintDark,
      onPrimary: Color(0xFF042713), // dark text on mint buttons
      secondary: AppColors.accentBlueDark,
      onSecondary: Color(0xFF001F3D),
      error: AppColors.errorDark,
      onError: Color(0xFF3B0A0A),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurfaceElevated,
      outline: AppColors.darkBorder,
      // `background` is deprecated in newer Flutter SDKs in favor of
      // surface, but scaffoldBackgroundColor below is what actually
      // controls the app background — kept explicit for clarity.
    );

    final textTheme = AppTypography.buildTextTheme(
      primaryColor: AppColors.darkTextPrimary,
      secondaryColor: AppColors.darkTextSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: AppTypography.fontFamily,
      textTheme: textTheme,
      dividerColor: AppColors.darkBorder,
      splashColor: AppColors.primaryMintDark.withValues(alpha: 0.12),
      highlightColor: Colors.transparent,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.primaryMintDark,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      ),

      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryMintDark,
          foregroundColor: const Color(0xFF042713),
          disabledBackgroundColor: AppColors.darkSurfaceElevated,
          textStyle: AppTypography.labelLarge,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkTextPrimary,
          side: const BorderSide(color: AppColors.darkBorder),
          textStyle: AppTypography.labelLarge,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryMintDark,
          textStyle: AppTypography.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceElevated,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.darkTextMuted,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: AppColors.primaryMintDark,
            width: 1.5,
          ),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryMintDark
              : AppColors.darkSurfaceElevated,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primaryMintDark,
        unselectedItemColor: AppColors.darkTextMuted,
        selectedLabelStyle: AppTypography.labelMedium,
        unselectedLabelStyle: AppTypography.labelMedium,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryMintDark,
        linearTrackColor: AppColors.ringTrackDark,
        circularTrackColor: AppColors.ringTrackDark,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),

      extensions: const [AppColorsExtension.dark],
    );
  }

  // ===========================================================================
  // LIGHT THEME
  // ===========================================================================
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primaryForestLight,
      onPrimary: Colors.white,
      secondary: AppColors.accentBlueLight,
      onSecondary: Colors.white,
      error: AppColors.errorLight,
      onError: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      surfaceContainerHighest: AppColors.lightSurfaceElevated,
      outline: AppColors.lightBorder,
    );

    final textTheme = AppTypography.buildTextTheme(
      primaryColor: AppColors.lightTextPrimary,
      secondaryColor: AppColors.lightTextSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: AppTypography.fontFamily,
      textTheme: textTheme,
      dividerColor: AppColors.lightBorder,
      splashColor: AppColors.primaryForestLight.withValues(alpha: 0.08),
      highlightColor: Colors.transparent,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: AppColors.primaryForestLight,
        ),
        iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
      ),

      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryForestLight,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.lightSurfaceElevated,
          textStyle: AppTypography.labelLarge,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightTextPrimary,
          side: const BorderSide(color: AppColors.lightBorder),
          textStyle: AppTypography.labelLarge,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryForestLight,
          textStyle: AppTypography.labelLarge,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceElevated,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.lightTextMuted,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(
            color: AppColors.primaryForestLight,
            width: 1.5,
          ),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryForestLight
              : AppColors.lightBorder,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primaryForestLight,
        unselectedItemColor: AppColors.lightTextMuted,
        selectedLabelStyle: AppTypography.labelMedium,
        unselectedLabelStyle: AppTypography.labelMedium,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryForestLight,
        linearTrackColor: AppColors.ringTrackLight,
        circularTrackColor: AppColors.ringTrackLight,
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),

      extensions: const [AppColorsExtension.light],
    );
  }
}
