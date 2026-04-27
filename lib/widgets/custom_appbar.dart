import 'package:flutter/material.dart';
import 'package:visitor_pass_v2/config/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final double height;
  final PreferredSizeWidget? bottom;
  final Gradient? gradient;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation = 0,
    this.height = kToolbarHeight,
    this.bottom,
    this.gradient,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: gradient != null
          ? Colors.transparent
          : backgroundColor ?? AppColors.primaryDark,
      flexibleSpace: gradient != null
          ? Container(
        decoration: BoxDecoration(gradient: gradient),
      )
          : null,
      leading: leading,
      title: titleWidget ??
          Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.scaffoldBackground
            ),
          ),
      actions: actions,
      bottom: bottom,
    );
  }
}
