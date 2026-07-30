import '../../../../core/services/supabase_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';

class SupabaseNotificationRepository implements NotificationRepository {
  @override
  Future<Result<List<AppNotification>>> getNotifications(String storeId) async {
    try {
      final data = await SupabaseService.client
          .from('notificaciones')
          .select()
          .eq('store_id', storeId)
          .order('creado_en', ascending: false)
          .limit(50);
      final notifications = (data as List).map((e) => AppNotification.fromJson(e)).toList();
      return Result.success(notifications);
    } catch (e) {
      return Result.failure('Error al cargar notificaciones: $e');
    }
  }

  @override
  Future<Result<void>> markAsRead(String id) async {
    try {
      await SupabaseService.client.from('notificaciones').update({'leida': true}).eq('id', id);
      return const Result.success(null);
    } catch (e) {
      return Result.failure('Error al marcar como leída: $e');
    }
  }
}
