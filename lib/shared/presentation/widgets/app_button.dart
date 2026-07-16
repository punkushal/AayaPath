import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outlined, text }

/// Reusable CTA button. Wraps [ElevatedButton]/[OutlinedButton]/[TextButton]
/// so every screen picks up the styling already defined in [AppTheme]
/// instead of hand-rolling button styles, and adds a loading state,
/// optional leading icon, and full-width layout on top.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  bool get _disabled => isLoading || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final child = _AppButtonContent(
      label: label,
      icon: icon,
      isLoading: isLoading,
      variant: variant,
    );

    final button = switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
        onPressed: _disabled ? null : onPressed,
        child: child,
      ),
      AppButtonVariant.secondary => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
        ),
        onPressed: _disabled ? null : onPressed,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: _disabled ? null : onPressed,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: _disabled ? null : onPressed,
        child: child,
      ),
    };

    if (!isFullWidth) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

class _AppButtonContent extends StatelessWidget {
  const _AppButtonContent({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.variant,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      final isFilled =
          variant == AppButtonVariant.primary ||
          variant == AppButtonVariant.secondary;
      final spinnerColor = isFilled
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.primary;
      return SizedBox(
        height: 18.r,
        width: 18.r,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: spinnerColor,
        ),
      );
    }

    if (icon == null) return Text(label);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon, size: 18.r), 8.hGap, Text(label)],
    );
  }
}
