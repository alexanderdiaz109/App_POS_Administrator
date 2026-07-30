import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../data/providers/supplier_providers.dart';

class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suppliersAsync = ref.watch(supplierListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Proveedores')),
      body: suppliersAsync.when(
        loading: () => const SkeletonList(),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(supplierListControllerProvider),
        ),
        data: (suppliers) => suppliers.isEmpty
            ? EmptyState(
                icon: Icons.local_shipping_outlined,
                title: 'Sin proveedores todavía',
                message: 'Agrega tus proveedores para generar órdenes de compra.',
                actionLabel: 'Agregar proveedor',
                onAction: () => _showAddSheet(context, ref),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: suppliers.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final s = suppliers[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.surfaceAlt,
                      child: const Icon(Icons.local_shipping_outlined, color: AppColors.primary),
                    ),
                    title: Text(s.nombre, style: AppTextStyles.body),
                    subtitle: s.categoria != null ? Text(s.categoria!, style: AppTextStyles.bodySecondary) : null,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).pushNamed(RouteNames.supplierDetail, arguments: s.id),
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
    final categoriaController = TextEditingController();
    final telefonoController = TextEditingController();
    final correoController = TextEditingController();
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
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Nuevo proveedor', style: AppTextStyles.h2),
                  const SizedBox(height: AppSizes.md),
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Ingresa el nombre del proveedor';
                      if (v.trim().length < 3) return 'Mínimo 3 caracteres';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextFormField(
                    controller: categoriaController,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextFormField(
                    controller: telefonoController,
                    decoration: const InputDecoration(labelText: 'Teléfono'),
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      if (v.trim().length < 10) return 'Teléfono inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextFormField(
                    controller: correoController,
                    decoration: const InputDecoration(labelText: 'Correo'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return null;
                      final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
                      if (!regex.hasMatch(v.trim())) return 'Correo inválido';
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
                            final error = await ref.read(supplierListControllerProvider.notifier).addSupplier(
                                  nombre: nombreController.text.trim(),
                                  categoria: categoriaController.text.trim().isEmpty ? null : categoriaController.text.trim(),
                                  telefono: telefonoController.text.trim().isEmpty ? null : telefonoController.text.trim(),
                                  correo: correoController.text.trim().isEmpty ? null : correoController.text.trim(),
                                );
                            if (!sheetContext.mounted) return;
                            if (error != null) {
                              setSheetState(() => loading = false);
                              ScaffoldMessenger.of(sheetContext).showSnackBar(
                                SnackBar(content: Text(error), backgroundColor: AppColors.error),
                              );
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
                        : const Text('Guardar proveedor'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
