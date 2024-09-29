import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/food_model.dart';
import '../../repositories/food_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository _foodRepository;
  FoodBloc(this._foodRepository) : super(FoodLoading()) {
    on<LoadFood>((event, emit) async {
      emit(FoodLoading());
      try{
          final foods = await _foodRepository.fetchFood();
          emit(FoodLoaded(foods));

      } catch (error) {
        emit(FoodError(error.toString()));

      }
    });

    on<LoadFoodCategory>((event, emit) async {
      emit(FoodLoading());
      try{
        final foods = await _foodRepository.fetchFoodByCategory(event.id);
        emit(FoodLoaded(foods));
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

  }
}
