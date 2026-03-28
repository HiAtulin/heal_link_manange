import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color accent = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF06B6D4);

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successText = Color(0xFF065F46);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningText = Color(0xFF92400E);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorText = Color(0xFF991B1B);
  static const Color infoLight = Color(0xFFE0F2FE);
  static const Color infoText = Color(0xFF075985);

  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static LinearGradient get surfaceGradient => const LinearGradient(
        colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
