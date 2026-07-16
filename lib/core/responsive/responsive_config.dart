import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'break_points.dart';

class ResponsiveConfig {
  // Defaults to the design frame itself (scale == 1.0) so `.w`/`.h`/`.sp`
  // are safe to use before init() runs, e.g. in widget tests.
  static Size _size =
      const Size(Breakpoints.designWidth, Breakpoints.designHeight);
  static TextScaler _textScaler = TextScaler.noScaling;

  /// Initialize with a BuildContext. Call every build from a widget near the
  /// root (e.g. above MaterialApp) so scale factors stay in sync with
  /// MediaQuery changes such as rotation or window resize. Reads only size
  /// and text scale (not the full MediaQueryData) so callers aren't
  /// rebuilt on unrelated changes like keyboard visibility.
  static void init(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
    _textScaler = MediaQuery.textScalerOf(context);
  }

  static double get screenWidth => _size.width;
  static double get screenHeight => _size.height;
  static TextScaler get textScaler => _textScaler;

  // Choose a base design width depending on the device class. For tablets and
  // desktops we use a wider design baseline so scaling feels more natural.
  static double get _baseDesignWidth {
    if (screenWidth >= Breakpoints.desktopBreakpoint) {
      return Breakpoints.desktopDesignWidth;
    }
    if (screenWidth >= Breakpoints.tabletBreakpoint) {
      return Breakpoints.tabletDesignWidth;
    }
    return Breakpoints.designWidth;
  }

  // Sensible clamp limits to avoid extreme scaling on very small or very large screens
  static const double _minScale = 0.75;
  static const double _maxScale = 1.6;

  /// Horizontal scale factor (width-based)
  static double get scaleW {
    final raw = screenWidth / _baseDesignWidth;
    return raw.clamp(_minScale, _maxScale);
  }

  /// Vertical scale factor (height-based)
  static double get scaleH {
    final raw = screenHeight / Breakpoints.designHeight;
    return raw.clamp(_minScale, _maxScale);
  }

  /// Scale font sizes. Uses the width-based scale and respects system text scaling.
  static double scaleText(double size) => textScaler.scale(size * scaleW);

  /// Useful helper to constrain content width on large screens (centered layouts)
  static double constrainedContentWidth(double maxWidth) =>
      math.min(screenWidth, maxWidth);
}
