import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/primary_button.dart';

/// Confirmación tras cancelar la suscripción (sección 4.5). Refuerza que
/// los datos se conservan 90 días y da la salida a la app.
class CancellationConfirmedScreen extends StatelessWidget {
  const CancellationConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.event_available_outlined, size: 72, color: AppColors.textSecondary),
              const SizedBox(height: AppSizes.lg),
              const Text('Suscripción cancelada', style: AppTextStyles.h1, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.sm),
              const Text(
                'Tu acceso seguirá activo hasta el final del periodo ya pagado. '
                'Tus datos se conservan 90 días por si decides regresar.',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.xl),
              PrimaryButton(
                label: 'Reactivar suscripción',
                onPressed: () => Navigator.of(context).pushNamed(RouteNames.changePlan),
              ),
              const SizedBox(height: AppSizes.sm),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.mainShell,
                  (_) => false,
                ),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
