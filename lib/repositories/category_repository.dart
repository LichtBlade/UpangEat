import 'package:upang_eat/models/category_model.dart';
import 'package:upang_eat/models/food_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> fetchCategory();
}