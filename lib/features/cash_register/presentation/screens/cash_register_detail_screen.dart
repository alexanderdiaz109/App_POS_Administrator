import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/payment_method_breakdown.dart';

/// Detalle de un corte específico: desglose por método de pago del día
/// seleccionado en el historial de CashRegisterScreen.
/// TODO(backend): recibir el `corteId` o la fecha como argumento de ruta
/// y traer los datos reales de ese corte.
class CashRegisterDetailScreen extends StatelessWidget {
  const CashRegisterDetailScreen({super.key});

  // TODO(backend): reemplazar por los datos reales del corte seleccionado.
  static const _mockDetalle = {
    'fecha': '25 de julio, 2026',
    'total': 2870.0,
    'ventas': 24,
    'efectivo': 1800.0,
    'tarjeta': 850.0,
    'transferencia': 220.0,
  };

  @override
  Widget build(BuildContext context) {
    final d = _mockDetalle;
    final montoMaximo = [
      d['efectivo'] as double,
      d['tarjeta'] as double,
      d['transferencia'] as double,
    ].reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del corte'),
        actions: [
          IconButton(icon: const Icon(Icons.ios_share), onPressed: () {}, tooltip: 'Compartir/exportar'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          Text(d['fecha'] as String, style: AppTextStyles.bodySecondary),
          const SizedBox(height: AppSizes.xs),
          Text('\$${(d['total'] as double).toStringAsFixed(2)}', style: AppTextStyles.price),
          const SizedBox(height: AppSizes.xs),
          Row(
            children: [
              const Icon(Icons.receipt_long, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text('${d['ventas']} ventas registradas', style: AppTextStyles.bodySecondary),
            ],
          ),
          const SizedBox(height: AppSizes.lg),

          const Text('Desglose por método de pago', style: AppTextStyles.h3),
          const SizedBox(height: AppSizes.sm),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.md),
              child: Column(
                children: [
                  PaymentMethodBreakdown(
                    icon: Icons.payments_outlined,
                    label: 'Efectivo',
                    monto: d['efectivo'] as double,
                    montoMaximo: montoMaximo,
                  ),
                  PaymentMethodBreakdown(
                    icon: Icons.credit_card,
                    label: 'Tarjeta',
                    monto: d['tarjeta'] as double,
                    montoMaximo: montoMaximo,
                  ),
                  PaymentMethodBreakdown(
                    icon: Icons.qr_code,
                    label: 'Transferencia',
                    monto: d['transferencia'] as double,
                    montoMaximo: montoMaximo,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
