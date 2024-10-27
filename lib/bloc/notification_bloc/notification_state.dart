part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}

final class NotificationLoading extends NotificationState {}

final class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  const NotificationLoaded(this.notifications);

  @override
  List<Object> get props => [notifications];
}

final class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}
