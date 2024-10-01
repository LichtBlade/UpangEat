part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();
  @override
  List<Object?> get props => [];
}

class LoadFood extends FoodEvent {}

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
