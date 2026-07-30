import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

/// Pantalla de arranque con la identidad de marca, mostrada mientras
/// SessionGate resuelve la sesión y el estado de la tienda. Reemplaza
/// el spinner pelón sobre fondo blanco que se veía antes.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 88,
              width: 88,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(Icons.storefront, color: Colors.green.shade700, size: 44),
            ),
            const SizedBox(height: AppSizes.lg),
            Text(
              'POS Tienda',
              style: AppTextStyles.h1.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSizes.xs),
            Text(
              'Administra tu negocio desde tu celular',
              style: AppTextStyles.bodySecondary.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: AppSizes.xxl),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
