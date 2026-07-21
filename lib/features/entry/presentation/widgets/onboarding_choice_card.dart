import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_colors.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:flutter/material.dart';

/// Tappable icon+label card used for the income-source grid and the
/// financial-goals grid, matching the "Business" / "Student" style cards on
/// the Income Information screen.
class OnboardingChoiceCard extends StatelessWidget {
  const OnboardingChoiceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return InkWell(
      borderRadius: BorderRadius.circular(18.r),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: selected
              ? colors.primary.withValues(alpha: 0.08)
              : colors.surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected
                ? colors.primary
                : (extra?.border ?? Theme.of(context).dividerColor),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20.r, color: colors.primary),
            ),
            10.vGap,
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.titleSmall.copyWith(
                color: selected ? colors.primary : colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
