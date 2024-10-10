import 'dart:convert';

import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/repositories/order_repository.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class OrderRepositoryImpl extends OrderRepository{
  final String baseUrl = IpAddress.ipAddress;
  @override
  Future<List<OrderModel>> fetchOrders(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/stalls/$id/orders'));
    if (response.statusCode == 200) {
      final List<dynamic> orderData = json.decode(response.body);

      return orderData.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

}