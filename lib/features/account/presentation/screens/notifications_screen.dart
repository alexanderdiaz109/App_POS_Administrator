import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_state.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../data/providers/notification_providers.dart';
import '../../domain/entities/notification.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationListControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notificaciones')),
      body: notificationsAsync.when(
        loading: () => const SkeletonList(),
        error: (err, _) => ErrorState(
          message: '$err',
          onRetry: () => ref.invalidate(notificationListControllerProvider),
        ),
        data: (notifications) => notifications.isEmpty
            ? const EmptyState(
                icon: Icons.notifications_none,
                title: 'Sin notificaciones',
                message: 'Aquí verás avisos sobre tu suscripción y pagos.',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSizes.md),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final n = notifications[i];
                  return ListTile(
                    leading: Icon(_iconFor(n.tipo), color: _colorFor(n.tipo)),
                    title: Text(
                      n.titulo,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: n.leida ? FontWeight.w400 : FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(n.mensaje, style: AppTextStyles.bodySecondary, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: !n.leida
                        ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))
                        : null,
                    onTap: () {
                      if (!n.leida) {
                        ref.read(notificationListControllerProvider.notifier).markAsRead(n.id);
                      }
                      _showDetail(context, n);
                    },
                  );
                },
              ),
      ),
    );
  }

  IconData _iconFor(String tipo) {
    switch (tipo) {
      case 'cobro_exitoso':
        return Icons.check_circle_outline;
      case 'cobro_fallido':
        return Icons.error_outline;
      case 'suspension':
        return Icons.pause_circle_outline;
      case 'reactivacion':
        return Icons.play_circle_outline;
      default:
        return Icons.notifications_none;
    }
  }

  Color _colorFor(String tipo) {
    switch (tipo) {
      case 'cobro_exitoso':
        return AppColors.success;
      case 'cobro_fallido':
        return AppColors.error;
      case 'suspension':
        return AppColors.statusSuspendido;
      case 'reactivacion':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }

  void _showDetail(BuildContext context, AppNotification n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(n.titulo, style: AppTextStyles.h2),
            const SizedBox(height: AppSizes.sm),
            Text(n.mensaje, style: AppTextStyles.body),
            const SizedBox(height: AppSizes.sm),
            Text(
              '${n.creadoEn.day}/${n.creadoEn.month}/${n.creadoEn.year} · ${n.creadoEn.hour.toString().padLeft(2, '0')}:${n.creadoEn.minute.toString().padLeft(2, '0')}',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
