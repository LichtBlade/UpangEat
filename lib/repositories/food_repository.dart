import 'package:upang_eat/models/food_model.dart';

abstract class FoodRepository {
  Future<List<FoodModel>> fetchFood();
  Future<List<FoodModel>> fetchFoodByCategory(int id);
  Future<List<FoodModel>> fetchTrayFood(int id);
  Future<List<FoodModel>> fetchFoodByStallId(int id);
  Future<dynamic> createFood(
      {required int stallId,
      required String itemName,
      String? description,
      required int price,
      String? imageURL,
      required bool isAvailable,
      required bool isBreakfast,
      required bool isLunch,
      required bool isMerienda});
  Future<void> updateFood(
      int id,
      int stallId,
      String itemName,
      String? description,
      int price,
      String? imageURL,
      bool isAvailable,
      bool isBreakfast,
      bool isLunch,
      bool isMerienda);
  Future<void> deleteFood(int id);
}
