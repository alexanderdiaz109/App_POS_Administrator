import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../account/data/providers/plan_features_provider.dart';
import '../../data/providers/product_providers.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final featuresAsync = ref.watch(currentPlanFeaturesProvider);
              return featuresAsync.maybeWhen(
                data: (features) => features.categoriasPersonalizadas
                    ? IconButton(
                        icon: const Icon(Icons.category_outlined),
                        onPressed: () => Navigator.of(context).pushNamed(RouteNames.categories),
                      )
                    : IconButton(
                        icon: const Icon(Icons.category_outlined, color: AppColors.textSecondary),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Categorías está disponible en Plan Medio'),
                            action: SnackBarAction(
                              label: 'Ver planes',
                              onPressed: () => Navigator.of(context).pushNamed(RouteNames.changePlan),
                            ),
                          ),
                        ),
                      ),
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
              decoration: InputDecoration(
                hintText: 'Buscar producto',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
              ),
            ),
          ),
          Expanded(
            child: productsAsync.when(
              loading: () => const SkeletonList(),
              error: (err, _) => ErrorState(
                message: '$err',
                onRetry: () => ref.invalidate(productListControllerProvider),
              ),
              data: (products) {
                final filtered = _query.isEmpty
                    ? products
                    : products.where((p) => p.nombre.toLowerCase().contains(_query)).toList();

                if (products.isEmpty) {
                  return EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: 'Sin productos todavía',
                    message: 'Agrega tu primer producto para empezar a vender.',
                    actionLabel: 'Agregar producto',
                    onAction: () => Navigator.of(context).pushNamed(RouteNames.productForm),
                  );
                }
                if (filtered.isEmpty) {
                  return EmptyState(icon: Icons.search_off, title: 'Sin resultados para "$_query"');
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final p = filtered[i];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(p.nombre, style: AppTextStyles.body),
                      subtitle: Text(
                        '\$${p.precioVenta.toStringAsFixed(2)} · Stock: ${p.stockActual}',
                        style: AppTextStyles.bodySecondary,
                      ),
                      trailing: p.tieneStockBajo
                          ? const Icon(Icons.warning_amber_rounded, color: AppColors.warning)
                          : const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context)
                          .pushNamed(RouteNames.productDetail, arguments: p.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(RouteNames.productForm),
        child: const Icon(Icons.add),
      ),
    );
  }
}
