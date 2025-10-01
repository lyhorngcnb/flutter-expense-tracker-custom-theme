// ==================== 11. search_bar_widget.dart ====================
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Function(String)? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final bool readOnly;

  const SearchBarWidget({
    Key? key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onClear,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller?.text.isNotEmpty ?? false
            ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: onClear,
        )
            : null,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}