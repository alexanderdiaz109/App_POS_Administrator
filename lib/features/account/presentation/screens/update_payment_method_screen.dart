import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/providers/checkout_providers.dart';
import '../../data/providers/store_providers.dart';

/// Abre el Customer Portal real de Stripe, donde el dueño puede
/// actualizar su tarjeta, ver facturas, y gestionar su suscripción —
/// toda esa UI ya la construye Stripe, no hace falta hacerla nosotros
/// (sección 3 de la documentación: "ahorra desarrollo").
class UpdatePaymentMethodScreen extends ConsumerStatefulWidget {
  const UpdatePaymentMethodScreen({super.key});

  @override
  ConsumerState<UpdatePaymentMethodScreen> createState() => _UpdatePaymentMethodScreenState();
}

class _UpdatePaymentMethodScreenState extends ConsumerState<UpdatePaymentMethodScreen> {
  bool _loading = false;

  Future<void> _openPortal(String storeId) async {
    setState(() => _loading = true);

    final repo = ref.read(checkoutRepositoryProvider);
    final result = await repo.createPortalSession(storeId);

    if (!mounted) return;
    setState(() => _loading = false);

    result.when(
      success: (url) async {
        final uri = Uri.parse(url);
        final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (!launched && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo abrir el portal de pago.')),
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

  @override
  Widget build(BuildContext context) {
    final storeAsync = ref.watch(currentStoreProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Método de pago')),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock_outline, size: 18, color: AppColors.textSecondary),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: Text(
                      'Serás redirigido a un portal seguro de Stripe para gestionar tu tarjeta y ver tu historial de facturas.',
                      style: AppTextStyles.bodySecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.xl),
            storeAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('$err', style: AppTextStyles.bodySecondary),
              data: (store) => PrimaryButton(
                label: 'Abrir portal de pago',
                icon: Icons.open_in_new,
                loading: _loading,
                onPressed: () => _openPortal(store.id),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
