import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/subscription_blocked_dialog.dart';
import '../../data/providers/supplier_providers.dart';

class SupplierDetailScreen extends ConsumerWidget {
  final String supplierId;
  const SupplierDetailScreen({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierAsync = ref.watch(supplierDetailProvider(supplierId));
    final ordersAsync = ref.watch(supplierOrdersControllerProvider(supplierId));

    return Scaffold(
      appBar: AppBar(
        title: supplierAsync.maybeWhen(data: (s) => Text(s.nombre), orElse: () => const Text('Proveedor')),
      ),
      body: supplierAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorState(message: '$err'),
        data: (supplier) {
          return ListView(
            padding: const EdgeInsets.all(AppSizes.md),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (supplier.categoria != null) _infoRow(Icons.category_outlined, supplier.categoria!),
                      if (supplier.telefono != null) _infoRow(Icons.phone_outlined, supplier.telefono!),
                      if (supplier.correo != null) _infoRow(Icons.mail_outline, supplier.correo!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Órdenes de compra', style: AppTextStyles.h3),
                  TextButton.icon(
                    onPressed: () => _showCreateOrderDialog(context, ref),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Nueva orden'),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              ordersAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(AppSizes.lg),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, _) => ErrorState(message: '$err'),
                data: (orders) => orders.isEmpty
                    ? const EmptyState(icon: Icons.description_outlined, title: 'Sin órdenes generadas')
                    : Card(
                        child: Column(
                          children: List.generate(orders.length, (i) {
                            final o = orders[i];
                            final pendiente = o.estado == 'pendiente';
                            return Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.description_outlined,
                                    color: pendiente ? AppColors.warning : AppColors.success,
                                  ),
                                  title: Text(o.folio, style: AppTextStyles.body),
                                  subtitle: Text(
                                    '${o.creadoEn.day}/${o.creadoEn.month}/${o.creadoEn.year}',
                                    style: AppTextStyles.bodySecondary,
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('\$${o.total.toStringAsFixed(2)}', style: AppTextStyles.body),
                                      Text(
                                        pendiente ? 'Pendiente' : 'Recibida',
                                        style: AppTextStyles.caption.copyWith(
                                          color: pendiente ? AppColors.warning : AppColors.success,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: pendiente
                                      ? () async {
                                          await ref
                                              .read(supplierOrdersControllerProvider(supplierId).notifier)
                                              .markReceived(o.id);
                                        }
                                      : null,
                                ),
                                if (i != orders.length - 1) const Divider(height: 1),
                              ],
                            );
                          }),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: AppSizes.sm),
          Text(value, style: AppTextStyles.body),
        ],
      ),
    );
  }

  void _showCreateOrderDialog(BuildContext context, WidgetRef ref) {
    final totalController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nueva orden de compra'),
        content: TextField(
          controller: totalController,
          decoration: const InputDecoration(labelText: 'Total estimado'),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              final total = double.tryParse(totalController.text);
              if (total == null) return;
              Navigator.pop(dialogContext);
              final error =
                  await ref.read(supplierOrdersControllerProvider(supplierId).notifier).createOrder(total);
              if (error != null && context.mounted) {
                final friendly = SubscriptionErrorTranslator.translate(error);
                SubscriptionBlockedDialog.show(context, friendly);
              }
            },
            child: const Text('Crear orden'),
          ),
        ],
      ),
    );
  }
}
