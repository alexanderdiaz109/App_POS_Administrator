import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/providers/store_providers.dart';

class SuspendedScreen extends ConsumerWidget {
  const SuspendedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.pause_circle_outline, size: 80, color: AppColors.statusSuspendido),
              const SizedBox(height: AppSizes.lg),
              Text('Servicio pausado', style: AppTextStyles.h1, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.sm),
              Text(
                'No pudimos procesar tu último pago y el periodo de gracia '
                'terminó. Actualiza tu método de pago para reactivar tu tienda.',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.xl),
              PrimaryButton(
                label: 'Actualizar método de pago',
                onPressed: () => Navigator.of(context).pushNamed(RouteNames.updatePaymentMethod),
              ),
              const SizedBox(height: AppSizes.sm),
              TextButton(
                onPressed: () {
                  ref.invalidate(currentStoreProvider);
                  Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.login, (_) => false);
                },
                child: const Text('Ya regularicé mi pago, verificar de nuevo'),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Tus datos están seguros y no se eliminan mientras regularizas tu pago.',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
