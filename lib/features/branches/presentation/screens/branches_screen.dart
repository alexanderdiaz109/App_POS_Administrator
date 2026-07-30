import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/subscription_blocked_dialog.dart';
import '../../data/providers/branch_providers.dart';

class BranchesScreen extends ConsumerWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchesAsync = ref.watch(branchListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sucursales')),
      body: branchesAsync.when(
        loading: () => const SkeletonList(),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(branchListControllerProvider),
        ),
        data: (branches) => branches.isEmpty
            ? EmptyState(
                icon: Icons.store_mall_directory_outlined,
                title: 'Sin sucursales adicionales',
                message: 'Agrega una sucursal para administrar varias tiendas desde una sola cuenta.',
                actionLabel: 'Agregar sucursal',
                onAction: () => _showAddSheet(context, ref),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: branches.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSizes.sm),
                itemBuilder: (context, i) {
                  final b = branches[i];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(b.nombre, style: AppTextStyles.h3)),
                              StatusBadge(
                                label: b.activa ? 'Activa' : 'Inactiva',
                                color: b.activa ? AppColors.statusActivo : AppColors.statusCancelado,
                              ),
                            ],
                          ),
                          if (b.direccion != null) ...[
                            const SizedBox(height: AppSizes.xs),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Expanded(child: Text(b.direccion!, style: AppTextStyles.bodySecondary)),
                              ],
                            ),
                          ],
                          const SizedBox(height: AppSizes.sm),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                final error = await ref
                                    .read(branchListControllerProvider.notifier)
                                    .toggleActive(b.id, !b.activa);
                                if (error != null && context.mounted) {
                                  final friendly = SubscriptionErrorTranslator.translate(error);
                                  SubscriptionBlockedDialog.show(context, friendly);
                                }
                              },
                              child: Text(b.activa ? 'Desactivar' : 'Activar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nombreController = TextEditingController();
    final direccionController = TextEditingController();
    final telefonoController = TextEditingController();
    bool loading = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: AppSizes.lg,
            right: AppSizes.lg,
            top: AppSizes.lg,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + AppSizes.lg,
          ),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Nueva sucursal', style: AppTextStyles.h2),
                const SizedBox(height: AppSizes.md),
                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Ingresa el nombre de la sucursal';
                    if (v.trim().length < 3) return 'Mínimo 3 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.md),
                TextFormField(
                  controller: direccionController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                ),
                const SizedBox(height: AppSizes.md),
                TextFormField(
                  controller: telefonoController,
                  decoration: const InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return null; // opcional
                    if (v.trim().length < 10) return 'Teléfono inválido';
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.md),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          setSheetState(() => loading = true);
                          final error = await ref.read(branchListControllerProvider.notifier).addBranch(
                                nombre: nombreController.text.trim(),
                                direccion: direccionController.text.trim().isEmpty ? null : direccionController.text.trim(),
                                telefono: telefonoController.text.trim().isEmpty ? null : telefonoController.text.trim(),
                              );
                          if (!sheetContext.mounted) return;
                          if (error != null) {
                            setSheetState(() => loading = false);
                            final friendly = SubscriptionErrorTranslator.translate(error);
                            SubscriptionBlockedDialog.show(sheetContext, friendly);
                          } else {
                            Navigator.pop(sheetContext);
                          }
                        },
                  child: loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Crear sucursal'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
