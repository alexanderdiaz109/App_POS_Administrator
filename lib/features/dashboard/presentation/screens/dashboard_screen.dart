import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/locked_feature_card.dart';
import '../../../account/data/providers/plan_features_provider.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../../branches/presentation/widgets/branch_switcher_sheet.dart';
import '../../../cash_register/data/providers/cash_register_providers.dart';
import '../../../products/data/providers/product_providers.dart';
import '../../../reports/data/providers/reports_providers.dart';
import '../../../../core/widgets/main_shell.dart';
import '../widgets/summary_card.dart';
import '../widgets/top_products_card.dart';
import '../widgets/quick_access_grid.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../account/data/providers/notification_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(currentStoreProvider);
    final featuresAsync = ref.watch(currentPlanFeaturesProvider);
    final summaryAsync = ref.watch(cashSummaryTodayProvider);
    final topProductsAsync = ref.watch(topProductsThisMonthProvider);
    final productsAsync = ref.watch(productListControllerProvider);

    final lowStockCount = productsAsync.maybeWhen(
      data: (products) => products.where((p) => p.tieneStockBajo).length,
      orElse: () => 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: storeAsync.when(
          loading: () => const Text('Cargando...'),
          error: (_, __) => const Text('Mi tienda'),
          data: (store) => GestureDetector(
            onTap: () {
              final features = featuresAsync.value;
              if (features?.sucursales == true) {
                BranchSwitcherSheet.show(context);
              }
            },
            child: Text('Hola, ${store.nombre}', overflow: TextOverflow.ellipsis),
          ),
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final unreadAsync = ref.watch(unreadNotificationCountProvider);
              final count = unreadAsync.maybeWhen(data: (c) => c, orElse: () => 0);
              return IconButton(
                icon: Badge(
                  isLabelVisible: count > 0,
                  label: Text('$count'),
                  child: const Icon(Icons.notifications_outlined),
                ),
                onPressed: () => Navigator.of(context).pushNamed(RouteNames.notifications),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(cashSummaryTodayProvider);
          ref.invalidate(topProductsTodayProvider);
          ref.invalidate(productListControllerProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.md),
          children: [
            summaryAsync.when(
              loading: () => Row(
                children: const [
                  Expanded(child: SkeletonBox(height: 100, radius: AppSizes.radiusMd)),
                  SizedBox(width: AppSizes.sm),
                  Expanded(child: SkeletonBox(height: 100, radius: AppSizes.radiusMd)),
                ],
              ),
              error: (err, _) => Text('Error: $err', style: AppTextStyles.bodySecondary),
              data: (summary) => Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      label: 'Ventas de hoy',
                      value: '\$${summary.total.toStringAsFixed(0)}',
                      icon: Icons.point_of_sale,
                      color: AppColors.chipGreen,
                      background: AppColors.chipGreenBg,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: SummaryCard(
                      label: 'Ganancia neta',
                      value: '\$${summary.gananciaNeta.toStringAsFixed(0)}',
                      icon: Icons.trending_up,
                      color: AppColors.chipBlue,
                      background: AppColors.chipBlueBg,
                    ),
                  ),
                ],
              ),
            ),
            if (lowStockCount > 0) ...[
              const SizedBox(height: AppSizes.md),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(RouteNames.inventoryAlerts),
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    border: Border.all(color: AppColors.warning.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Text(
                          '$lowStockCount producto${lowStockCount == 1 ? '' : 's'} con stock bajo. Revisa inventario.',
                          style: AppTextStyles.body,
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSizes.lg),
            Text('Accesos rápidos', style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.sm),
            featuresAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(AppSizes.lg),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (features) => QuickAccessGrid(
                items: [
                  QuickAccessItem(
                    label: 'Vender',
                    icon: Icons.point_of_sale_outlined,
                    color: AppColors.chipGreen,
                    background: AppColors.chipGreenBg,
                    onTap: () => ref.read(mainShellTabProvider.notifier).setTab(1),
                  ),
                  QuickAccessItem(
                    label: 'Productos',
                    icon: Icons.inventory_2_outlined,
                    color: AppColors.chipBlue,
                    background: AppColors.chipBlueBg,
                    onTap: () => ref.read(mainShellTabProvider.notifier).setTab(2),
                  ),
                  QuickAccessItem(
                    label: 'Escanear',
                    icon: Icons.qr_code_scanner,
                    color: features.lectorCodigoBarras ? AppColors.chipPurple : AppColors.textSecondary,
                    background: features.lectorCodigoBarras ? AppColors.chipPurpleBg : AppColors.surfaceAlt,
                    onTap: () => features.lectorCodigoBarras
                        ? Navigator.of(context).pushNamed(RouteNames.scanner)
                        : _showLockedSnackbar(context, 'Escanear código', 'Medio'),
                  ),
                  QuickAccessItem(
                    label: 'Corte de caja',
                    icon: Icons.point_of_sale,
                    color: AppColors.chipTeal,
                    background: AppColors.chipTealBg,
                    onTap: () => Navigator.of(context).pushNamed(RouteNames.cashRegister),
                  ),
                  QuickAccessItem(
                    label: 'Stock bajo',
                    icon: Icons.warning_amber_rounded,
                    color: features.alertasStockBajo ? AppColors.chipOrange : AppColors.textSecondary,
                    background: features.alertasStockBajo ? AppColors.chipOrangeBg : AppColors.surfaceAlt,
                    onTap: () => features.alertasStockBajo
                        ? Navigator.of(context).pushNamed(RouteNames.inventoryAlerts)
                        : _showLockedSnackbar(context, 'Alertas de stock bajo', 'Medio'),
                  ),
                  QuickAccessItem(
                    label: 'Reportes',
                    icon: Icons.bar_chart,
                    color: AppColors.chipPink,
                    background: AppColors.chipPinkBg,
                    onTap: () => Navigator.of(context).pushNamed(RouteNames.reports),
                  ),
                ],
              ),
            ),
            featuresAsync.maybeWhen(
              data: (features) => !features.sucursales
                  ? const Padding(
                      padding: EdgeInsets.only(top: AppSizes.md),
                      child: LockedFeatureCard(
                        title: 'Múltiples sucursales',
                        requiredPlan: 'Premium',
                        icon: Icons.store_mall_directory_outlined,
                      ),
                    )
                  : const SizedBox.shrink(),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSizes.lg),
            Text('Top productos del mes', style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.sm),
            topProductsAsync.when(
              loading: () => const SkeletonList(itemCount: 3),
              error: (err, _) => Text('Error: $err', style: AppTextStyles.bodySecondary),
              data: (productos) => TopProductsCard(productos: productos),
            ),
          ],
        ),
      ),
    );
  }

  void _showLockedSnackbar(BuildContext context, String feature, String plan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$feature" está disponible en Plan $plan'),
        action: SnackBarAction(
          label: 'Ver planes',
          onPressed: () => Navigator.of(context).pushNamed(RouteNames.changePlan),
        ),
      ),
    );
  }
}
