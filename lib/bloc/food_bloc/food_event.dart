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
  final int stallId;
  final String itemName;
  final String? description;
  final int price;
  final String? imageURL;
  final bool isAvailable;
  final bool isBreakfast;
  final bool isLunch;
  final bool isMerienda;

  const CreateFood({
    required this.stallId,
    required this.itemName,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.isAvailable,
    required this.isBreakfast,
    required this.isLunch,
    required this.isMerienda,
  });
}

class UpdateFood extends FoodEvent {
  final int id;
  final int stallId;
  final String itemName;
  final String? description;
  final int price;
  final String? imageURL;
  final bool isAvailable;
  final bool isBreakfast;
  final bool isLunch;
  final bool isMerienda;

  const UpdateFood(
      {required this.id,required this.stallId,
        required this.itemName,
        required this.description,
        required this.price,
        required this.imageURL,
        required this.isAvailable,
        required this.isBreakfast,
        required this.isLunch,
        required this.isMerienda,});
}

class DeleteFood extends FoodEvent {
  final int id;
  final int stallId;
  const DeleteFood(this.id, this.stallId);

  @override
  List<Object?> get props => [id, stallId];
}
