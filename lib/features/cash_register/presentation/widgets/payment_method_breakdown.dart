import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Fila de desglose por método de pago, con barra proporcional al monto.
/// Se usa tanto en el resumen del corte como en el detalle.
class PaymentMethodBreakdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final double monto;
  final double montoMaximo; // para calcular el ancho proporcional de la barra

  const PaymentMethodBreakdown({
    super.key,
    required this.icon,
    required this.label,
    required this.monto,
    required this.montoMaximo,
  });

  @override
  Widget build(BuildContext context) {
    final proporcion = montoMaximo == 0 ? 0.0 : (monto / montoMaximo).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: AppSizes.sm),
              Expanded(child: Text(label, style: AppTextStyles.body)),
              Text('\$${monto.toStringAsFixed(2)}', style: AppTextStyles.h3),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: proporcion,
              minHeight: 6,
              backgroundColor: AppColors.surfaceAlt,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
