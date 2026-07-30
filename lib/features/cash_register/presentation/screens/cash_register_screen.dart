import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/error_state.dart';
import '../../data/providers/cash_register_providers.dart';
import '../widgets/cash_summary_card.dart';
import '../widgets/payment_method_breakdown.dart';

class CashRegisterScreen extends ConsumerStatefulWidget {
  const CashRegisterScreen({super.key});

  @override
  ConsumerState<CashRegisterScreen> createState() => _CashRegisterScreenState();
}

class _CashRegisterScreenState extends ConsumerState<CashRegisterScreen> {
  int _periodo = 0; // 0 = Hoy, 1 = Esta semana

  @override
  Widget build(BuildContext context) {
    final summaryAsync = _periodo == 0
        ? ref.watch(cashSummaryTodayProvider)
        : ref.watch(cashSummaryWeekProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Corte de caja')),
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
                Expanded(child: _periodoTab('Hoy', 0)),
                Expanded(child: _periodoTab('Esta semana', 1)),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.md),
          summaryAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSizes.xl),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, _) => ErrorState(
              message: '$err',
              onRetry: () => _periodo == 0
                  ? ref.invalidate(cashSummaryTodayProvider)
                  : ref.invalidate(cashSummaryWeekProvider),
            ),
            data: (summary) {
              final montoMaximo = [summary.efectivo, summary.tarjeta, summary.transferencia]
                  .reduce((a, b) => a > b ? a : b);

              return Column(
                children: [
                  CashSummaryCard(
                    label: _periodo == 0 ? 'Corte de hoy' : 'Corte de la semana',
                    total: summary.total,
                    numeroVentas: summary.numVentas,
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Text('Desglose por método de pago', style: AppTextStyles.h3),
                  const SizedBox(height: AppSizes.sm),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        children: [
                          PaymentMethodBreakdown(
                            icon: Icons.payments_outlined,
                            label: 'Efectivo',
                            monto: summary.efectivo,
                            montoMaximo: montoMaximo,
                          ),
                          PaymentMethodBreakdown(
                            icon: Icons.credit_card,
                            label: 'Tarjeta',
                            monto: summary.tarjeta,
                            montoMaximo: montoMaximo,
                          ),
                          PaymentMethodBreakdown(
                            icon: Icons.qr_code,
                            label: 'Transferencia',
                            monto: summary.transferencia,
                            montoMaximo: montoMaximo,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _periodoTab(String label, int index) {
    final activo = _periodo == index;
    return GestureDetector(
      onTap: () => setState(() => _periodo = index),
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
