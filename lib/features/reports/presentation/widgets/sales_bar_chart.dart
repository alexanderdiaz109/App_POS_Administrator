import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Gráfica de barras simple (sin dependencias externas) para ventas por
/// periodo. Cada barra es proporcional al monto máximo del set de datos.
class SalesBarChart extends StatelessWidget {
  final List<SalesDataPoint> data;

  const SalesBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((d) => d.monto).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 190,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((point) {
          final alturaProporcional = maxValue == 0 ? 0.0 : point.monto / maxValue;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '\$${point.monto.toStringAsFixed(0)}',
                    style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 130 * alturaProporcional,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.primary.withValues(alpha: 0.85), AppColors.primary],
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                  ),
                  Container(height: 2, color: AppColors.divider),
                  const SizedBox(height: AppSizes.xs),
                  Text(point.etiqueta, style: AppTextStyles.caption),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SalesDataPoint {
  final String etiqueta;
  final double monto;

  const SalesDataPoint({required this.etiqueta, required this.monto});
}
