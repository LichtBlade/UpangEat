import 'dart:convert';

import 'package:upang_eat/main.dart';
import 'package:upang_eat/models/transaction_model.dart';
import 'package:upang_eat/repositories/transaction_repository.dart';
import 'package:http/http.dart' as http;

class TransactionRepositoryImpl extends TransactionRepository {
  final String baseUrl = IpAddress.ipAddress;

  @override
  Future<List<TransactionModel>> fetchTransactionByUserId(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/transactions/$id'));
    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body);

      return transactionData.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}