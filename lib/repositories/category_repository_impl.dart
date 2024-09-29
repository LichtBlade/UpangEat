import 'dart:convert';

import 'package:upang_eat/models/category_model.dart';
import 'package:upang_eat/repositories/category_repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepositoryImpl extends CategoryRepository {
  static const String baseUrl = 'http://localhost:3000';


  @override
  Future<List<CategoryModel>> fetchCategory() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> categoryData = json.decode(response.body);
      return categoryData.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

}