import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  // ====== DATA ======
  final String title;
  final String subtitle;

  // ====== ACTIONS ======
  final VoidCallback? onCardTap;
  final VoidCallback? onActionTap;

  // ====== VISIBILITY ======
  final bool showActionButton;

  // ====== LEADING ======
  final IconData leadingIcon;
  final Color accentColor;

  // ====== TEXT STYLE ======
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  // ====== BUTTON ======
  final String actionText;
  final IconData actionIcon;

  const ListCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onCardTap,
    this.onActionTap,
    this.showActionButton = true,

    this.leadingIcon = Icons.local_hospital_rounded,
    this.accentColor = Colors.blue,

    this.titleStyle,
    this.subtitleStyle,

    this.actionText = "QR PDF",
    this.actionIcon = Icons.qr_code_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onCardTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ===== LEADING ICON =====
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accentColor.withOpacity(.15),
                      accentColor.withOpacity(.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  leadingIcon,
                  color: accentColor,
                  size: 26,
                ),
              ),

              const SizedBox(width: 14),

              // ===== TEXT CONTENT =====
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle ??
                          const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: subtitleStyle ??
                          TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),

              // ===== ACTION CHIP =====
              if (showActionButton)
                GestureDetector(
                  onTap: onActionTap,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          actionIcon,
                          size: 18,
                          color: accentColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          actionText,
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}