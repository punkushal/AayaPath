class Breakpoints {
  Breakpoints._();

  // Base design frame — match your Figma phone frame
  static const double designWidth = 390;
  static const double designHeight = 844;

  // Wider design frames used once screenWidth crosses the thresholds below,
  // so large screens scale from a layout built for their size instead of
  // just clamping a phone layout.
  static const double tabletDesignWidth = 768;
  static const double desktopDesignWidth = 1440;

  // Width thresholds used to classify the current device class.
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1024;
}
