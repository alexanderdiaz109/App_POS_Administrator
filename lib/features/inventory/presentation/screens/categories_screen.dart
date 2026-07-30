import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../data/providers/category_providers.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: categoriesAsync.when(
        loading: () => const SkeletonList(),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(categoryListControllerProvider),
        ),
        data: (categories) => categories.isEmpty
            ? EmptyState(
                icon: Icons.category_outlined,
                title: 'Sin categorías todavía',
                message: 'Crea categorías para organizar mejor tu catálogo.',
                actionLabel: 'Crear categoría',
                onAction: () => _showAddCategorySheet(context, ref),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final c = categories[i];
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.surfaceAlt,
                      child: Icon(Icons.label_outline, color: AppColors.primary),
                    ),
                    title: Text(c.nombre, style: AppTextStyles.body),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.error),
                      onPressed: () => _confirmDelete(context, ref, c.id, c.nombre),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategorySheet(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCategorySheet(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: AppSizes.lg,
          right: AppSizes.lg,
          top: AppSizes.lg,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + AppSizes.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Nueva categoría', style: AppTextStyles.h2),
            const SizedBox(height: AppSizes.md),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Nombre de la categoría'),
              autofocus: true,
            ),
            const SizedBox(height: AppSizes.md),
            ElevatedButton(
              onPressed: () async {
                final nombre = controller.text.trim();
                if (nombre.isEmpty) return;
                Navigator.pop(sheetContext);
                final error = await ref.read(categoryListControllerProvider.notifier).addCategory(nombre);
                if (error != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error), backgroundColor: AppColors.error),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id, String nombre) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('¿Eliminar categoría?'),
        content: Text('Se eliminará "$nombre". Los productos que la usan quedarán sin categoría.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final error = await ref.read(categoryListControllerProvider.notifier).removeCategory(id);
              if (error != null && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error), backgroundColor: AppColors.error),
                );
              }
            },
            child: Text('Eliminar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}
