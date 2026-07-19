import 'package:aayapath/core/storage/app_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

/// Drives the whole 3-step onboarding wizard (Identity, Income,
/// Finalize) with a single shared state so the step header, bottom nav and
/// review step can all agree on progress and collected data.
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AppPreferences preferences;
  OnboardingBloc(this.preferences) : super(const OnboardingState()) {
    on<OnboardingNextRequested>(_onNextRequested);
    on<OnboardingBackRequested>(_onBackRequested);
    on<OnboardingStepTapped>(_onStepTapped);
    on<OnboardingFullNameChanged>(
      (event, emit) => emit(state.copyWith(fullName: event.value)),
    );
    on<OnboardingAgeChanged>(
      (event, emit) => emit(state.copyWith(age: event.value)),
    );
    on<OnboardingGenderChanged>(
      (event, emit) => emit(state.copyWith(gender: event.value)),
    );
    on<OnboardingProvinceChanged>(
      (event, emit) => emit(state.copyWithProvince(event.value)),
    );
    on<OnboardingDistrictChanged>(
      (event, emit) => emit(state.copyWith(district: event.value)),
    );

    on<OnboardingIncomeSourceChanged>(
      (event, emit) => emit(state.copyWith(incomeSource: event.value)),
    );
    on<OnboardingMonthlyIncomeChanged>(
      (event, emit) => emit(state.copyWith(monthlyIncome: event.value)),
    );

    on<OnboardingSubmitted>(_onSubmitted);
  }

  void _onNextRequested(
    OnboardingNextRequested event,
    Emitter<OnboardingState> emit,
  ) {
    if (!state.isCurrentStepValid) return;
    if (state.currentStep >= kOnboardingTotalSteps - 1) return;
    final next = state.currentStep + 1;
    emit(
      state.copyWith(
        currentStep: next,
        furthestStepReached: next > state.furthestStepReached
            ? next
            : state.furthestStepReached,
      ),
    );
  }

  void _onBackRequested(
    OnboardingBackRequested event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.currentStep == 0) return;
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  void _onStepTapped(
    OnboardingStepTapped event,
    Emitter<OnboardingState> emit,
  ) {
    if (event.step < 0 || event.step > state.furthestStepReached) return;
    emit(state.copyWith(currentStep: event.step));
  }

  Future<void> _onSubmitted(
    OnboardingSubmitted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(status: OnboardingStatus.submitting));
    await Future<void>.delayed(const Duration(milliseconds: 900));
    emit(state.copyWith(status: OnboardingStatus.complete));
    await preferences.setOnboardingCompleted(true);
  }
}
