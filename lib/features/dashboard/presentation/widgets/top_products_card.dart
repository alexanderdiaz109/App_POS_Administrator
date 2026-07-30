import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../reports/domain/entities/top_product.dart';

class TopProductsCard extends StatelessWidget {
  final List<TopProduct> productos;
  const TopProductsCard({super.key, required this.productos});

  @override
  Widget build(BuildContext context) {
    if (productos.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: EmptyState(icon: Icons.bar_chart_outlined, title: 'Sin ventas hoy todavía'),
        ),
      );
    }

    return Card(
      child: Column(
        children: List.generate(productos.length, (i) {
          final item = productos[i];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text('${i + 1}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            title: Text(item.nombre, style: AppTextStyles.body),
            trailing: Text('${item.unidades} und', style: AppTextStyles.bodySecondary),
          );
        }),
      ),
    );
  }
}
