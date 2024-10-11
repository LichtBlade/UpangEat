part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object> get props => [];
}

class CreateOrder extends OrderEvent {
  final int id;
  final OrderModel order;
  const CreateOrder(this.order,this.id);


  @override
  List<Object> get props => [order,id];
}

class UserFetchOrder extends OrderEvent {
  final int id;
  const UserFetchOrder(this.id);


  @override
  List<Object> get props => [id];
}