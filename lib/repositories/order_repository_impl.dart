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

  @override
  Future<int> createOrders(OrderModel order) async {
    final response = await http.post(Uri.parse('$baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(order.toJson()));
    if (response.statusCode != 201) {
      print("Not 201");
      throw Exception('Failed to create order');
    } else {
      print("Order 201");
      return response.statusCode;
    }
  }

  @override
  Future<List<OrderModel>> fetchOrdersByUserId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id/orders'));
    if (response.statusCode == 200) {
      final List<dynamic> orderData = json.decode(response.body);
      print(orderData.map((json) => OrderModel.fromJson(json)).toList());
      return orderData.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Future<List<OrderModel>> fetchOrdersByStallId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/stalls/$id/orders'));
    if (response.statusCode == 200) {
      final List<dynamic> orderData = json.decode(response.body);
      return orderData.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Future<void> updateOrders(int orderId, String status) async {
    final response = await http.put(Uri.parse('$baseUrl/orders/$orderId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"order_status": status}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to update orders');
    }
  }

  @override
  Future<void> deleteOrder(int orderId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/orders/$orderId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204) {
      return;
    } else if (response.statusCode == 400) {
      final errorMessage = json.decode(response.body)['message'] as String;
      throw OrderDeletionException(errorMessage);
    } else {
      throw Exception('Failed to delete order: $orderId');
    }
  }
}

class OrderDeletionException implements Exception {
  final String message;
  OrderDeletionException(this.message);

  @override
  String toString() => message;
}