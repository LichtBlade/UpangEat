import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'order_item_model.dart';

class OrderModel extends Equatable {
  final int orderId;
  final int userId;
  final int stallId;
  final String orderDate;
  final int totalAmount;
  final List<OrderItemModel> items;
  final String orderStatus;
  final String? customerName;

  const OrderModel({
    required this.orderId,
    required this.userId,
    required this.stallId,
    required this.orderDate,
    required this.totalAmount,
    required this.items,
    required this.orderStatus,
    this.customerName
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        orderId: json['order_id'],
        userId: json['user_id'],
        stallId: json['stall_id'],
        orderDate: DateFormat("M/d/yy HH:mm").format(DateTime.parse(json['order_date'])),
        totalAmount: json['total_amount'],
        items: (json['items'] as List<dynamic>)
        .map((itemJson) => OrderItemModel.fromJson(itemJson))
        .toList(),
        orderStatus: json['order_status'],
        customerName: json["customer_name"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'stall_id': stallId,
      'order_date': orderDate,
      'total_amount': totalAmount,
      'items': items,
      'order_status': orderStatus
    };
  }

  @override
  List<Object?> get props => [orderId,
    userId,
    stallId,
    orderDate,
    totalAmount,
    items,
    orderStatus];
}
