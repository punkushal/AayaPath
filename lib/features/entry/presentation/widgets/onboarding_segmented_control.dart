import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_colors.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:flutter/material.dart';

/// A 3-pill segmented picker, matching the Male / Female / Other gender
/// selector on the Personal Identity screen.
class OnboardingSegmentedControl<T> extends StatelessWidget {
  const OnboardingSegmentedControl({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final List<(T value, String label)> options;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: extra?.surfaceElevated ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: options.map((option) {
          final selected = option.$1 == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option.$1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: selected ? colors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(11.r),
                  border: selected
                      ? Border.all(color: colors.primary, width: 1.2)
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  option.$2,
                  style: AppTypography.titleSmall.copyWith(
                    color: selected ? colors.primary : colors.onSurface,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
