import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Tarjeta grande con el total del periodo (día o semana) seleccionado.
class CashSummaryCard extends StatelessWidget {
  final String label;
  final double total;
  final int numeroVentas;

  const CashSummaryCard({
    super.key,
    required this.label,
    required this.total,
    required this.numeroVentas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySecondary.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: AppTextStyles.price.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSizes.sm),
          Row(
            children: [
              const Icon(Icons.receipt_long, size: 16, color: Colors.white70),
              const SizedBox(width: 6),
              Text(
                '$numeroVentas ventas registradas',
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
