import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/error_state.dart';
import '../../data/providers/product_providers.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
        actions: [
          productAsync.maybeWhen(
            data: (p) => IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.of(context)
                  .pushNamed(RouteNames.productForm, arguments: p)
                  .then((_) => ref.invalidate(productDetailProvider(productId))),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
        data: (p) {
          return ListView(
            padding: const EdgeInsets.all(AppSizes.md),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(p.nombre, style: AppTextStyles.h2),
                          if (p.tieneStockBajo)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.warning_amber_rounded, size: 14, color: AppColors.warning),
                                  SizedBox(width: 4),
                                  Text('Stock bajo', style: AppTextStyles.caption),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Text('\$${p.precioVenta.toStringAsFixed(2)}', style: AppTextStyles.h1),
                      const SizedBox(height: AppSizes.sm),
                      _infoRow('Stock actual', '${p.stockActual} unidades'),
                      if (p.stockMinimo != null) _infoRow('Stock mínimo', '${p.stockMinimo} unidades'),
                      if (p.costoCompra != null) ...[
                        const Divider(height: AppSizes.lg),
                        _infoRow('Costo de compra', '\$${p.costoCompra!.toStringAsFixed(2)}'),
                        if (p.utilidadPorUnidad != null)
                          _infoRow(
                            'Utilidad por unidad',
                            '\$${p.utilidadPorUnidad!.toStringAsFixed(2)}',
                            destacado: true,
                          ),
                      ],
                      if (p.atributos != null && p.atributos!.isNotEmpty) ...[
                        const Divider(height: AppSizes.lg),
                        Text('Atributos', style: AppTextStyles.h3),
                        const SizedBox(height: AppSizes.xs),
                        ...p.atributos!.entries.map((e) => _infoRow(e.key, e.value.toString())),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              OutlinedButton.icon(
                onPressed: () => _confirmDelete(context, ref, p.id),
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                label: const Text('Eliminar producto', style: TextStyle(color: AppColors.error)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool destacado = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySecondary),
          Text(
            value,
            style: destacado
                ? AppTextStyles.body.copyWith(color: AppColors.success, fontWeight: FontWeight.w700)
                : AppTextStyles.body,
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('¿Eliminar producto?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final error = await ref.read(productListControllerProvider.notifier).removeProduct(id);
              if (context.mounted) {
                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error), backgroundColor: AppColors.error),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text('Eliminar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
