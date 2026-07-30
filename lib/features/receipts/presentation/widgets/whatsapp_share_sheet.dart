import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Bottom sheet de opciones para compartir el recibo. WhatsApp es la
/// opción principal (documentación, sección 1.1: "enviable por WhatsApp"),
/// con alternativas de PDF y copiar enlace.
/// TODO(backend/paquete): conectar con share_plus o url_launcher para
/// abrir WhatsApp real con el mensaje prellenado.
class WhatsAppShareSheet extends StatelessWidget {
  const WhatsAppShareSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (_) => const WhatsAppShareSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enviar recibo', style: AppTextStyles.h2),
            const SizedBox(height: AppSizes.md),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chat, color: Color(0xFF25D366)),
              ),
              title: const Text('Enviar por WhatsApp'),
              subtitle: const Text('Al número del cliente', style: AppTextStyles.bodySecondary),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.picture_as_pdf_outlined, color: AppColors.error),
              ),
              title: const Text('Descargar PDF'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceAlt,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.link, color: AppColors.textSecondary),
              ),
              title: const Text('Copiar enlace del recibo'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
