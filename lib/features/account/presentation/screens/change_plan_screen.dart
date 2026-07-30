import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/plan_limits.dart';
import '../../../../core/widgets/error_state.dart';
import '../../data/providers/checkout_providers.dart';
import '../../data/providers/plan_providers.dart';
import '../../data/providers/store_providers.dart';
import '../widgets/downgrade_blocked_sheet.dart';

class ChangePlanScreen extends ConsumerStatefulWidget {
  const ChangePlanScreen({super.key});

  @override
  ConsumerState<ChangePlanScreen> createState() => _ChangePlanScreenState();
}

class _ChangePlanScreenState extends ConsumerState<ChangePlanScreen> {
  String? _loadingPlanId;

  Future<void> _handleUpgrade(String storeId, int planId, String? priceId) async {
    if (priceId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este plan aún no tiene un precio configurado en Stripe.')),
      );
      return;
    }

    setState(() => _loadingPlanId = '$planId');
    final repo = ref.read(checkoutRepositoryProvider);
    final result = await repo.createCheckoutSession(storeId: storeId, priceId: priceId);

    if (!mounted) return;
    setState(() => _loadingPlanId = null);

    result.when(
      success: (url) async {
        final uri = Uri.parse(url);
        final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (!launched && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo abrir la página de pago.')),
          );
        }
      },
      failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      },
    );
  }

  Future<void> _handleChangePlan(String storeId, int planId, String planNombre) async {
    setState(() => _loadingPlanId = '$planId');
    final repo = ref.read(checkoutRepositoryProvider);
    final result = await repo.changePlan(storeId: storeId, newPlanId: planId);

    if (!mounted) return;
    setState(() => _loadingPlanId = null);

    result.when(
      success: (_) {
        ref.invalidate(currentStoreProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cambiando a $planNombre. Puede tardar unos segundos en reflejarse.')),
        );
        Navigator.of(context).pop();
      },
      failure: (message) {
        if (message.startsWith('downgrade_blocked::')) {
          final limites = message.replaceFirst('downgrade_blocked::', '').split('||');
          DowngradeBlockedSheet.show(context, planDestino: planNombre, limitesExcedidos: limites);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: AppColors.error),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final plansAsync = ref.watch(availablePlansProvider);
    final storeAsync = ref.watch(currentStoreProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cambiar de plan')),
      body: plansAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorState(message: '$err', onRetry: () => ref.invalidate(availablePlansProvider)),
        data: (plans) => storeAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => ErrorState(message: '$err'),
          data: (store) => ListView.separated(
            padding: const EdgeInsets.all(AppSizes.md),
            itemCount: plans.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSizes.md),
            itemBuilder: (context, i) {
              final plan = plans[i];
              final esActual = plan.id == store.nivelPlan;
              final esDowngrade = plan.id < store.nivelPlan;
              final features = _featuresList(plan.id);
              final cargando = _loadingPlanId == '${plan.id}';
              final tieneSuscripcionActiva = store.estadoPago != 'prueba';

              return Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(
                    color: esActual ? AppColors.primary : AppColors.divider,
                    width: esActual ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(plan.nombre, style: AppTextStyles.h2),
                        if (esActual) ...[
                          const SizedBox(width: AppSizes.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                            ),
                            child: Text(
                              'Actual',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text('\$${plan.precioMensual.toStringAsFixed(0)} MXN/mes', style: AppTextStyles.price.copyWith(fontSize: 22)),
                    Text('o \$${plan.precioAnual.toStringAsFixed(0)}/año (2 meses gratis)', style: AppTextStyles.bodySecondary),
                    const SizedBox(height: AppSizes.sm),
                    ...features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                            const SizedBox(width: 6),
                            Expanded(child: Text(f, style: AppTextStyles.body)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.sm),
                    SizedBox(
                      width: double.infinity,
                      child: esActual
                          ? const OutlinedButton(onPressed: null, child: Text('Plan actual'))
                          : ElevatedButton(
                              onPressed: cargando
                                  ? null
                                  : () {
                                      if (!tieneSuscripcionActiva) {
                                        // Sin suscripción de Stripe todavía (ej. en prueba
                                        // gratuita): siempre pasa por checkout, sea up o downgrade.
                                        _handleUpgrade(store.id, plan.id, plan.stripePriceId);
                                      } else if (esDowngrade) {
                                        _handleChangePlan(store.id, plan.id, plan.nombre);
                                      } else {
                                        _handleUpgrade(store.id, plan.id, plan.stripePriceId);
                                      }
                                    },
                              child: cargando
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : Text(esDowngrade && tieneSuscripcionActiva ? 'Bajar a este plan' : 'Elegir este plan'),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<String> _featuresList(int nivel) {
    final f = PlanFeatures.forPlan(nivel.toPlanLevel());
    return [
      'Catálogo, ventas y corte de caja',
      if (f.costosYGanancias) 'Costos y ganancias por producto',
      if (f.lectorCodigoBarras) 'Lector de código de barras',
      if (f.alertasStockBajo) 'Alertas de stock bajo',
      if (f.categoriasPersonalizadas) 'Categorías personalizadas',
      if (f.multiusuario) 'Multiusuario y roles',
      if (f.atributosDinamicos) 'Atributos dinámicos',
      if (f.sucursales) 'Múltiples sucursales',
      if (f.proveedoresYCompras) 'Proveedores y compras',
      if (f.exportacionDatos) 'Exportación de datos',
    ];
  }
}
