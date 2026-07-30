import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import '../routes/route_names.dart';

class SubscriptionBlockedDialog extends StatelessWidget {
  final String message;
  const SubscriptionBlockedDialog({super.key, required this.message});

  static Future<void> show(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (_) => SubscriptionBlockedDialog(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.lock_outline, color: AppColors.error, size: 32),
      title: const Text('Acción no disponible'),
      content: Text(message, style: AppTextStyles.body),
      actionsPadding: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, AppSizes.md),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(RouteNames.account);
          },
          child: const Text('Ir a Mi Cuenta'),
        ),
      ],
    );
  }
}
