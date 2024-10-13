import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upang_eat/main.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/models/tray_model.dart';
import 'package:upang_eat/repositories/tray_repository.dart';
import 'package:http/http.dart' as http;

class TrayRepositoryImpl extends TrayRepository {
  final String baseUrl = IpAddress.ipAddress;
  @override
  Future<dynamic> addToTray(TrayModel tray) async {
    final response = await http.post(Uri.parse('$baseUrl/trays'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tray.toJson()));
    print(response.body);
    if (response.statusCode == 201) {
      print("201 Tray Created");
      return Stall.fromJson(json.decode(response.body));
      // return TrayModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 409) {
      final jsonResponse = json.decode(response.body);
      final newStallId = jsonResponse['newStallId'];
      final trayIdsToDelete = List<int>.from(jsonResponse['trayIdsToDelete']);
      print("wow");
      throw StallConflictException(newStallId, trayIdsToDelete);
    } else {
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
    print("tray: $tray");
    if (response.statusCode == 200) {
      final Map<String, dynamic> trayCategoryData = json.decode(response.body);
      print(trayCategoryData);
      return TrayModel.fromJson(trayCategoryData);
    } else {
      throw Exception('Failed to update tray');
    }
  }

  @override
  Future<void> deleteListOfTrays(List<int> trayIdsToDelete) async {
    final response = await http.delete(Uri.parse('$baseUrl/trays'),
    body: jsonEncode(trayIdsToDelete),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 204) {
      throw Exception('Failed to delete tray items');
    }
    print("Trays Deleted!");

  }

}

class StallConflictException implements Exception {
  final int newStallId;
  final List<int> trayIdsToDelete;
  final String message; // Add a message property

  StallConflictException(this.newStallId, this.trayIdsToDelete) :
        message = 'Stall conflict detected. New stall ID: $newStallId, Tray IDs to delete: $trayIdsToDelete';
}