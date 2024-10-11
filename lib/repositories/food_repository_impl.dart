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
  Future<List<FoodModel>> fetchFoodByCategory(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/foods/$id/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> foodCategoryData = json.decode(response.body);
      return foodCategoryData.map((json) => FoodModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }

  @override
  Future<List<FoodModel>> fetchTrayFood(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/foods/$id/trays'));
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
  Future<void> createFood(FoodModel food) async {
    final response = await http.post(
      Uri.parse('$baseUrl/foods'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({food.toJson()}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create Food');
    }
  }

  @override
  Future<void> updateFood(FoodModel food, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/foods/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({food.toJson()}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update food: $id');
    }
  }

  @override
  Future<void> deleteFood(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/foods/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete food: $id');
    }
  }
}
