part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object?> get props => [];
}

class LoadTransaction extends TransactionEvent {
  final int id;
  const LoadTransaction(this.id);

  @override
  List<Object?> get props => [id];
}
