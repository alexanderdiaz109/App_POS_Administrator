import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../repositories/supabase_notification_repository.dart';
import 'store_providers.dart';

part 'notification_providers.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return SupabaseNotificationRepository();
}

@riverpod
class NotificationListController extends _$NotificationListController {
  @override
  Future<List<AppNotification>> build() async {
    final store = await ref.watch(currentStoreProvider.future);
    final repo = ref.watch(notificationRepositoryProvider);
    final result = await repo.getNotifications(store.id);
    return result.when(success: (data) => data, failure: (msg) => throw Exception(msg));
  }

  Future<void> markAsRead(String id) async {
    final repo = ref.read(notificationRepositoryProvider);
    await repo.markAsRead(id);
    ref.invalidateSelf();
  }
}

/// Cantidad de notificaciones sin leer, para mostrar un badge en el icono
/// de campana del Dashboard.
@riverpod
Future<int> unreadNotificationCount(Ref ref) async {
  final notifications = await ref.watch(notificationListControllerProvider.future);
  return notifications.where((n) => !n.leida).length;
}
