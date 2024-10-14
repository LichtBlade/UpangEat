import 'dart:convert';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/repositories/stall_repository.dart';
import 'package:http/http.dart' as http;
import '../main.dart';


class StallRepositoryImpl implements StallRepository {
  final String baseUrl = IpAddress.ipAddress;


  @override
  Future<List<Stall>> fetchStalls() async {
  final response = await http.get(Uri.parse('$baseUrl/stalls'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Stall.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load stalls');
  }
}

  @override
  Future<Stall> fetchStallById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/stalls/$id'));

    if (response.statusCode == 200) {
      return Stall.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load stall');
    }
  }

  Future<int> fetchTotalStalls() async {
    final response = await http.get(Uri.parse('$baseUrl/total-stalls'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); 
      return data['totalStalls'];              
    } else {
      throw Exception('Failed to load total stalls');
    }
  }

  Future<int> fetchActiveStalls() async {
    final response = await http.get(Uri.parse('$baseUrl/active-stalls'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['activeStalls'] ?? 0;  
    } else {
      throw Exception('Failed to load active stalls');
    }
  }

  @override
  Future<void> createStall({
    required String stallName,
    required int ownerId,
    required int contactNumber,
    required String description,
    required bool isActive,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/stalls'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'stall_name': stallName,
        'owner_id': ownerId,
        'contact_number': contactNumber,
        'description': description,
        'is_active': isActive ? 1 : 0,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create stall');
    }
  }

  @override
  Future<void> updateStall({
    required int stallId,
    required String stallName,
    required int ownerId,
    required int contactNumber,
    required String description,
    required bool isActive,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/stalls/$stallId'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'stall_name': stallName,
        'owner_id': ownerId,
        'contact_number': contactNumber,
        'description': description,
        'is_active': isActive ? 1 : 0,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update stall');
    }
  }

    @override
    Future<void> deleteStall(int stallId) async {
      final response = await http.delete(Uri.parse('$baseUrl/stalls/$stallId'));
      print('Delete response: ${response.statusCode}, Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else {
        throw Exception('Failed to delete stall');
      }
    }

}