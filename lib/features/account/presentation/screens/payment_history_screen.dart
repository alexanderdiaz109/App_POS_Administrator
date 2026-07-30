import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../data/providers/payment_providers.dart';

class PaymentHistoryScreen extends ConsumerWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(paymentHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de pagos')),
      body: paymentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(paymentHistoryProvider),
        ),
        data: (payments) => payments.isEmpty
            ? const EmptyState(
                icon: Icons.receipt_long_outlined,
                title: 'Sin pagos registrados todavía',
                message: 'Aquí verás el historial una vez que tu suscripción empiece a cobrarse.',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: payments.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final pago = payments[i];
                  final exitoso = pago.estado == 'exitoso';
                  return ListTile(
                    leading: Icon(
                      exitoso ? Icons.check_circle : Icons.error,
                      color: exitoso ? AppColors.success : AppColors.error,
                    ),
                    title: Text('\$${pago.monto.toStringAsFixed(2)} MXN', style: AppTextStyles.body),
                    subtitle: Text(
                      '${pago.fecha.day}/${pago.fecha.month}/${pago.fecha.year}',
                      style: AppTextStyles.bodySecondary,
                    ),
                    trailing: Text(
                      exitoso ? 'Exitoso' : (pago.estado == 'reembolsado' ? 'Reembolsado' : 'Fallido'),
                      style: AppTextStyles.caption,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
