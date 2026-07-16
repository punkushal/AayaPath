part of 'onboarding_bloc.dart';

/// Total number of steps in the wizard. Kept next to the state so widgets
/// and the bloc always agree on it.
const int kOnboardingTotalSteps = 3;

enum OnboardingGender { male, female, other }

enum OnboardingIncomeSource {
  employee,
  freelancer,
  business,
  student,
  government,
}

enum OnboardingFinancialGoal {
  emergencyFund,
  home,
  education,
  retirement,
  travel,
  vehicle,
  wedding,
  businessCapital,
}

enum OnboardingStatus { inProgress, submitting, complete }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.currentStep = 0,
    this.furthestStepReached = 0,
    this.fullName = '',
    this.age = '',
    this.gender = OnboardingGender.male,
    this.province,
    this.district,
    this.incomeSource = OnboardingIncomeSource.employee,
    this.monthlyIncome = 25000,
    this.status = OnboardingStatus.inProgress,
  });

  final int currentStep;
  final int furthestStepReached;

  // Step 1 — Identity
  final String fullName;
  final String age;
  final OnboardingGender gender;
  final String? province;
  final String? district;

  // Step 2 — Income
  final OnboardingIncomeSource incomeSource;
  final double monthlyIncome;

  // Step 3 — Finalize
  final OnboardingStatus status;

  bool get isIdentityStepValid =>
      fullName.trim().isNotEmpty && age.trim().isNotEmpty;

  bool get isIncomeStepValid => monthlyIncome >= 5000;

  bool get isCurrentStepValid => switch (currentStep) {
    0 => isIdentityStepValid,
    1 => isIncomeStepValid,
    _ => true,
  };

  double get annualIncome => monthlyIncome * 12;

  /// Deterministic 0-100 "financial reliability" heuristic driven by income
  /// source stability and monthly income tier — purely presentational, used
  /// to power the Income Preview card.
  int get financialReliabilityScore {
    final sourceBonus = switch (incomeSource) {
      OnboardingIncomeSource.government => 30,
      OnboardingIncomeSource.employee => 25,
      OnboardingIncomeSource.business => 18,
      OnboardingIncomeSource.freelancer => 10,
      OnboardingIncomeSource.student => 5,
    };
    final incomeBonus = (monthlyIncome / 1000000 * 40).clamp(0, 40).round();
    return (30 + sourceBonus + incomeBonus).clamp(0, 100);
  }

  OnboardingState copyWith({
    int? currentStep,
    int? furthestStepReached,
    String? fullName,
    String? age,
    OnboardingGender? gender,
    String? province,
    String? district,
    OnboardingIncomeSource? incomeSource,
    double? monthlyIncome,
    OnboardingStatus? status,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      furthestStepReached: furthestStepReached ?? this.furthestStepReached,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      province: province ?? this.province,
      district: district ?? this.district,
      incomeSource: incomeSource ?? this.incomeSource,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      status: status ?? this.status,
    );
  }

  /// Clears [district] — used whenever [province] changes, since the
  /// previously picked district almost certainly doesn't belong to the
  /// new province.
  OnboardingState copyWithProvince(String province) {
    return OnboardingState(
      currentStep: currentStep,
      furthestStepReached: furthestStepReached,
      fullName: fullName,
      age: age,
      gender: gender,
      province: province,
      district: null,
      incomeSource: incomeSource,
      monthlyIncome: monthlyIncome,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    furthestStepReached,
    fullName,
    age,
    gender,
    province,
    district,
    incomeSource,
    monthlyIncome,
    status,
  ];
}
