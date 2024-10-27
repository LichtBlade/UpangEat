import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/notification_model.dart';
import '../../repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepository;
  NotificationBloc(this._notificationRepository) : super(NotificationLoading()) {
    on<FetchNotification>((event, emit) async {
      emit(NotificationLoading());
      try{
        final notifications = await _notificationRepository.fetchNotificationByUserId(event.userId);
        emit(NotificationLoaded(notifications));
      } catch (error){
        emit(NotificationError(error.toString()));
      }
    });

    on<DeleteNotification>((event, emit) async {
      emit(NotificationLoading());
      try{
        await _notificationRepository.deleteNotification(event.notificationId);

        final notifications = await _notificationRepository.fetchNotificationByUserId(event.userId);
        emit(NotificationLoaded(notifications));
      } catch (error){
        emit(NotificationError(error.toString()));
      }
    });

    on<UpdateNotificationStatus>((event, emit) async {
      try{
        await _notificationRepository.updateNotificationRead(event.notificationId, "read");
      } catch (error){
        emit(NotificationError(error.toString()));
      }
    });
  }
}
