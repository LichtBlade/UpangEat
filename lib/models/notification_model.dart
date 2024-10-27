import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'order_item_model.dart';

class NotificationModel extends Equatable {
  final int notificationId;
  final int userId;
  final int orderId;
  final String? message;
  final String? status;
  final DateTime? notificationDate;
  final bool? isDelete;

  const NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.orderId,
    this.message,
    this.status,
    this.notificationDate,
    this.isDelete,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        notificationId: json['notification_id'],
        userId: json['user_id'],
        orderId: json['order_id'],
        message: json['message'],
        status: json['status'],
        notificationDate: DateTime.parse(json['created_at']).toLocal(),
        isDelete: json['is_delete'] == 1
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_id': notificationId,
      'user_id': userId,
      'order_id': orderId,
      'message': message,
      'status': status,
      'created_at': notificationDate,
      'is_delete': isDelete
    };
  }

  @override
  List<Object?> get props => [
    notificationId,
    userId,
    orderId,
    message,
    status,
    notificationDate,
    isDelete];
}
