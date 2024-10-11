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
        await _foodRepository.createFood(
            stallId: event.stallId,
            itemName: event.itemName,
            description: event.description,
            price: event.price,
            imageURL: event.imageURL,
            isAvailable: event.isAvailable,
            isBreakfast: event.isBreakfast,
            isLunch: event.isLunch,
            isMerienda: event.isMerienda);
        emit(FoodAdded());
      } catch (error) {
        emit(FoodError(error.toString()));
      }
    });

    on<UpdateFood>((event, emit) async {
      emit(FoodLoading());
      try {
        await _foodRepository.updateFood(
            event.id,
            event.stallId,
            event.itemName,
            event.description,
            event.price,
            event.imageURL,
            event.isAvailable,
            event.isBreakfast,
            event.isLunch,
            event.isMerienda);
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
