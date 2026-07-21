import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_colors.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:aayapath/core/utils/number_formatter.dart';
import 'package:aayapath/features/entry/presentation/bloc/onboarding_bloc.dart';
import 'package:aayapath/features/entry/presentation/widgets/onboarding_choice_card.dart';
import 'package:aayapath/features/entry/presentation/widgets/onboarding_step_header.dart';
import 'package:aayapath/shared/presentation/widgets/app_button.dart';
import 'package:aayapath/shared/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const sourceIcons = {
  OnboardingIncomeSource.employee: Icons.work_outline,
  OnboardingIncomeSource.freelancer: Icons.badge_outlined,
  OnboardingIncomeSource.business: Icons.storefront_outlined,
  OnboardingIncomeSource.student: Icons.school_outlined,
  OnboardingIncomeSource.government: Icons.account_balance_outlined,
};

const sourceLabels = {
  OnboardingIncomeSource.employee: 'Employee',
  OnboardingIncomeSource.freelancer: 'Freelancer',
  OnboardingIncomeSource.business: 'Business',
  OnboardingIncomeSource.student: 'Student',
  OnboardingIncomeSource.government: 'Government',
};

class IncomeStep extends StatelessWidget {
  const IncomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (previous, current) =>
          previous.incomeSource != current.incomeSource ||
          previous.monthlyIncome != current.monthlyIncome,
      builder: (context, state) {
        final bloc = context.read<OnboardingBloc>();
        final reliability = state.financialReliabilityScore;
        final (tierLabel, suggestedPercent) = _reliabilityTier(reliability);

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingStepHeader(
                stepNumber: 2,
                headline: "What's your income like?",
                subtitle:
                    'Tell us how you earn so we can tailor your financial '
                    'plan around it.',
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
                    Text(
                      'What is your primary income source?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    16.vGap,
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 12.w,
                      childAspectRatio: 1.5,
                      children: OnboardingIncomeSource.values.map((source) {
                        return OnboardingChoiceCard(
                          icon: sourceIcons[source]!,
                          label: sourceLabels[source]!,
                          selected: state.incomeSource == source,
                          onTap: () =>
                              bloc.add(OnboardingIncomeSourceChanged(source)),
                        );
                      }).toList(),
                    ),
                    22.vGap,
                    Text(
                      'Estimated Monthly Income',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    10.vGap,
                    _MonthlyIncomeInput(
                      value: state.monthlyIncome,
                      onChanged: (v) =>
                          bloc.add(OnboardingMonthlyIncomeChanged(v)),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4.r,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 9.r,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                          overlayRadius: 16.r,
                        ),
                      ),
                      child: Slider(
                        min: 5000,
                        max: 1000000,
                        divisions: 995,
                        value: state.monthlyIncome.clamp(5000, 1000000),
                        onChanged: (v) =>
                            bloc.add(OnboardingMonthlyIncomeChanged(v)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _MinMaxLabel(label: 'MIN', value: 'Rs. 5,000'),
                        _MinMaxLabel(label: 'MAX', value: 'Rs. 1,000,000+'),
                      ],
                    ),
                    22.vGap,
                    _IncomePreviewCard(state: state, tierLabel: tierLabel),
                    22.vGap,
                  ],
                ),
              ),
              18.vGap,
              AppButton(
                label: 'Continue',
                onPressed: state.isIncomeStepValid
                    ? () => bloc.add(const OnboardingNextRequested())
                    : null,
              ),

              8.vGap,
            ],
          ),
        );
      },
    );
  }
}

(String label, int percent) _reliabilityTier(int score) {
  if (score >= 80) return ('High Stability', 30);
  if (score >= 60) return ('Good Stability', 20);
  if (score >= 40) return ('Moderate Stability', 15);
  return ('Building Stability', 10);
}

class _MonthlyIncomeInput extends StatefulWidget {
  const _MonthlyIncomeInput({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<_MonthlyIncomeInput> createState() => _MonthlyIncomeInputState();
}

class _MonthlyIncomeInputState extends State<_MonthlyIncomeInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value.round().toString(),
    );
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant _MonthlyIncomeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Keep the field in sync when the slider (not this field) drives the
    // value change — but don't fight the user while they're mid-typing.
    if (_focusNode.hasFocus) return;
    final displayed = widget.value.round().toString();
    if (_controller.text != displayed) _controller.text = displayed;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String text) {
    final parsed = double.tryParse(text);
    if (parsed == null) return;
    widget.onChanged(parsed.clamp(0, 1000000));
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      prefixText: 'Rs. ',
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: Theme.of(context).textTheme.headlineMedium,
      onChanged: _handleChanged,
    );
  }
}

class _MinMaxLabel extends StatelessWidget {
  const _MinMaxLabel({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final extra = Theme.of(context).extension<AppColorsExtension>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(color: extra?.textMuted),
        ),
        Text(value, style: AppTypography.titleSmall),
      ],
    );
  }
}

class _IncomePreviewCard extends StatelessWidget {
  const _IncomePreviewCard({required this.state, required this.tierLabel});

  final OnboardingState state;
  final String tierLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: extra?.surfaceElevated,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.insert_chart_outlined,
                  size: 18.r,
                  color: colors.primary,
                ),
              ),
              10.hGap,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Income Preview',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Real-time financial breakdown',
                      style: AppTypography.bodySmall.copyWith(
                        color: extra?.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Source Type',
                style: AppTypography.bodyMedium.copyWith(
                  color: extra?.textMuted,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  sourceLabels[state.incomeSource]!,
                  style: AppTypography.badge.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
          Divider(height: 28.h),
          Text(
            'Annual Projected Income',
            style: AppTypography.bodyMedium.copyWith(color: extra?.textMuted),
          ),
          4.vGap,
          Text(
            NumberFormatter.rupees(state.annualIncome),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          16.vGap,
        ],
      ),
    );
  }
}
