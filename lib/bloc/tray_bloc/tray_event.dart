part of 'tray_bloc.dart';

sealed class TrayEvent extends Equatable {
  const TrayEvent();

  @override
  List<Object> get props => [];
}

class TrayLoadFood extends TrayEvent {
  final int id;
  const TrayLoadFood(this.id);

  @override
  List<Object> get props => [id];
}

class CreateTray extends TrayEvent{
  final int userId;
  final int foodItemId;
  final int quantity;
  const CreateTray(this.userId,this.foodItemId, this.quantity);

  @override
  List<Object> get props => [userId, foodItemId, quantity];
}

class DeleteTray extends TrayEvent {
  final int id;
  const DeleteTray(this.id);

  @override
  List<Object> get props => [id];
}

class StallConflictDeleteTrayIds extends TrayEvent {
  final List<int> id;
  final int userId;
  final int foodItemId;
  final int quantity;
  const StallConflictDeleteTrayIds(this.id, this.userId,this.foodItemId, this.quantity);

  @override
  List<Object> get props => [id, userId, foodItemId, quantity];
}

class DeleteTrayIds extends TrayEvent {
  final List<int> id;
  const DeleteTrayIds(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTray extends TrayEvent {
  final TrayModel tray;
  final int id;
  final int userId;
  const UpdateTray(this.id, this.tray, this.userId);

  @override
  List<Object> get props => [id, tray];
}
