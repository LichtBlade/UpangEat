part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvent {
  final OrderModel order;
  const CreateOrder(this.order);


  @override
  List<Object> get props => [order];
}
