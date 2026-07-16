import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:aayapath/features/entry/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';

/// Shared header block for every onboarding step: the "STEP X OF 4" eyebrow
/// with the dot/pill progress indicator (the style used on the Personal
/// Identity screen), a step label, a big headline, and a subtitle.
class OnboardingStepHeader extends StatelessWidget {
  const OnboardingStepHeader({
    super.key,
    required this.stepNumber,
    required this.headline,
    required this.subtitle,
  });

  /// 1-based step number, e.g. 1 for the first step.
  final int stepNumber;
  final String headline;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'STEP $stepNumber OF $kOnboardingTotalSteps',
              style: AppTypography.overline.copyWith(color: colors.primary),
            ),
            _StepDots(currentIndex: stepNumber - 1),
          ],
        ),
        16.vGap,
        Text(headline, style: textTheme.headlineLarge),
        8.vGap,
        Text(subtitle, style: textTheme.bodyMedium),
      ],
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.currentIndex});

  /// 0-based index of the active step.
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final track = Theme.of(context).dividerColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(kOnboardingTotalSteps, (index) {
        final isActive = index == currentIndex;
        final isDone = index < currentIndex;
        return Padding(
          padding: EdgeInsets.only(left: 6.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 8.r,
            width: isActive ? 22.r : 8.r,
            decoration: BoxDecoration(
              color: isActive || isDone ? colors.primary : track,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      }),
    );
  }
}
