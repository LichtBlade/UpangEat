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
