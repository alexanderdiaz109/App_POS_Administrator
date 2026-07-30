import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../products/data/providers/product_providers.dart';
import '../../data/providers/cart_providers.dart';

class PosScreen extends ConsumerStatefulWidget {
  const PosScreen({super.key});

  @override
  ConsumerState<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends ConsumerState<PosScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final total = ref.watch(cartTotalProvider);
    final productsAsync = ref.watch(productListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vender'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.of(context).pushNamed(RouteNames.scanner),
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
                hintText: 'Buscar producto por nombre',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.surfaceAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (_query.isNotEmpty)
            Expanded(
              child: productsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => ErrorState(message: '$err'),
                data: (products) {
                  final filtered = products.where((p) => p.nombre.toLowerCase().contains(_query)).toList();
                  if (filtered.isEmpty) {
                    return EmptyState(icon: Icons.search_off, title: 'Sin resultados para "$_query"');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final p = filtered[i];
                      final sinStock = p.stockActual <= 0;
                      return ListTile(
                        title: Text(p.nombre, style: AppTextStyles.body),
                        subtitle: Text(
                          '\$${p.precioVenta.toStringAsFixed(2)} · Stock: ${p.stockActual}',
                          style: AppTextStyles.bodySecondary,
                        ),
                        trailing: sinStock
                            ? Text('Sin stock', style: AppTextStyles.caption.copyWith(color: AppColors.error))
                            : const Icon(Icons.add_circle_outline, color: AppColors.primary),
                        onTap: sinStock
                            ? null
                            : () {
                                ref.read(cartControllerProvider.notifier).addProduct(p);
                                setState(() {
                                  _query = '';
                                  _searchController.clear();
                                });
                              },
                      );
                    },
                  );
                },
              ),
            )
          else
            Expanded(
              child: cart.isEmpty
                  ? EmptyState(
                      icon: Icons.point_of_sale_outlined,
                      title: 'Carrito vacío',
                      message: 'Busca un producto arriba para agregarlo a la venta.',
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                      itemCount: cart.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final item = cart[i];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(item.nombre, style: AppTextStyles.body),
                          subtitle: Text('\$${item.precioUnitario.toStringAsFixed(2)} c/u', style: AppTextStyles.bodySecondary),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => ref.read(cartControllerProvider.notifier).decrement(item.productId),
                              ),
                              Text('${item.cantidad}', style: AppTextStyles.body),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: item.cantidad < item.stockDisponible
                                    ? () => ref.read(cartControllerProvider.notifier).increment(item.productId)
                                    : null,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.divider)),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.h3),
                      Text('\$${total.toStringAsFixed(2)}', style: AppTextStyles.h1),
                    ],
                  ),
                  const SizedBox(height: AppSizes.sm),
                  PrimaryButton(
                    label: 'Cobrar',
                    onPressed: cart.isEmpty ? null : () => Navigator.of(context).pushNamed(RouteNames.checkout),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
