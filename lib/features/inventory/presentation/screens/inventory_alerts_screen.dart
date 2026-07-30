import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../products/data/providers/product_providers.dart';

/// Alertas de stock bajo (Plan Medio+). Deriva la lista directamente del
/// provider real de productos (mismo que usa el catálogo), filtrando los
/// que tienen stock por debajo del mínimo — sin duplicar lógica ni mock.
class InventoryAlertsScreen extends ConsumerWidget {
  const InventoryAlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Alertas de stock bajo')),
      body: productsAsync.when(
        loading: () => const SkeletonList(),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(productListControllerProvider),
        ),
        data: (products) {
          final lowStock = products.where((p) => p.tieneStockBajo).toList();

          if (lowStock.isEmpty) {
            return const EmptyState(
              icon: Icons.check_circle_outline,
              title: 'Todo en orden',
              message: 'Ningún producto está por debajo de su stock mínimo.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSizes.md),
            itemCount: lowStock.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final p = lowStock[i];
              return ListTile(
                leading: const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
                title: Text(p.nombre, style: AppTextStyles.body),
                subtitle: Text(
                  'Stock actual: ${p.stockActual} · Mínimo: ${p.stockMinimo}',
                  style: AppTextStyles.bodySecondary,
                ),
                trailing: OutlinedButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteNames.productForm, arguments: p),
                  child: const Text('Reabastecer'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
