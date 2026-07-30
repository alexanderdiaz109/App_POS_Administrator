import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/trial_banner.dart';
import '../../../auth/data/providers/auth_providers.dart';
import '../../data/providers/checkout_providers.dart';
import '../../data/providers/plan_features_provider.dart';
import '../../data/providers/plan_providers.dart';
import '../../data/providers/store_providers.dart';
import '../../domain/entities/store.dart';
import '../../../branches/presentation/screens/branches_screen.dart';
import '../../../suppliers/presentation/screens/suppliers_screen.dart';
import '../../../users_roles/presentation/screens/users_roles_screen.dart';
import '../widgets/account_section_card.dart';
import '../../../../core/widgets/loading_skeleton.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(currentStoreProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Cuenta')),
      body: storeAsync.when(
        loading: () => const _AccountLoadingSkeleton(),
        error: (err, _) => ErrorState(
          message: 'No se pudo cargar tu cuenta: $err',
          onRetry: () => ref.invalidate(currentStoreProvider),
        ),
        data: (store) => _AccountContent(store: store),
      ),
    );
  }
}

class _AccountContent extends ConsumerWidget {
  final Store store;
  const _AccountContent({required this.store});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final esPrueba = store.estadoPago == 'prueba';

    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        if (esPrueba) ...[
          TrialBanner(
            diasRestantes: store.diasRestantesPrueba,
            onTap: () => Navigator.of(context).pushNamed(RouteNames.updatePaymentMethod),
          ),
          const SizedBox(height: AppSizes.md),
        ],
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estado del contrato', style: AppTextStyles.bodySecondary),
                    const SizedBox(height: AppSizes.xs),
                    StatusBadge(
                      label: _etiquetaEstado(store.estadoPago),
                      color: _colorEstado(store.estadoPago),
                    ),
                  ],
                ),
                Icon(Icons.verified_user_outlined, color: _colorEstado(store.estadoPago), size: 32),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.md),
        AccountSectionCard(
          title: 'Plan actual',
          child: Consumer(
            builder: (context, ref, _) {
              final plansAsync = ref.watch(availablePlansProvider);
              final precioTexto = plansAsync.maybeWhen(
                data: (plans) {
                  final plan = plans.where((p) => p.id == store.nivelPlan).firstOrNull;
                  return plan != null ? '\$${plan.precioMensual.toStringAsFixed(0)}/mes' : '—';
                },
                orElse: () => '—',
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_nombrePlan(store.nivelPlan), style: AppTextStyles.h2),
                      Text(precioTexto, style: AppTextStyles.h3),
                    ],
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    'Próximo cobro: ${_formatDate(store.fechaProximoCobro)}',
                    style: AppTextStyles.bodySecondary,
                  ),
                  const SizedBox(height: AppSizes.md),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pushNamed(RouteNames.changePlan),
                    child: const Text('Cambiar de plan'),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.md),
        AccountSectionCard(
          title: 'Historial de pagos',
          trailing: IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () {},
            tooltip: 'Descargar PDF/CSV',
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Ver todos los pagos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(RouteNames.paymentHistory),
          ),
        ),
        const SizedBox(height: AppSizes.md),
        AccountSectionCard(
          title: 'Contrato / Términos de servicio',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Aceptado el 12 de marzo de 2026', style: AppTextStyles.bodySecondary),
              const SizedBox(height: AppSizes.sm),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('Descargar contrato (PDF)'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Consumer(
          builder: (context, ref, _) {
            final featuresAsync = ref.watch(currentPlanFeaturesProvider);
            return featuresAsync.maybeWhen(
              data: (features) {
                if (!features.sucursales) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.md),
                  child: AccountSectionCard(
                    title: 'Gestión Premium',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.store_mall_directory_outlined, color: AppColors.primary),
                          title: const Text('Sucursales'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const BranchesScreen()),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.local_shipping_outlined, color: AppColors.primary),
                          title: const Text('Proveedores'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SuppliersScreen()),
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.people_outline, color: AppColors.primary),
                          title: const Text('Usuarios y roles'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const UsersRolesScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
        const SizedBox(height: AppSizes.lg),
        Center(
          child: TextButton(
            onPressed: () => _showCancelSheet(context, ref, store.id),
            child: Text('Cancelar suscripción', style: AppTextStyles.body.copyWith(color: AppColors.error)),
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Center(
          child: TextButton.icon(
            onPressed: () => _handleSignOut(context, ref),
            icon: const Icon(Icons.logout, size: 18, color: AppColors.textSecondary),
            label: Text('Cerrar sesión', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          ),
        ),
      ],
    );
  }

  String _nombrePlan(int nivel) {
    switch (nivel) {
      case 1:
        return 'Plan Básico';
      case 2:
        return 'Plan Medio';
      case 3:
        return 'Plan Premium';
      default:
        return 'Plan desconocido';
    }
  }

  String _etiquetaEstado(String estado) {
    switch (estado) {
      case 'prueba':
        return 'Periodo de prueba';
      case 'activo':
        return 'Activo';
      case 'en_gracia':
        return 'En periodo de gracia';
      case 'suspendido':
        return 'Suspendido';
      case 'cancelado':
        return 'Cancelado';
      default:
        return estado;
    }
  }

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'prueba':
        return AppColors.primary;
      case 'activo':
        return AppColors.statusActivo;
      case 'en_gracia':
        return AppColors.statusGracia;
      case 'suspendido':
        return AppColors.statusSuspendido;
      case 'cancelado':
        return AppColors.statusCancelado;
      default:
        return AppColors.textSecondary;
    }
  }

  String _formatDate(DateTime? d) {
    if (d == null) return '—';
    return '${d.day}/${d.month}/${d.year}';
  }

  void _showCancelSheet(BuildContext context, WidgetRef ref, String storeId) {
    bool loading = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('¿Cancelar tu suscripción?', style: AppTextStyles.h2),
              const SizedBox(height: AppSizes.sm),
              Text(
                'Mantendrás acceso hasta el final del periodo ya pagado. '
                'Tus datos se conservan 90 días por si decides reactivar.',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: AppSizes.lg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: loading ? null : () => Navigator.pop(sheetContext),
                      child: const Text('Mantener plan'),
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                      onPressed: loading
                          ? null
                          : () async {
                              setSheetState(() => loading = true);
                              final repo = ref.read(checkoutRepositoryProvider);
                              final result = await repo.cancelSubscription(storeId);

                              if (!sheetContext.mounted) return;
                              Navigator.pop(sheetContext);

                              result.when(
                                success: (_) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    RouteNames.cancellationConfirmed,
                                    (route) => route.settings.name == RouteNames.mainShell,
                                  );
                                },
                                failure: (message) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message), backgroundColor: AppColors.error),
                                  );
                                },
                              );
                            },
                      child: loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Sí, cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignOut(BuildContext context, WidgetRef ref) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Cerrar sesión?'),
        content: const Text('Tendrás que ingresar tu correo y contraseña de nuevo.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Cerrar sesión')),
        ],
      ),
    );

    if (confirmar != true) return;
    if (!context.mounted) return;

    await ref.read(authControllerProvider.notifier).signOut();
    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.login, (_) => false);
  }
}

class _AccountLoadingSkeleton extends StatelessWidget {
  const _AccountLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: const [
        SkeletonBox(width: double.infinity, height: 90, radius: AppSizes.radiusMd),
        SizedBox(height: AppSizes.md),
        SkeletonBox(width: double.infinity, height: 150, radius: AppSizes.radiusMd),
        SizedBox(height: AppSizes.md),
        SkeletonBox(width: double.infinity, height: 70, radius: AppSizes.radiusMd),
        SizedBox(height: AppSizes.md),
        SkeletonBox(width: double.infinity, height: 100, radius: AppSizes.radiusMd),
      ],
    );
  }
}
