import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final bool isActive;
  final String activeText;
  final String inactiveText;

  const StatusIndicator({
    Key? key,
    required this.isActive,
    this.activeText = "Running",
    this.inactiveText = "Stopped",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color baseColor = isActive ? Colors.green : Colors.grey;
    final String text = isActive ? activeText : inactiveText;
    final IconData icon =
    isActive ? Icons.check_circle_rounded : Icons.pause_circle;

    return Container(
      padding: const EdgeInsets.all(2), // outer layer
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            baseColor.withOpacity(0.4),
            baseColor.withOpacity(0.1),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon Bubble
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 16,
                color: baseColor,
              ),
            ),

            const SizedBox(width: 8),

            // Text
            Text(
              text,
              style: TextStyle(
                color: baseColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}