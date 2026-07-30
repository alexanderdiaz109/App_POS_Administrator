import '../../../../core/utils/result.dart';
import '../entities/notification.dart';

abstract interface class NotificationRepository {
  Future<Result<List<AppNotification>>> getNotifications(String storeId);
  Future<Result<void>> markAsRead(String id);
}
