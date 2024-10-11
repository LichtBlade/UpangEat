import 'package:upang_eat/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> fetchOrders(int id);
}