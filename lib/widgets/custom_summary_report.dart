import 'package:flutter/material.dart';

import '../models/summary_report_model.dart';

class SummaryReportCard extends StatelessWidget {
  final SummaryReportModel data;

  // Actions
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  // UI Controls
  final bool showActionButton;
  final String actionText;
  final IconData actionIcon;

  final Color primaryColor;

  const SummaryReportCard({
    super.key,
    required this.data,
    this.onTap,
    this.onActionTap,
    this.showActionButton = true,
    this.actionText = "View",
    this.actionIcon = Icons.visibility,
    this.primaryColor = Colors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER =====
            Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(.15),
                        primaryColor.withOpacity(.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.business,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    data.companyName ?? "Unknown Company",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                if (showActionButton)
                  _actionButton(),
              ],
            ),

            const SizedBox(height: 14),

            // ===== STATS =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statItem("Visitors", data.visitorCount, Colors.blue),
                _statItem("CheckOut", data.checkOutCount, Colors.orange),
                _statItem("Exit", data.exitCount, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===== ACTION BUTTON =====
  Widget _actionButton() {
    return GestureDetector(
      onTap: onActionTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(actionIcon, size: 16, color: primaryColor),
            const SizedBox(width: 4),
            Text(
              actionText,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== STAT ITEM =====
  Widget _statItem(String label, int? value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              "${value ?? 0}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}