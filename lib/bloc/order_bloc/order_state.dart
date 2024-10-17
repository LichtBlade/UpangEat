part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderLoading extends OrderState {}

final class OrderAdded extends OrderState {}

final class OrderDeleted extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<OrderModel> order;
  const OrderLoaded(this.order);

  @override
  List<Object> get props => [order];
}

final class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object> get props => [message];}
