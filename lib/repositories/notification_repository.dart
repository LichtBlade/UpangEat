import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> fetchNotificationByUserId(int id);
  Future<void> updateNotificationRead(int id, String status);
  Future<void> deleteNotification(int id);
}
