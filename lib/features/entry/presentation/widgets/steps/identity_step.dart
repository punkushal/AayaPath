import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_colors.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:aayapath/features/entry/presentation/bloc/onboarding_bloc.dart';
import 'package:aayapath/features/entry/presentation/widgets/onboarding_segmented_control.dart';
import 'package:aayapath/features/entry/presentation/widgets/onboarding_step_header.dart';
import 'package:aayapath/shared/presentation/widgets/app_button.dart';
import 'package:aayapath/shared/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentityStep extends StatelessWidget {
  const IdentityStep({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final extra = Theme.of(context).extension<AppColorsExtension>();

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (previous, current) =>
          previous.fullName != current.fullName ||
          previous.age != current.age ||
          previous.gender != current.gender ||
          previous.province != current.province ||
          previous.district != current.district ||
          previous.isIdentityStepValid != current.isIdentityStepValid,
      builder: (context, state) {
        final bloc = context.read<OnboardingBloc>();
        // final districts = NepalLocations.districtsFor(state.province);

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingStepHeader(
                stepNumber: 1,
                headline: 'Build your profile',
                subtitle:
                    "Let's gather some basic details to personalize your "
                    'financial roadmap and recommendations.',
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
                    AppTextField(
                      label: 'Full Name',
                      hintText: 'e.g. Aarav Sharma',
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                      initialValue: state.fullName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: _validateFullName,
                      onChanged: (v) => bloc.add(OnboardingFullNameChanged(v)),
                    ),
                    18.vGap,
                    AppTextField(
                      label: 'Age',
                      hintText: 'Years (e.g. 28)',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      initialValue: state.age,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: _validateAge,
                      onChanged: (v) => bloc.add(OnboardingAgeChanged(v)),
                    ),
                    18.vGap,
                    Text(
                      'Gender',
                      style: AppTypography.labelMedium.copyWith(
                        color: colors.onSurface,
                      ),
                    ),
                    6.vGap,
                    OnboardingSegmentedControl<OnboardingGender>(
                      value: state.gender,
                      options: const [
                        (OnboardingGender.male, 'Male'),
                        (OnboardingGender.female, 'Female'),
                        (OnboardingGender.other, 'Other'),
                      ],
                      onChanged: (v) => bloc.add(OnboardingGenderChanged(v)),
                    ),

                    18.vGap,
                  ],
                ),
              ),

              30.vGap,
              AppButton(
                label: 'Continue',
                onPressed: state.isIdentityStepValid
                    ? () => bloc.add(const OnboardingNextRequested())
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  String? _validateFullName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Full name is required';
    if (name.length < 3) return 'Full name must be at least 3 characters';
    if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(name)) {
      return 'Full name can only contain letters';
    }
    return null;
  }

  String? _validateAge(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return 'Age is required';
    final age = int.tryParse(raw);
    if (age == null) return 'Enter a valid age';
    if (age < 18 || age > 100) return 'Age must be between 18 and 100';
    return null;
  }
}
