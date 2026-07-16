import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:flutter/material.dart';

/// Labelled dropdown styled to match [AppTextField], used for the Province
/// and District pickers on the Personal Identity step.
class OnboardingDropdownField extends StatelessWidget {
  const OnboardingDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(color: colors.onSurface),
        ),
        6.vGap,
        DropdownButtonFormField<String>(
          initialValue: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, size: 20.r),
          style: AppTypography.bodyMedium.copyWith(color: colors.onSurface),
          decoration: InputDecoration(hintText: hint),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }
}
