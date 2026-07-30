import 'package:flutter/material.dart';

/// Paleta central de la app. TODO EL COLOR VIVE AQUÍ.
class AppColors {
  AppColors._();

  // Marca — se usa con moderación (botón principal, nav activo, links clave)
  static const Color primary = Color(0xFF15803D); // Verde, un poco más oscuro/sobrio
  static const Color primaryDark = Color(0xFF166534);
  static const Color primaryLight = Color(0xFFDCFCE7); // fondo pastel para chips/badges
  static const Color primaryGradientStart = Color(0xFF16A34A);
  static const Color primaryGradientEnd = Color(0xFF14532D);
  static const Color secondary = Color(0xFFF59E0B);

  // Fondos — más contraste entre fondo de pantalla y superficie de tarjeta
  static const Color background = Color(0xFFF3F4F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF9FAFB);
  static const Color surfaceInput = Color(0xFFF1F3F5); // fondo de inputs, con borde para contraste

  // Texto
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Estados de suscripción (sección 9 de la documentación)
  static const Color statusActivo = Color(0xFF16A34A);
  static const Color statusGracia = Color(0xFFF59E0B);
  static const Color statusSuspendido = Color(0xFFDC2626);
  static const Color statusCancelado = Color(0xFF9CA3AF);

  // Semánticos genéricos
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color divider = Color(0xFFE5E7EB);

  // Paleta de "chips" de color pastel, usada en accesos rápidos / iconos
  // de categoría para dar variedad visual sin recurrir solo al verde.
  static const Color chipBlue = Color(0xFF2563EB);
  static const Color chipBlueBg = Color(0xFFDBEAFE);
  static const Color chipPurple = Color(0xFF7C3AED);
  static const Color chipPurpleBg = Color(0xFFEDE9FE);
  static const Color chipOrange = Color(0xFFEA580C);
  static const Color chipOrangeBg = Color(0xFFFFEDD5);
  static const Color chipTeal = Color(0xFF0D9488);
  static const Color chipTealBg = Color(0xFFCCFBF1);
  static const Color chipPink = Color(0xFFDB2777);
  static const Color chipPinkBg = Color(0xFFFCE7F3);
  static const Color chipGreen = Color(0xFF15803D);
  static const Color chipGreenBg = Color(0xFFDCFCE7);
}
