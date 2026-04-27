import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  // ===== CONTENT =====
  final String title;
  final String message;

  // ===== ICON =====
  final IconData icon;
  final double iconSize;
  final double iconRadius;
  final Color iconColor;
  final Color iconBgColor;

  // ===== TEXT STYLES =====
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  // ===== BUTTONS =====
  final String primaryText;
  final VoidCallback onPrimaryTap;
  final bool primaryLoading;
  final Color primaryColor;
  final Color primaryTextColor;

  final String? secondaryText;
  final VoidCallback? onSecondaryTap;
  final Color secondaryColor;
  final Color secondaryTextColor;

  // ===== UI =====
  final bool barrierDismissible;
  final bool showCloseIcon;
  final double borderRadius;
  final double maxWidth;
  final EdgeInsets contentPadding;
  final double buttonHeight;
  final double buttonRadius;
  final double spacing;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.primaryText,
    required this.onPrimaryTap,

    // ICON
    this.iconSize = 28,
    this.iconRadius = 28,
    this.iconColor = Colors.white,
    this.iconBgColor = Colors.blue,

    // TEXT
    this.titleStyle,
    this.messageStyle,

    // BUTTONS
    this.primaryLoading = false,
    this.primaryColor = AppColors.primary,
    this.primaryTextColor = Colors.white,
    this.secondaryText,
    this.onSecondaryTap,
    this.secondaryColor = Colors.grey,
    this.secondaryTextColor = Colors.black87,

    // UI
    this.borderRadius = 18,
    this.barrierDismissible = false,
    this.showCloseIcon = false,
    this.maxWidth = 420,
    this.buttonHeight = 46,
    this.buttonRadius = 12,
    this.spacing = 16,
    this.contentPadding = const EdgeInsets.all(20),
  });

  // ===== SHOW METHOD =====
  static void show(
      BuildContext context, {
        required String title,
        required String message,
        required IconData icon,
        required String primaryText,
        required VoidCallback onPrimaryTap,
        String? secondaryText,
        VoidCallback? onSecondaryTap,
        Color iconBgColor = Colors.blue,
        bool barrierDismissible = false,
      }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => CustomAlertDialog(
        title: title,
        message: message,
        icon: icon,
        primaryText: primaryText,
        onPrimaryTap: onPrimaryTap,
        secondaryText: secondaryText,
        onSecondaryTap: onSecondaryTap,
        iconBgColor: iconBgColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: contentPadding,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===== ICON =====
                  CircleAvatar(
                    radius: iconRadius,
                    backgroundColor: iconBgColor,
                    child: Icon(icon, color: iconColor, size: iconSize),
                  ),

                  SizedBox(height: spacing),

                  // ===== TITLE =====
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: titleStyle ??
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),

                  const SizedBox(height: 8),

                  // ===== MESSAGE =====
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: messageStyle ??
                        const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                  ),

                  SizedBox(height: spacing + 8),

                  // ===== BUTTONS =====
                  isSmallScreen
                      ? Column(children: _buildButtons(context, vertical: true))
                      : Row(children: _buildButtons(context)),
                ],
              ),

              // ===== CLOSE ICON =====
              if (showCloseIcon)
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtons(BuildContext context, {bool vertical = false}) {
    return [
      if (secondaryText != null)
        Expanded(
          flex: vertical ? 0 : 1,
          child: SizedBox(
            height: buttonHeight,
            child: OutlinedButton(
              onPressed: onSecondaryTap ?? () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: secondaryTextColor,
                side: BorderSide(color: secondaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(buttonRadius),
                ),
              ),
              child: Text(secondaryText!),
            ),
          ),
        ),
      if (secondaryText != null)
        SizedBox(height: vertical ? 12 : 0, width: vertical ? 0 : 12),
      Expanded(
        flex: vertical ? 0 : 1,
        child: SizedBox(
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: primaryLoading ? null : onPrimaryTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: primaryTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
              ),
            ),
            child: primaryLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(primaryText),
          ),
        ),
      ),
    ];
  }
}