import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_colors.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:aayapath/core/utils/number_formatter.dart';
import 'package:aayapath/features/entry/presentation/bloc/onboarding_bloc.dart';
import 'package:aayapath/features/entry/presentation/widgets/onboarding_step_header.dart';
import 'package:aayapath/features/entry/presentation/widgets/steps/income_step.dart';
import 'package:aayapath/shared/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _genderLabels = {
  OnboardingGender.male: 'Male',
  OnboardingGender.female: 'Female',
  OnboardingGender.other: 'Other',
};

class FinalizeStep extends StatelessWidget {
  const FinalizeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final bloc = context.read<OnboardingBloc>();
        final isSubmitting = state.status == OnboardingStatus.submitting;
        final isComplete = state.status == OnboardingStatus.complete;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingStepHeader(
                stepNumber: 3,
                headline: isComplete
                    ? "You're all set!"
                    : 'Review your details',
                subtitle: isComplete
                    ? 'Your profile has been created. We\'re building your '
                          'personalized financial roadmap.'
                    : 'Double-check everything below before we build your '
                          'roadmap.',
              ),
              24.vGap,
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: extra?.border ?? Theme.of(context).dividerColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SummarySection(
                      title: 'Personal Identity',
                      rows: [
                        ('Full Name', state.fullName),
                        ('Age', state.age),
                        ('Gender', _genderLabels[state.gender]!),
                      ],
                    ),
                    Divider(height: 32.h),
                    _SummarySection(
                      title: 'Income',
                      rows: [
                        ('Source', sourceLabels[state.incomeSource]!),
                        (
                          'Monthly Income',
                          NumberFormatter.rupees(state.monthlyIncome),
                        ),
                        (
                          'Annual Projected',
                          NumberFormatter.rupees(state.annualIncome),
                        ),
                      ],
                    ),
                    Divider(height: 32.h),

                    24.vGap,
                    if (isComplete)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: colors.primary,
                              size: 22.r,
                            ),
                            10.hGap,
                            Expanded(
                              child: Text(
                                'Profile created successfully!',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      AppButton(
                        label: 'Complete Setup',
                        isLoading: isSubmitting,
                        onPressed: () => bloc.add(const OnboardingSubmitted()),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        12.vGap,
        ...rows.map(
          (row) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row.$1,
                  style: AppTypography.bodyMedium.copyWith(
                    color: extra?.textMuted,
                  ),
                ),
                12.hGap,
                Flexible(
                  child: Text(
                    row.$2.isEmpty ? '—' : row.$2,
                    textAlign: TextAlign.end,
                    style: AppTypography.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
