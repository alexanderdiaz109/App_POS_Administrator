import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Roles disponibles en el multiusuario (Plan Premium, sección 1.1).
enum UserRole { cajero, administrador }

extension UserRoleX on UserRole {
  String get etiqueta {
    switch (this) {
      case UserRole.cajero:
        return 'Cajero';
      case UserRole.administrador:
        return 'Administrador';
    }
  }

  Color get color {
    switch (this) {
      case UserRole.cajero:
        return AppColors.primary;
      case UserRole.administrador:
        return AppColors.secondary;
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.cajero:
        return Icons.point_of_sale_outlined;
      case UserRole.administrador:
        return Icons.admin_panel_settings_outlined;
    }
  }
}
