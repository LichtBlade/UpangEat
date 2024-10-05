import 'dart:convert';

import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/repositories/food_repository.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class FoodRepositoryImpl extends FoodRepository {
  final String baseUrl = IpAddress.ipAddress;

  @override
  Future<List<FoodModel>> fetchFood() async {
    final response = await http.get(Uri.parse('$baseUrl/foods'));
    if (response.statusCode == 200) {
      final List<dynamic> foodCategoryData = json.decode(response.body);

      return foodCategoryData.map((json) => FoodModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  @override
  Future<List<FoodModel>> fetchFoodByCategory(int id) async{
    final response = await http.get(Uri.parse('$baseUrl/foods/$id/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> foodCategoryData = json.decode(response.body);
      return foodCategoryData.map((json) => FoodModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  @override
  Future<List<FoodModel>> fetchFoodByStallId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/foods/$id/stalls'));
    if (response.statusCode == 200) {
      final List<dynamic> foodCategoryData = json.decode(response.body);
      return foodCategoryData.map((json) => FoodModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  @override
  Future<List<FoodModel>> fetchPaginatedFood(int pageKey, int itemsPerPage) async {
    final response = await http.get(Uri.parse('$baseUrl/foods?offset=$pageKey&limit=$itemsPerPage'));
    if (response.statusCode == 200) {
      final List<dynamic> foodCategoryData = json.decode(response.body);

      return foodCategoryData.map((json) => FoodModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }
}