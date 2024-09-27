import 'dart:convert';

import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/repositories/category_repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepositoryImpl extends CategoryRepository {
  static const String baseUrl = 'http://localhost:3000/foods';

  @override
  Future<List<FoodModel>> fetchFoodByCategory() async{
    final response = await http.get(Uri.parse('$baseUrl/1/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> foodCategoryData = json.decode(response.body);
      print(foodCategoryData);
      return foodCategoryData.map((json) => FoodModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

}