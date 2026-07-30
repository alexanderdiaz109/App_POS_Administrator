import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

/// Banner de días restantes de prueba gratuita (15 días, sección 4.1).
/// Se muestra en Dashboard y en Mi Cuenta mientras `estadoPago == prueba`.
class TrialBanner extends StatelessWidget {
  final int diasRestantes;
  final VoidCallback? onTap;

  const TrialBanner({super.key, required this.diasRestantes, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        child: Row(
          children: [
            const Icon(Icons.rocket_launch_outlined, color: Colors.white),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diasRestantes > 0
                        ? 'Te quedan $diasRestantes días de prueba gratis'
                        : 'Tu prueba gratuita termina hoy',
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Agrega tu método de pago para no perder acceso',
                    style: AppTextStyles.caption.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
