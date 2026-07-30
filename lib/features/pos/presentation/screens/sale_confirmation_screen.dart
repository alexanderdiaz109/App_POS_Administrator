import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/sale_result.dart';

class SaleConfirmationScreen extends StatelessWidget {
  final SaleResult result;
  const SaleConfirmationScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final tieneCambio = result.montoRecibido != null && result.cambio != null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 52),
              ),
              const SizedBox(height: AppSizes.lg),
              Text('Venta registrada', style: AppTextStyles.h1, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.xs),
              Text('Folio ${result.folio}', style: AppTextStyles.bodySecondary),
              const SizedBox(height: AppSizes.md),
              Text('\$${result.total.toStringAsFixed(2)}', style: AppTextStyles.price),
              if (tieneCambio) ...[
                const SizedBox(height: AppSizes.lg),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Recibido', style: AppTextStyles.bodySecondary),
                          Text('\$${result.montoRecibido!.toStringAsFixed(2)}', style: AppTextStyles.body),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cambio', style: AppTextStyles.bodySecondary),
                          Text(
                            '\$${result.cambio!.toStringAsFixed(2)}',
                            style: AppTextStyles.h3.copyWith(color: AppColors.success),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSizes.xl),
              PrimaryButton(
                label: 'Ver recibo',
                icon: Icons.receipt_long_outlined,
                onPressed: () => Navigator.of(context).pushNamed(RouteNames.receiptPreview, arguments: result.id),
              ),
              const SizedBox(height: AppSizes.sm),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.mainShell, (route) => false),
                child: const Text('Nueva venta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
