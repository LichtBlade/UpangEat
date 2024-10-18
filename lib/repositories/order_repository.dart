import 'package:upang_eat/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> fetchOrders(int id);
  Future<List<OrderModel>> fetchOrdersByUserId(int id);
  Future<List<OrderModel>> fetchOrdersByStallId(int id);
  Future<int> createOrders(OrderModel order);
  Future<void> updateOrders(int orderId, String status);
  Future<void> deleteOrder(int orderId);
}