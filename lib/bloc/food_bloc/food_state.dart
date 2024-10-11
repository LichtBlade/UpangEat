part of 'food_bloc.dart';

sealed class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

final class FoodLoading extends FoodState {}

final class FoodUpdated extends FoodState {}


final class FoodLoaded extends FoodState {
  final List<FoodModel> foods;
  int get totalPrice => foods.fold<int>(0, (sum, food) => sum + food.price * (food.trayQuantity ?? 1)); // Add this getter

  const FoodLoaded(this.foods);

  @override
  List<Object> get props => [foods];
}

final class FoodError extends FoodState {
  final String message;

  const FoodError(this.message);

  @override
  List<Object> get props => [message];
}

final class FoodAdded extends FoodState {}
