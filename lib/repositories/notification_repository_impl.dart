import 'dart:convert';

import 'package:upang_eat/repositories/notification_repository.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl extends NotificationRepository{
  final String baseUrl = IpAddress.ipAddress;

  @override
  Future<void> deleteNotification(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/notifications/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete order: $id');
    }
  }

  @override
  Future<List<NotificationModel>> fetchNotificationByUserId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/notifications/users/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> notificationData = json.decode(response.body);
      print(notificationData.map((json) => NotificationModel.fromJson(json)).toList());
      return notificationData.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Future<void> updateNotificationRead(int id, String status) async {
    final response = await http.put(Uri.parse('$baseUrl/notifications/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"status": status}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Failed to update orders');
    }
  }
}
