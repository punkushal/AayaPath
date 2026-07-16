part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Advances to the next step. No-ops if the current step fails validation.
class OnboardingNextRequested extends OnboardingEvent {
  const OnboardingNextRequested();
}

/// Returns to the previous step. No-ops on the first step.
class OnboardingBackRequested extends OnboardingEvent {
  const OnboardingBackRequested();
}

/// Jumps directly to [step], e.g. via the bottom nav. Only allowed for
/// steps already reached, so a user can't skip ahead of unfinished forms.
class OnboardingStepTapped extends OnboardingEvent {
  const OnboardingStepTapped(this.step);

  final int step;

  @override
  List<Object?> get props => [step];
}

class OnboardingFullNameChanged extends OnboardingEvent {
  const OnboardingFullNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class OnboardingAgeChanged extends OnboardingEvent {
  const OnboardingAgeChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class OnboardingGenderChanged extends OnboardingEvent {
  const OnboardingGenderChanged(this.value);

  final OnboardingGender value;

  @override
  List<Object?> get props => [value];
}

class OnboardingProvinceChanged extends OnboardingEvent {
  const OnboardingProvinceChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class OnboardingDistrictChanged extends OnboardingEvent {
  const OnboardingDistrictChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class OnboardingOccupationChanged extends OnboardingEvent {
  const OnboardingOccupationChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class OnboardingIncomeSourceChanged extends OnboardingEvent {
  const OnboardingIncomeSourceChanged(this.value);

  final OnboardingIncomeSource value;

  @override
  List<Object?> get props => [value];
}

class OnboardingMonthlyIncomeChanged extends OnboardingEvent {
  const OnboardingMonthlyIncomeChanged(this.value);

  final double value;

  @override
  List<Object?> get props => [value];
}

class OnboardingGoalToggled extends OnboardingEvent {
  const OnboardingGoalToggled(this.goal);

  final OnboardingFinancialGoal goal;

  @override
  List<Object?> get props => [goal];
}

class OnboardingTargetAmountChanged extends OnboardingEvent {
  const OnboardingTargetAmountChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class OnboardingTimeframeChanged extends OnboardingEvent {
  const OnboardingTimeframeChanged(this.value);

  final double value;

  @override
  List<Object?> get props => [value];
}

class OnboardingSubmitted extends OnboardingEvent {
  const OnboardingSubmitted();
}
