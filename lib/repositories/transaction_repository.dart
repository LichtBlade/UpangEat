import 'package:upang_eat/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<TransactionModel>> fetchTransactionByUserId(int id);

  Future<List<TransactionModel>> fetchTransaction();
}
