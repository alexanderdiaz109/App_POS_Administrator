import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/plan_limits.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../data/providers/reports_providers.dart';
import '../../domain/entities/top_product.dart';
import '../widgets/ranked_product_tile.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  ReportPeriod _periodo = ReportPeriod.last7Days;
  bool _exportando = false;

  @override
  Widget build(BuildContext context) {
    final topProductsAsync = ref.watch(topProductsProvider(_periodo));
    final storeAsync = ref.watch(currentStoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        actions: [
          storeAsync.maybeWhen(
            data: (store) {
              final features = PlanFeatures.forPlan(_planLevelFromInt(store.nivelPlan));
              if (!features.exportacionDatos) return const SizedBox.shrink();
              return IconButton(
                icon: _exportando
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.ios_share),
                onPressed: _exportando
                    ? null
                    : () => _showExportOptions(topProductsAsync.value ?? [], store.nombre),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: Row(
              children: [
                Expanded(child: _periodoTab('Últimos 7 días', ReportPeriod.last7Days)),
                Expanded(child: _periodoTab('Últimos 30 días', ReportPeriod.last30Days)),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text('Top productos más vendidos', style: AppTextStyles.h3),
          const SizedBox(height: AppSizes.sm),
          topProductsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSizes.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => ErrorState(
              message: '$err',
              onRetry: () => ref.invalidate(topProductsProvider(_periodo)),
            ),
            data: (productos) {
              if (productos.isEmpty) {
                return const EmptyState(icon: Icons.bar_chart_outlined, title: 'Sin ventas en este periodo');
              }
              final maxUnidades = productos.first.unidades.toDouble();
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                  child: Column(
                    children: List.generate(productos.length, (i) {
                      final p = productos[i];
                      return Column(
                        children: [
                          RankedProductTile(
                            posicion: i + 1,
                            nombre: p.nombre,
                            unidades: p.unidades,
                            gananciaGenerada: 0,
                            proporcion: p.unidades / maxUnidades,
                          ),
                          if (i != productos.length - 1) const Divider(height: 1),
                        ],
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showExportOptions(List<TopProduct> productos, String tiendaNombre) {
    if (productos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay datos para exportar en este periodo.')),
      );
      return;
    }

    final periodoLabel = _periodo == ReportPeriod.last7Days ? 'Últimos 7 días' : 'Últimos 30 días';
    final periodoArchivo = _periodo == ReportPeriod.last7Days ? '7dias' : '30dias';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Exportar reporte', style: AppTextStyles.h2),
              const SizedBox(height: AppSizes.md),
              _exportRow(
                icon: Icons.picture_as_pdf_outlined,
                color: AppColors.error,
                label: 'PDF',
                onShare: () => _run(() => ref.read(exportServiceProvider).shareTopProductsPdf(
                      productos: productos,
                      tiendaNombre: tiendaNombre,
                      periodoLabel: periodoLabel,
                    )),
                onDownload: () => _run(() => ref.read(exportServiceProvider).downloadTopProductsPdf(
                      productos: productos,
                      tiendaNombre: tiendaNombre,
                      periodoLabel: periodoLabel,
                    )),
              ),
              const SizedBox(height: AppSizes.sm),
              _exportRow(
                icon: Icons.table_chart_outlined,
                color: AppColors.success,
                label: 'CSV',
                onShare: () => _run(() => ref.read(exportServiceProvider).shareTopProductsCsv(
                      productos: productos,
                      periodo: periodoArchivo,
                    )),
                onDownload: () => _run(() => ref.read(exportServiceProvider).downloadTopProductsCsv(
                      productos: productos,
                      periodo: periodoArchivo,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exportRow({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onShare,
    required VoidCallback onDownload,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSizes.sm),
          Expanded(child: Text(label, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600))),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              onDownload();
            },
            icon: const Icon(Icons.download_outlined, size: 18),
            label: const Text('Descargar'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              onShare();
            },
            icon: const Icon(Icons.ios_share, size: 18),
            label: const Text('Compartir'),
          ),
        ],
      ),
    );
  }

  Future<void> _run(Future<dynamic> Function() action) async {
    setState(() => _exportando = true);
    try {
      final result = await action();
      if (mounted) {
        final mensaje = result is String
            ? 'Guardado en: $result'
            : 'Reporte generado correctamente';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje), duration: const Duration(seconds: 5)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al exportar: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _exportando = false);
    }
  }

  PlanLevel _planLevelFromInt(int nivel) {
    switch (nivel) {
      case 3:
        return PlanLevel.premium;
      case 2:
        return PlanLevel.medio;
      default:
        return PlanLevel.basico;
    }
  }

  Widget _periodoTab(String label, ReportPeriod periodo) {
    final activo = _periodo == periodo;
    return GestureDetector(
      onTap: () => setState(() => _periodo = periodo),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
        decoration: BoxDecoration(
          color: activo ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusSm),
          boxShadow: activo ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4)] : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: activo ? AppColors.primary : AppColors.textSecondary,
            fontWeight: activo ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
