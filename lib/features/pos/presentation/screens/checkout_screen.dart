import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/widgets/subscription_blocked_dialog.dart';
import '../../data/providers/cart_providers.dart';
import '../../data/providers/sale_providers.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _metodoIndex = 0;
  bool _loading = false;
  final _montoRecibidoController = TextEditingController();

  static const _metodos = [
    {'label': 'Efectivo', 'valor': 'efectivo', 'icon': Icons.payments_outlined},
    {'label': 'Tarjeta', 'valor': 'tarjeta', 'icon': Icons.credit_card},
    {'label': 'Transferencia', 'valor': 'transferencia', 'icon': Icons.qr_code},
  ];

  bool get _esEfectivo => _metodos[_metodoIndex]['valor'] == 'efectivo';

  @override
  void dispose() {
    _montoRecibidoController.dispose();
    super.dispose();
  }

  double? _parseMontoRecibido() => double.tryParse(_montoRecibidoController.text);

  double? _calcularCambio(double total) {
    final recibido = _parseMontoRecibido();
    if (recibido == null || recibido < total) return null;
    return recibido - total;
  }

  bool _puedeConfirmar(double total) {
    if (!_esEfectivo) return true;
    final recibido = _parseMontoRecibido();
    return recibido != null && recibido >= total;
  }

  Future<void> _handleConfirm(double total) async {
    setState(() => _loading = true);
    try {
      final controller = ref.read(saleControllerProvider.notifier);
      final result = await controller.confirmSale(_metodos[_metodoIndex]['valor'] as String);

      if (!mounted) return;

      if (result == null) {
        final rawError = ref.read(saleControllerProvider).hasError
            ? ref.read(saleControllerProvider).error.toString()
            : 'No se pudo registrar la venta';
        final friendlyError = SubscriptionErrorTranslator.translate(rawError);

        if (context.mounted) {
          await SubscriptionBlockedDialog.show(context, friendlyError);
        }
        return;
      }

      // El resultado del backend no incluye monto recibido/cambio (eso es
      // solo informativo para el cajero), así que lo completamos aquí antes
      // de navegar a la confirmación.
      final resultConCambio = _esEfectivo
          ? result.copyWith(montoRecibido: _parseMontoRecibido(), cambio: _calcularCambio(total))
          : result;

      Navigator.of(context).pushReplacementNamed(RouteNames.saleConfirmation, arguments: resultConCambio);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = ref.watch(cartTotalProvider);
    final cambio = _esEfectivo ? _calcularCambio(total) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Cobrar')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Text('Total a cobrar', style: AppTextStyles.bodySecondary),
                  Text('\$${total.toStringAsFixed(2)}', style: AppTextStyles.price),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            Text('Método de pago', style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.sm),
            Row(
              children: List.generate(_metodos.length, (i) {
                final activo = _metodoIndex == i;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _metodoIndex = i),
                    child: Container(
                      margin: const EdgeInsets.only(right: AppSizes.sm),
                      padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                      decoration: BoxDecoration(
                        color: activo ? AppColors.primary.withValues(alpha: 0.08) : AppColors.surface,
                        border: Border.all(color: activo ? AppColors.primary : AppColors.divider),
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _metodos[i]['icon'] as IconData,
                            color: activo ? AppColors.primary : AppColors.textSecondary,
                          ),
                          const SizedBox(height: 4),
                          Text(_metodos[i]['label'] as String, style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            if (_esEfectivo) ...[
              const SizedBox(height: AppSizes.lg),
              TextField(
                controller: _montoRecibidoController,
                onChanged: (_) => setState(() {}),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Monto recibido',
                  prefixIcon: Icon(Icons.attach_money),
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              if (_montoRecibidoController.text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: cambio != null ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cambio != null ? 'Cambio a entregar' : 'Monto insuficiente',
                        style: AppTextStyles.body,
                      ),
                      Text(
                        cambio != null ? '\$${cambio.toStringAsFixed(2)}' : '—',
                        style: AppTextStyles.h3.copyWith(
                          color: cambio != null ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            const Spacer(),
            PrimaryButton(
              label: 'Confirmar venta',
              loading: _loading,
              onPressed: _puedeConfirmar(total) ? () => _handleConfirm(total) : null,
            ),
          ],
        ),
      ),
    );
  }
}
