import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:flutter/material.dart';

/// The green-tinted "Privacy First" reassurance card shown at the bottom of
/// every onboarding step.
class OnboardingPrivacyBanner extends StatelessWidget {
  const OnboardingPrivacyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: colors.primary.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: colors.surface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 18.r,
              color: colors.primary,
            ),
          ),
          12.hGap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Privacy First', style: Theme.of(context).textTheme.titleSmall),
                4.vGap,
                Text(
                  'We strictly adhere to the highest standards of financial '
                  'data protection in Nepal. Your information never leaves '
                  'our secure environment.',
                  style: AppTypography.bodySmall.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
