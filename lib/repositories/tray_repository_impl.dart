import 'dart:convert';

import 'package:upang_eat/main.dart';
import 'package:upang_eat/models/tray_model.dart';
import 'package:upang_eat/repositories/tray_repository.dart';
import 'package:http/http.dart' as http;

class TrayRepositoryImpl extends TrayRepository {
  final String baseUrl = IpAddress.ipAddress;
  @override
  Future<void> addToTray(TrayModel tray) async {
    final response = await http.post(Uri.parse('$baseUrl/trays'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tray.toJson()));
    if (response.statusCode != 201) {
      throw Exception('Failed to add trays');
    }
  }

  @override
  Future<List<TrayModel>> fetchTrayByUserId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/trays/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> trayCategoryData = json.decode(response.body);
      return trayCategoryData.map((json) => TrayModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trays');
    }
  }

  @override
  Future<void> deleteTray(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/trays/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete tray');
    }
  }

  @override
  Future<TrayModel> updateTray(TrayModel tray, int id) async {
    final response = await http.put(Uri.parse('$baseUrl/trays/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tray.toJson()));

    if (response.statusCode == 200) {
      final dynamic trayCategoryData = json.decode(response.body);
      return trayCategoryData.map((json) => TrayModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to update tray');
    }
  }

}
