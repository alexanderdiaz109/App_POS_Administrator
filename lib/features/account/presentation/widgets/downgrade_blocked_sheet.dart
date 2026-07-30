import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Bloqueo de downgrade (sección 8.2): cuando el uso actual excede los
/// límites del plan destino, se muestra qué debe desactivarse primero.
class DowngradeBlockedSheet extends StatelessWidget {
  final String planDestino;
  final List<String> limitesExcedidos;

  const DowngradeBlockedSheet({
    super.key,
    required this.planDestino,
    required this.limitesExcedidos,
  });

  static Future<void> show(
    BuildContext context, {
    required String planDestino,
    required List<String> limitesExcedidos,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (_) => DowngradeBlockedSheet(
        planDestino: planDestino,
        limitesExcedidos: limitesExcedidos,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.block, color: AppColors.error),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Text('No puedes bajar a Plan $planDestino todavía', style: AppTextStyles.h2),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            const Text(
              'Tu uso actual excede los límites de este plan. Antes de cambiar, resuelve lo siguiente:',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: AppSizes.md),
            ...limitesExcedidos.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.circle, size: 6, color: AppColors.error),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(child: Text(item, style: AppTextStyles.body)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Entendido'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
