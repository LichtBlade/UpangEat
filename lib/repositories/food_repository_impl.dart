import 'dart:convert';

import 'package:upang_eat/models/food_analytic_model.dart';
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
      print(foodCategoryData.map((json) => FoodModel.fromJson(json)).toList());
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
  Future<void> createFood(
      {required int stallId,
      required String itemName,
      String? description,
      required int price,
      String? imageURL,
      required bool isAvailable,
      required bool isBreakfast,
      required bool isLunch,
      required bool isMerienda}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/foods'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "stall_id": stallId,
        "item_name": itemName,
        "description": description ?? '',
        "price": price,
        "image_url": imageURL ?? 'assets/foods/1_1.jpg',
        "is_available": isAvailable ? 1 : 0,
        "is_breakfast": isBreakfast ? 1 : 0,
        "is_lunch": isLunch ? 1 : 0,
        "is_merienda": isMerienda ? 1 : 0
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create Food');
    }
  }

  @override
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
      bool isMerienda) async {
    final response = await http.put(
      Uri.parse('$baseUrl/foods/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "stall_id": stallId,
        "item_name": itemName,
        "description": description ?? '',
        "price": price,
        "image_url": imageURL ?? '',
        "is_available": isAvailable ? 1 : 0,
        "is_breakfast": isBreakfast ? 1 : 0,
        "is_lunch": isLunch ? 1 : 0,
        "is_merienda": isMerienda ? 1 : 0
      }),
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

    if (response.statusCode != 204) {
      throw Exception('Failed to delete food: $id');
    }
  }

  @override
  Future<List<FoodAnalyticModel>> analyticFood(int stallId, String startDate, String endDate) async {
    print("AnalyticFood!");
    final response = await http.post(Uri.parse('$baseUrl/stalls/$stallId/analytics'),
      headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"start_date" : startDate, "end_date" : endDate}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => FoodAnalyticModel.fromJson(item)).toList();
    } else {
      if (response.statusCode == 400) {
        final jsonResponse = json.decode(response.body);
        final errorMessage = jsonResponse['error'] as String;
        throw AnalyticException(errorMessage);
      } else {
        throw Exception('Failed to load analytics');
      }
    }
  }
}

class AnalyticException implements Exception {
  final String message;
  AnalyticException(this.message);

  @override
  String toString() => message;
}
