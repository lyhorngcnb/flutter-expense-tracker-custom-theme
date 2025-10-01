// ==================== 14. list_tile_widget.dart ====================
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? leadingIcon;
  final Widget? leading;
  final IconData? trailingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.leading,
    this.trailingIcon,
    this.trailing,
    this.onTap,
    this.tileColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      leading: leading ?? (leadingIcon != null ? Icon(leadingIcon) : null),
      trailing: trailing ?? (trailingIcon != null ? Icon(trailingIcon) : null),
      onTap: onTap,
      tileColor: tileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
