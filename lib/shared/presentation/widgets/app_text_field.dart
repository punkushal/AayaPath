import 'package:aayapath/core/extension/responsive_extension.dart';
import 'package:aayapath/core/theme/app_typograhpy.dart';
import 'package:flutter/material.dart';

/// Reusable text input. Wraps [TextFormField] so every screen picks up the
/// styling already defined in [AppTheme]'s `inputDecorationTheme`, and adds
/// an optional label above the field plus a built-in obscure-text toggle
/// for password fields.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hintText,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.autofocus = false,
    this.focusNode,
    this.autovalidateMode,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;

  /// Ignored when [obscureText] is true — the field shows its own
  /// show/hide-password toggle in that case instead.
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final int maxLines;
  final bool autofocus;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.labelMedium.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          6.vGap,
        ],
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          enabled: widget.enabled,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          autofocus: widget.autofocus,
          focusNode: widget.focusNode,
          style: AppTypography.bodyMedium.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, size: 20.r),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      size: 20.r,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
