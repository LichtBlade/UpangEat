part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class FetchNotification extends NotificationEvent{
  final int userId;
  const FetchNotification(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateNotificationStatus extends NotificationEvent{
  final int userId;
  final int notificationId;
  const UpdateNotificationStatus(this.notificationId,this.userId);

  @override
  List<Object> get props => [notificationId];
}

class DeleteNotification extends NotificationEvent{
  final int userId;
  final int notificationId;
  const DeleteNotification(this.notificationId,this.userId);

  @override
  List<Object> get props => [notificationId];
}
