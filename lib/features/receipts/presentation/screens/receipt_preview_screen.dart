import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../account/data/providers/store_providers.dart';
import '../../../pos/data/providers/sale_providers.dart';
import '../../../pos/domain/entities/sale_detail.dart';

class ReceiptPreviewScreen extends ConsumerStatefulWidget {
  final String saleId;
  const ReceiptPreviewScreen({super.key, required this.saleId});

  @override
  ConsumerState<ReceiptPreviewScreen> createState() => _ReceiptPreviewScreenState();
}

class _ReceiptPreviewScreenState extends ConsumerState<ReceiptPreviewScreen> {
  bool _procesando = false;

  @override
  Widget build(BuildContext context) {
    final saleAsync = ref.watch(saleDetailProvider(widget.saleId));

    return Scaffold(
      appBar: AppBar(title: const Text('Recibo digital')),
      body: saleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(saleDetailProvider(widget.saleId)),
        ),
        data: (sale) => _ReceiptContent(sale: sale, procesando: _procesando, onAction: _showOptions),
      ),
    );
  }

  void _showOptions(SaleDetail sale) {
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
              Text('Enviar recibo', style: AppTextStyles.h2),
              const SizedBox(height: AppSizes.md),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf_outlined, color: AppColors.error),
                title: const Text('Compartir PDF'),
                onTap: () {
                  Navigator.pop(context);
                  _runPdf(sale, download: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.download_outlined, color: AppColors.primary),
                title: const Text('Descargar PDF'),
                onTap: () {
                  Navigator.pop(context);
                  _runPdf(sale, download: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _runPdf(SaleDetail sale, {required bool download}) async {
    setState(() => _procesando = true);
    try {
      final store = await ref.read(currentStoreProvider.future);
      final service = ref.read(receiptPdfServiceProvider);
      if (download) {
        final path = await service.download(sale: sale, tiendaNombre: store.nombre);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Guardado en: $path'), duration: const Duration(seconds: 5)),
          );
        }
      } else {
        await service.share(sale: sale, tiendaNombre: store.nombre);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _procesando = false);
    }
  }
}

class _ReceiptContent extends StatelessWidget {
  final SaleDetail sale;
  final bool procesando;
  final void Function(SaleDetail sale) onAction;

  const _ReceiptContent({required this.sale, required this.procesando, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.lg),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                const Icon(Icons.storefront, size: 32, color: AppColors.primary),
                const SizedBox(height: AppSizes.xs),
                Text('Folio ${sale.folio}', style: AppTextStyles.h3),
                Text(
                  '${sale.fecha.day}/${sale.fecha.month}/${sale.fecha.year} · '
                  '${sale.fecha.hour.toString().padLeft(2, '0')}:${sale.fecha.minute.toString().padLeft(2, '0')}',
                  style: AppTextStyles.bodySecondary,
                ),
                const SizedBox(height: AppSizes.md),
                const _DashedDivider(),
                const SizedBox(height: AppSizes.sm),
                ...sale.items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Text('${item.cantidad}x', style: AppTextStyles.bodySecondary),
                          const SizedBox(width: AppSizes.sm),
                          Expanded(child: Text(item.nombre, style: AppTextStyles.body)),
                          Text('\$${item.subtotal.toStringAsFixed(2)}', style: AppTextStyles.body),
                        ],
                      ),
                    )),
                const SizedBox(height: AppSizes.sm),
                const _DashedDivider(),
                const SizedBox(height: AppSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppTextStyles.h3),
                    Text('\$${sale.total.toStringAsFixed(2)}', style: AppTextStyles.h2),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                QrImageView(
                  data: 'FOLIO:${sale.folio}|TOTAL:${sale.total.toStringAsFixed(2)}',
                  size: 140,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: AppSizes.xs),
                Text('Escanea para verificar este comprobante', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          PrimaryButton(
            label: 'Enviar recibo',
            icon: Icons.ios_share,
            loading: procesando,
            onPressed: () => onAction(sale),
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashCount = (constraints.maxWidth / 8).floor();
        return Row(
          children: List.generate(
            dashCount,
            (_) => Expanded(
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                color: AppColors.divider,
              ),
            ),
          ),
        );
      },
    );
  }
}
