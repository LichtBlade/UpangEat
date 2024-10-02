import 'dart:convert';

import 'package:upang_eat/models/tray_model.dart';
import 'package:upang_eat/repositories/tray_repository.dart';
import 'package:http/http.dart' as http;

class TrayRepositoryImpl extends TrayRepository {
  static const String baseUrl = 'http://192.168.68.104:3000'; //CJ IP
  // static const String baseUrl = 'http://localhost:3000';
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
  Future<List<TrayModel>> fetchTrayByUserId() {
    // TODO: implement fetchTrayByUserId
    throw UnimplementedError();
  }
}
