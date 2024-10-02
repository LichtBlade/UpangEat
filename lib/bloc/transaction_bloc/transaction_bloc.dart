import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:upang_eat/models/transaction_model.dart';
import 'package:upang_eat/repositories/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc(this._transactionRepository) : super(TransactionInitial()) {
    on<LoadTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await _transactionRepository.fetchTransaction();
        emit(TransactionLoaded(transactions));
      } catch(error) {
        emit(TransactionError(error.toString()));
      }
    });
  }
}