import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Fila de producto rankeado con barra proporcional al líder del top,
/// usado en la sección de "Top 5 productos" de Reportes.
class RankedProductTile extends StatelessWidget {
  final int posicion;
  final String nombre;
  final int unidades;
  final double gananciaGenerada;
  final double proporcion; // 0.0 a 1.0 respecto al #1 del top

  const RankedProductTile({
    super.key,
    required this.posicion,
    required this.nombre,
    required this.unidades,
    required this.gananciaGenerada,
    required this.proporcion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Text(
              '$posicion',
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(nombre, style: AppTextStyles.body, overflow: TextOverflow.ellipsis)),
                    Text('$unidades und', style: AppTextStyles.bodySecondary),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: proporcion,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceAlt,
                    valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
