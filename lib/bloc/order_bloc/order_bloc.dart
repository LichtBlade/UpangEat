import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:upang_eat/user_data.dart';

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


        final orders = await _orderRepository.fetchOrdersByUserId(event.id);
        emit (OrderLoaded(orders));
        globalOrders = orders;
      } catch (error) {
        emit(OrderError(error.toString()));
      }
    });

    on<UserFetchOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await _orderRepository.fetchOrdersByUserId(event.id);
        emit (OrderLoaded(orders));
        globalOrders = orders;
      } catch (error) {
        emit(OrderError(error.toString()));
      }
    });

    on<StallFetchOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await _orderRepository.fetchOrdersByStallId(event.id);
        emit (OrderLoaded(orders));
        globalOrders = orders;
      } catch (error) {
        emit(OrderError(error.toString()));
      }
    });

    on<UpdateOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        await _orderRepository.updateOrders(event.orderId, event.status);

        final orders = await _orderRepository.fetchOrdersByStallId(event.stallId);
        emit (OrderLoaded(orders));
        globalOrders = orders;
      } catch (error) {
        emit(OrderError(error.toString()));
      }
    });

    on<DeleteOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        await _orderRepository.deleteOrder(event.orderId);
        emit (OrderDeleted());

        final orders = await _orderRepository.fetchOrdersByStallId(event.stallId);
        emit (OrderLoaded(orders));
        globalOrders = orders;
      } catch (error) {
        emit(OrderError(error.toString()));
      }
    });

  }
}
