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

class StallFetchOrder extends OrderEvent {
  final int id;
  const StallFetchOrder(this.id);


  @override
  List<Object> get props => [id];
}

class UpdateOrder extends OrderEvent {
  final int orderId;
  final int stallId;
  final String status;
  const UpdateOrder(this.orderId, this.stallId, this.status);


  @override
  List<Object> get props => [orderId ,stallId,status];
}

class DeleteOrder extends OrderEvent {
  final int orderId;
  final int stallId;
  const DeleteOrder(this.orderId, this.stallId);


  @override
  List<Object> get props => [orderId];
}



