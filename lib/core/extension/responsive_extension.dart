import 'package:flutter/widgets.dart';

import '../responsive/responsive_config.dart';

extension ResponsiveNum on num {
  /// For responsive width
  double get w => this * ResponsiveConfig.scaleW;

  /// For responsive height
  double get h => this * ResponsiveConfig.scaleH;

  /// For responsive radius
  double get r =>
      this * ((ResponsiveConfig.scaleW + ResponsiveConfig.scaleH) / 2);

  /// For responsive font size
  double get sp => ResponsiveConfig.scaleText(toDouble());
}

extension Gap on num {
  /// Horizontal gap using sized box
  SizedBox get hGap => SizedBox(width: toDouble().w);

  /// Vertical gap using sized box
  SizedBox get vGap => SizedBox(height: toDouble().h);
}
