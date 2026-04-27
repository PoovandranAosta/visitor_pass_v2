import 'package:flutter/material.dart';
import 'package:visitor_pass_v2/config/app_colors.dart';

/// ================= FULLY CUSTOMIZABLE REUSABLE DRAWER =================
class CustomDrawer extends StatelessWidget {
  // Header customization
  final String headerTitle;
  final String headerSubtitle;
  final Widget? headerAvatar;
  final Gradient? headerGradient;
  final double headerHeight;

  // Drawer styling
  final double borderRadius;
  final Color backgroundColor;
  final double drawerWidth;

  // Scan Qr item customization
  final String scanQrTitle;
  final String scanQrSubtitle;
  final IconData scanQrIcon;
  final VoidCallback? onScanQrTap;

  // CheckIn item customization
  final String checkInTitle;
  final String checkInSubtitle;
  final IconData checkInIcon;
  final VoidCallback? onCheckInTap;

  // CheckOut item customization
  final String checkOutTitle;
  final String checkOutSubtitle;
  final IconData checkOutIcon;
  final VoidCallback? onCheckOutTap;

  // Exit item customization
  final String exitListTitle;
  final String exitListSubtitle;
  final IconData exitListIcon;
  final VoidCallback? onExitListTap;

  // Visitor item customization
  final String visitorListTitle;
  final String visitorListSubtitle;
  final IconData visitorListIcon;
  final VoidCallback? onVisitorListTap;

  // Visitor Entry item customization
  final String vistitorEntryTitle;
  final String visitorEntrySubtitle;
  final IconData visitorEntryIcon;
  final VoidCallback? onVisitorEntryTap;

  // Visitor Summary Report item customization
  final String summaryReportTitle;
  final String summaryReportSubtitle;
  final IconData summaryReportIcon;
  final VoidCallback? onSummaryReportTap;

  // Logout customization
  final String logoutTitle;
  final String logoutSubtitle;
  final IconData logoutIcon;
  final VoidCallback? onLogoutTap;

  // Tile styling
  final Color iconBackgroundColor;
  final Color iconColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final IconData trailingIcon;

  final bool isSecurity;

  final bool isAdmin;

  // Footer
  final Widget? footer;

  const CustomDrawer({
    super.key,

    // Header defaults
    this.headerTitle = 'Control Panel',
    this.headerSubtitle = 'Welcome',
    this.headerAvatar,
    this.headerGradient,
    this.headerHeight = 140,

    // Drawer defaults
    this.borderRadius = 22,
    this.backgroundColor = Colors.white,
    this.drawerWidth = 300,

    // Scan defaults
    this.scanQrTitle = '',
    this.scanQrSubtitle = '',
    this.scanQrIcon = Icons.qr_code_scanner_rounded,
    this.onScanQrTap,

    // CheckIn defaults
    this.checkInTitle = '',
    this.checkInSubtitle = '',
    this.checkInIcon = Icons.check_circle,
    this.onCheckInTap,

    // CheckOut defaults
    this.checkOutTitle = '',
    this.checkOutSubtitle = '',
    this.checkOutIcon = Icons.outbound_outlined,
    this.onCheckOutTap,

    // VisitorList defaults
    this.exitListTitle = '',
    this.exitListSubtitle = '',
    this.exitListIcon = Icons.exit_to_app_rounded,
    this.onExitListTap,

    // VisitorList defaults
    this.visitorListTitle = '',
    this.visitorListSubtitle = '',
    this.visitorListIcon = Icons.checklist_outlined,
    this.onVisitorListTap,

    // Visitor Entry Form
    this.vistitorEntryTitle = '',
    this.visitorEntrySubtitle = '',
    this.visitorEntryIcon = Icons.file_copy_rounded,
    this.onVisitorEntryTap,

    // Summary Report
    this.summaryReportTitle = '',
    this.summaryReportSubtitle = '',
    this.summaryReportIcon = Icons.summarize_outlined,
    this.onSummaryReportTap,

    // log Out defaults
    this.logoutTitle = '',
    this.logoutSubtitle = '',
    this.logoutIcon = Icons.logout_rounded,
    this.onLogoutTap,

    // Tile defaults
    this.iconBackgroundColor = const Color(0x1A2196F3),
    this.iconColor = Colors.blue,
    this.titleStyle,
    this.subtitleStyle,
    this.trailingIcon = Icons.arrow_forward_ios_rounded,

    required this.isSecurity,
    required this.isAdmin,

    // Footer
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: drawerWidth,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (scanQrTitle != '') ...[
                    _buildTile(
                      context,
                      icon: scanQrIcon,
                      title: scanQrTitle,
                      subtitle: scanQrSubtitle,
                      onTap: onScanQrTap,
                    ),
                  ],
                  Divider(),
                  if (checkInTitle != '') ...[
                    _buildTile(
                      context,
                      icon: checkInIcon,
                      title: checkInTitle,
                      subtitle: checkInSubtitle,
                      onTap: onCheckInTap,
                    ),
                  ],
                  if (checkOutTitle != '') ...[
                    _buildTile(
                      context,
                      icon: checkOutIcon,
                      title: checkOutTitle,
                      subtitle: checkOutSubtitle,
                      onTap: onCheckOutTap,
                    ),
                  ],
                  if (exitListTitle != '') ...[
                    _buildTile(
                      context,
                      icon: exitListIcon,
                      title: exitListTitle,
                      subtitle: exitListSubtitle,
                      onTap: onExitListTap,
                    ),
                  ],
                  if (visitorListTitle != '') ...[
                    _buildTile(
                      context,
                      icon: visitorListIcon,
                      title: visitorListTitle,
                      subtitle: visitorListSubtitle,
                      onTap: onVisitorListTap,
                    ),
                  ],

                  if (vistitorEntryTitle != '') ...[
                    _buildTile(
                      context,
                      icon: visitorEntryIcon,
                      title: vistitorEntryTitle,
                      subtitle: visitorEntrySubtitle,
                      onTap: onVisitorEntryTap,
                    ),
                  ],
                  if (summaryReportTitle != '') ...[
                    _buildTile(
                      context,
                      icon: summaryReportIcon,
                      title: summaryReportTitle,
                      subtitle: summaryReportSubtitle,
                      onTap: onSummaryReportTap,
                    ),
                  ],
                  Divider(),
                  if (logoutTitle != '') ...[
                    _buildTile(
                      context,
                      icon: logoutIcon,
                      title: logoutTitle,
                      subtitle: logoutSubtitle,
                      onTap: onLogoutTap,
                    ),
                  ],
                  Divider(),
                ],
              ),
            ),
          ),

          // const Spacer(),
          if (footer != null) footer!,
        ],
      ),
    );
  }

  /// ================= HEADER =================
  Widget _buildHeader(BuildContext context) {
    return Container(
      height: headerHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(color: AppColors.primary),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headerAvatar ??
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person_rounded, size: 30),
              ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerSubtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 6),
              Text(
                headerTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= TILE =================
  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: iconBackgroundColor,
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style:
            titleStyle ??
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: subtitleStyle ?? const TextStyle(fontSize: 13),
      ),
      trailing: Icon(trailingIcon, size: 16),
      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
    );
  }
}
