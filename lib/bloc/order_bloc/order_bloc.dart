import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upang_eat/bloc/tray_bloc/tray_bloc.dart';

import '../../models/order_model.dart';
import '../../repositories/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  OrderBloc(this._orderRepository) : super(OrderLoading()) {
    on<CreateOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        final newOrder = OrderModel(orderId: 0, userId: event.order.userId, stallId: event.order.stallId, totalAmount: event.order.totalAmount, items: event.order.items, orderStatus: event.order.orderStatus);
        await _orderRepository.createOrders(newOrder);
        emit (OrderAdded());
      } catch (error) {
        emit(OrderError(error.toString()));
      }
    });
  }
}
