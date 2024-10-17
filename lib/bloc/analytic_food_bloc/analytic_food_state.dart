part of 'analytic_food_bloc.dart';

sealed class AnalyticFoodState extends Equatable {
  const AnalyticFoodState();
  @override
  List<Object> get props => [];
}

final class AnalyticFoodLoading extends AnalyticFoodState {}

final class AnalyticFoodLoaded extends AnalyticFoodState {
  final List<FoodAnalyticModel> foodAnalytics;
  const AnalyticFoodLoaded(this.foodAnalytics);

  @override
  List<Object> get props => [foodAnalytics];
}

final class AnalyticFoodError extends AnalyticFoodState {
  final String message;

  const AnalyticFoodError(this.message);

  @override
  List<Object> get props => [message];
}


