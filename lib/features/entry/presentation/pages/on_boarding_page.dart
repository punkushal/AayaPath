import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/storage/app_preferences.dart';
import 'package:aayapath/features/entry/presentation/bloc/onboarding_bloc.dart';
import 'package:aayapath/features/entry/presentation/widgets/steps/finalize_step.dart';
import 'package:aayapath/features/entry/presentation/widgets/steps/identity_step.dart';
import 'package:aayapath/features/entry/presentation/widgets/steps/income_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(AppPreferences()),
      child: const _OnBoardingView(),
    );
  }
}

class _OnBoardingView extends StatelessWidget {
  const _OnBoardingView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      buildWhen: (previous, current) =>
          previous.currentStep != current.currentStep,
      builder: (context, state) {
        return PopScope(
          canPop: state.currentStep == 0,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && state.currentStep != 0) {
              context.read<OnboardingBloc>().add(
                const OnboardingBackRequested(),
              );
            }
          },
          child: Scaffold(
            appBar: _OnboardingTopBar(currentStep: state.currentStep),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.03, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey(state.currentStep),
                child: switch (state.currentStep) {
                  0 => const IdentityStep(),
                  1 => const IncomeStep(),
                  _ => const FinalizeStep(),
                },
              ),
            ),
            // bottomNavigationBar: const OnboardingBottomNav(),
          ),
        );
      },
    );
  }
}

class _OnboardingTopBar extends StatelessWidget implements PreferredSizeWidget {
  const _OnboardingTopBar({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: currentStep == 0
          ? null
          : IconButton(
              icon: Icon(Icons.arrow_back, size: 20.r),
              onPressed: () => context.read<OnboardingBloc>().add(
                const OnboardingBackRequested(),
              ),
            ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
