import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Prevent instantiation

  // =====================
  // Primary Brand Colors
  // =====================
  static const Color primary = Color(0xFF1565C0); // ICU Blue
  static const Color primaryLight = Color(0xFF5E92F3);
  static const Color primaryDark = Color(0xFF003C8F);

  // =====================
  // Secondary / Accent
  // =====================
  static const Color secondary = Color(0xFF2E7D32); // Medical Green
  static const Color secondaryLight = Color(0xFF60AD5E);
  static const Color secondaryDark = Color(0xFF005005);

  // =====================
  // Status Colors
  // =====================
  static const Color success = Color(0xFF2E7D32); // Pass Approved
  static const Color warning = Color(0xFFF9A825); // Time Almost Over
  static const Color error = Color(0xFFC62828);   // Pass Expired / Denied
  static const Color info = Color(0xFF0277BD);    // Info messages

  // =====================
  // Background Colors
  // =====================
  static const Color scaffoldBackground = Color(0xFFF5F7FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color dialogBackground = Color(0xFFFFFFFF);

  // =====================
  // Text Colors
  // =====================
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6E6E73);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // =====================
  // Border & Divider
  // =====================
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE5E7EB);

  // =====================
  // Button Colors
  // =====================
  static const Color buttonPrimary = primary;
  static const Color buttonDisabled = Color(0xFFBDBDBD);

  // =====================
  // QR / Pass Status
  // =====================
  static const Color passActive = Color(0xFF2E7D32);
  static const Color passExpired = Color(0xFFC62828);
  static const Color passPending = Color(0xFFF9A825);

  // =====================
  // Shadows
  // =====================
  static const Color shadow = Color(0x1A000000); // 10% Black
}
