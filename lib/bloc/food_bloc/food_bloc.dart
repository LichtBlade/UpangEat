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
      try {
        final foods = await _foodRepository.fetchFood();
        emit(FoodLoaded(foods));
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<LoadFoodTray>((event, emit) async {
      emit(FoodLoading());
      try {
        final foods = await _foodRepository.fetchTrayFood(event.id);
        emit(FoodLoaded(foods));
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<LoadFoodCategory>((event, emit) async {
      emit(FoodLoading());
      try {
        final foods = await _foodRepository.fetchFoodByCategory(event.id);
        emit(FoodLoaded(foods));
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<LoadFoodByStallId>((event, emit) async {
      emit(FoodLoading());
      try {
        final foods = await _foodRepository.fetchFoodByStallId(event.id);
        emit(FoodLoaded(foods));
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<CreateFood>((event, emit) async {
      emit(FoodLoading());
      try {
        final food = await _foodRepository.createFood(event.food);
        emit(FoodAdded(food));
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<UpdateFood>((event, emit) async {
      emit(FoodLoading());
      try {
        await _foodRepository.updateFood(event.food, event.id);
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<DeleteFood>((event, emit) async {
      emit(FoodLoading());
      try {
        await _foodRepository.deleteFood(event.id);
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });
  }
}
