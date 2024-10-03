part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
}

final class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

final class TransactionLoading extends TransactionState {
  @override
  List<Object> get props => [];
}

final class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactions;

  const TransactionLoaded(this.transactions);
  @override
  List<Object> get props => [transactions];
}

final class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);
  @override
  List<Object> get props => [message];
}
