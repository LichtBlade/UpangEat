part of 'analytic_food_bloc.dart';

sealed class AnalyticFoodEvent extends Equatable {
  const AnalyticFoodEvent();
  @override
  List<Object?> get props => [];
}

class LoadAnalyticFood extends AnalyticFoodEvent {
  final int stallId;
  final String startDate;
  final String endDate;
  const LoadAnalyticFood(this.stallId, this.startDate, this.endDate);

  @override
  List<Object?> get props => [stallId,
    startDate,
    endDate];
}
