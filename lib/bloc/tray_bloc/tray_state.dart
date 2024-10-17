part of 'tray_bloc.dart';

sealed class TrayState extends Equatable {
  const TrayState();
  @override
  List<Object> get props => [];
}

final class TrayLoading extends TrayState {}

final class TrayItemRemoved extends TrayState {
  final int id;
  const TrayItemRemoved(this.id);

  @override
  List<Object> get props => [id];
}

final class TrayItemsRemoved extends TrayState {}

final class TrayFoodLoaded extends TrayState {
  final List<FoodModel> foods;
  int get totalPrice => foods.fold<int>(0, (sum, food) => sum + food.price * (food.trayQuantity ?? 1)); // Add this getter
  const TrayFoodLoaded(this.foods);

  @override
  List<Object> get props => [foods];
}

final class TrayAdded extends TrayState {
  final Stall stall;
  const TrayAdded(this.stall);

  @override
  List<Object> get props => [stall];
}


final class TrayStallConflict extends TrayState {
  final List<int> trayIdsToDelete;
  const TrayStallConflict(this.trayIdsToDelete);

  @override
  List<Object> get props => [trayIdsToDelete];
}

final class TrayError extends TrayState {
  final String message;

  const TrayError(this.message);

  @override
  List<Object> get props => [message];
}
