import 'dart:convert';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/repositories/admin_repository.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class AdminRepositoryImpl implements AdminRepository {
  final String baseUrl = IpAddress.ipAddress;

  @override
  Future<List<Stall>> fetchStalls() async {
    final response = await http.get(Uri.parse('$baseUrl/stalls'));

    if (response.statusCode == 200) {
      final List<dynamic> stallData = json.decode(response.body);
      return stallData.map((json) => Stall.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stalls');
    }
  }

  @override
  Future<Stall> fetchStallById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/stalls/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> stallJson = json.decode(response.body);
      return Stall.fromJson(stallJson);
    } else {
      throw Exception('Failed to load stall with id $id');
    }
  }

  @override
  Future<void> createStall({required stallName, String? description}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stalls'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'stall_name': stallName,
        'description': description ?? '',
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create stall');
    }
  }

  @override
  Future<void> updateStall(int id, String stallName, {String? description}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/stalls/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'stall_name': stallName,
        'description': description ?? '',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update stall with id $id');
    }
  }

  @override
  Future<void> deleteStall(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/stalls/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete stall with id $id');
    }
  }
}
