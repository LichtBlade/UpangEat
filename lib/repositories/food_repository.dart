import 'package:upang_eat/models/food_model.dart';

abstract class FoodRepository {
  Future<List<FoodModel>> fetchFood();
  Future<List<FoodModel>> fetchFoodByCategory(int id);
  Future<List<FoodModel>> fetchTrayFood(int id);
  Future<List<FoodModel>> fetchFoodByStallId(int id);
  Future<dynamic> createFood(FoodModel food);
  Future<void> updateFood(FoodModel food, int id);
  Future<void> deleteFood(int id);
}
