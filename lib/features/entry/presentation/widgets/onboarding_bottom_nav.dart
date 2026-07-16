import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:aayapath/features/entry/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _OnboardingTab {
  const _OnboardingTab(this.icon, this.label);
  final IconData icon;
  final String label;
}

const _tabs = [
  _OnboardingTab(Icons.person_outline, 'Identity'),
  _OnboardingTab(Icons.account_balance_wallet_outlined, 'Income'),
  _OnboardingTab(Icons.flag_outlined, 'Goals'),
  _OnboardingTab(Icons.verified_outlined, 'Finalize'),
];

/// Bottom tab bar mirroring the 4 wizard steps, styled after the
/// icon+label+active-dot nav shown on the Personal Identity screen. Tapping
/// a tab jumps to that step, but only if it has already been reached.
class OnboardingBottomNav extends StatelessWidget {
  const OnboardingBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64.h,
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final tab = _tabs[index];
                  final isActive = index == state.currentStep;
                  final isEnabled = index <= state.furthestStepReached;

                  return Expanded(
                    child: InkWell(
                      onTap: isEnabled
                          ? () => context.read<OnboardingBloc>().add(
                              OnboardingStepTapped(index),
                            )
                          : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            tab.icon,
                            size: 22.r,
                            color: isActive
                                ? colors.primary
                                : isEnabled
                                ? Theme.of(context).iconTheme.color
                                : Theme.of(context).disabledColor,
                          ),
                          4.vGap,
                          Text(
                            tab.label,
                            style: AppTypography.labelSmall.copyWith(
                              color: isActive
                                  ? colors.primary
                                  : isEnabled
                                  ? AppTypography.labelSmall.color
                                  : Theme.of(context).disabledColor,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                          3.vGap,
                          Container(
                            height: 4.r,
                            width: 4.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? colors.primary
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
