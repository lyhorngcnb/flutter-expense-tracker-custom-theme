// ==================== 2. custom_text_field.dart ====================
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomTextField({
    Key? key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      validator: widget.validator,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      cursorColor: Theme.of(context).colorScheme.primary,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
          icon: Icon(widget.suffixIcon),
          onPressed: widget.onSuffixTap,
        )
            : null,
      ),
    );
  }
}
