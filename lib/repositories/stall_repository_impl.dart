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
      final List<dynamic> stallData = json.decode(response.body);
      return stallData.map((json) => Stall.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  @override
  Future<Stall> fetchStallById(int id) async {
    // TODO: implement fetchStallById
    throw UnimplementedError();
  }

  @override
  Future<void> createStall() async {
    // TODO: implement createStall
    throw UnimplementedError();
  }

  @override
  Future<void> updateStall(int id) async {
    // TODO: implement updateStall
    throw UnimplementedError();
  }

  @override
  Future<void> deleteStall(int id) async {
    // TODO: implement deleteStall
    throw UnimplementedError();
  }

}