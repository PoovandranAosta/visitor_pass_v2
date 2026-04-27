import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool isEnabled;

  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? textColor;
  final Color? loaderColor;

  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? contentPadding;
  final BorderSide? border;
  final Widget? icon;
  final Widget? sufIcon;
  final MainAxisAlignment? contentAlignment;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.disabledColor,
    this.textColor,
    this.loaderColor,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.contentPadding,
    this.border,
    this.icon,
    this.sufIcon,
    this.contentAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = isEnabled && !isLoading;

    return ElevatedButton(
      onPressed: isButtonEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        disabledBackgroundColor:
            disabledColor ?? AppColors.primary.withOpacity(0.4),
        elevation: elevation ?? 2,
        padding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        // minimumSize: (width != null || height != null)
        //     ? Size(width ?? 0, height ?? 0)
        //     : null,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          side: border ?? BorderSide.none,
        ),
      ),

      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  loaderColor ?? Colors.white,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: contentAlignment ?? MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8)],
                Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (sufIcon != null) ...[const SizedBox(width: 8), sufIcon!],
              ],
            ),
    );
  }
}
