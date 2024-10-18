import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upang_eat/repositories/food_repository.dart';
import 'package:upang_eat/repositories/food_repository_impl.dart';

import '../../models/food_analytic_model.dart';

part 'analytic_food_event.dart';
part 'analytic_food_state.dart';

class AnalyticFoodBloc extends Bloc<AnalyticFoodEvent, AnalyticFoodState> {
  final FoodRepository _analyticFoodRepository;
  AnalyticFoodBloc(this._analyticFoodRepository) : super(AnalyticFoodLoading()) {
    on<LoadAnalyticFood>((event, emit) async {
      emit(AnalyticFoodLoading());
      try {
        final foods = await _analyticFoodRepository.analyticFood(event.stallId, event.startDate, event.endDate);
        emit(AnalyticFoodLoaded(foods));
      } catch (error) {
        emit(AnalyticFoodError(error.toString()));
      }
    });
  }
}
