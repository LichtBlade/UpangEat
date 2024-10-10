part of 'tray_bloc.dart';

sealed class TrayEvent extends Equatable {
  const TrayEvent();

  @override
  List<Object> get props => [];
}

class LoadTray extends TrayEvent {
  final int id;
  const LoadTray(this.id);

  @override
  List<Object> get props => [id];
}

class CreateTray extends TrayEvent{
  final int foodItemId;
  final int quantity;
  const CreateTray(this.foodItemId, this.quantity);

  @override
  List<Object> get props => [foodItemId, quantity];
}

class DeleteTray extends TrayEvent {
  final int id;
  const DeleteTray(this.id);

  @override
  List<Object> get props => [id];
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
  const UpdateTray(this.id, this.tray);

  @override
  List<Object> get props => [id, tray];
}
