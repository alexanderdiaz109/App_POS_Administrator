import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/models/user_role_model.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../data/providers/team_providers.dart';

class UsersRolesScreen extends ConsumerWidget {
  const UsersRolesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsync = ref.watch(teamListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios y roles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Ver auditoría',
            onPressed: () => Navigator.of(context).pushNamed(RouteNames.auditLog),
          ),
        ],
      ),
      body: teamAsync.when(
        loading: () => const SkeletonList(),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(teamListControllerProvider),
        ),
        data: (team) => team.length <= 1
            ? EmptyState(
                icon: Icons.people_outline,
                title: 'Sin usuarios adicionales',
                message: 'Agrega cajeros o administradores que ya tengan cuenta registrada en la app.',
                actionLabel: 'Agregar usuario',
                onAction: () => _showAddSheet(context, ref),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: team.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final u = team[i];
                  final rol = u.rol == 'administrador' ? UserRole.administrador : UserRole.cajero;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: rol.color.withValues(alpha: 0.12),
                      child: Icon(rol.icon, color: rol.color, size: 20),
                    ),
                    title: Text(
                      u.nombre,
                      style: AppTextStyles.body.copyWith(
                        color: u.activo ? AppColors.textPrimary : AppColors.textSecondary,
                      ),
                    ),
                    subtitle: Text(u.correo, style: AppTextStyles.bodySecondary),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'toggle') {
                          await ref.read(teamListControllerProvider.notifier).toggleActive(u.id, !u.activo);
                        } else {
                          await ref.read(teamListControllerProvider.notifier).updateRole(u.id, value);
                        }
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(value: u.activo ? 'toggle' : 'toggle', child: Text(u.activo ? 'Desactivar' : 'Activar')),
                        const PopupMenuItem(value: 'cajero', child: Text('Hacer Cajero')),
                        const PopupMenuItem(value: 'administrador', child: Text('Hacer Administrador')),
                      ],
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: rol.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                        ),
                        child: Text(
                          rol.etiqueta,
                          style: AppTextStyles.caption.copyWith(color: rol.color, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, ref),
        child: const Icon(Icons.person_add_outlined),
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final correoController = TextEditingController();
    String rolSeleccionado = 'cajero';
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
                Text('Agregar usuario', style: AppTextStyles.h2),
                const SizedBox(height: AppSizes.xs),
                Text(
                  'La persona debe tener ya una cuenta creada en la app.',
                  style: AppTextStyles.bodySecondary,
                ),
                const SizedBox(height: AppSizes.md),
                TextFormField(
                  controller: correoController,
                  decoration: const InputDecoration(labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Ingresa el correo del usuario';
                    final regex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
                    if (!regex.hasMatch(v.trim())) return 'Correo inválido';
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.md),
                DropdownButtonFormField<String>(
                  value: rolSeleccionado,
                  decoration: const InputDecoration(labelText: 'Rol'),
                  items: const [
                    DropdownMenuItem(value: 'cajero', child: Text('Cajero')),
                    DropdownMenuItem(value: 'administrador', child: Text('Administrador')),
                  ],
                  onChanged: (v) => setSheetState(() => rolSeleccionado = v ?? 'cajero'),
                ),
                const SizedBox(height: AppSizes.md),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          setSheetState(() => loading = true);
                          final error = await ref
                              .read(teamListControllerProvider.notifier)
                              .linkUserByEmail(correo: correoController.text.trim(), rol: rolSeleccionado);
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
                      : const Text('Agregar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
