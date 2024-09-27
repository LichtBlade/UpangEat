import 'package:upang_eat/models/food_model.dart';

abstract class CategoryRepository {
  Future<List<FoodModel>> fetchFoodByCategory();
}