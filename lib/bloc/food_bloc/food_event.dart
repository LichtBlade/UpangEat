part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();
  @override
  List<Object?> get props => [];
}

class LoadFood extends FoodEvent {}

class LoadFoodTray extends FoodEvent {
  final int id;
  const LoadFoodTray(this.id);

  @override
  List<Object> get props => [id];
}

class LoadFoodCategory extends FoodEvent {
  final int id;
  const LoadFoodCategory(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadFoodByStallId extends FoodEvent {
  final int id;
  const LoadFoodByStallId(this.id);

  @override
  List<Object?> get props => [id];
}

class ResetFoodState extends FoodEvent {}

class CreateFood extends FoodEvent {
  final FoodModel food;

  const CreateFood({required this.food});

  @override
  List<Object?> get props => [food];
}

class UpdateFood extends FoodEvent {
  final int id;
  final FoodModel food;

  const UpdateFood({required this.id, required this.food});

  @override
  List<Object?> get props => [id, food];
}

class DeleteFood extends FoodEvent {
  final int id;
  const DeleteFood(this.id);

  @override
  List<Object?> get props => [id];
}
