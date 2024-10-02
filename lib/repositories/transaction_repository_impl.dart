import 'dart:convert';

import 'package:upang_eat/models/transaction_model.dart';
import 'package:upang_eat/repositories/transaction_repository.dart';
import 'package:http/http.dart' as http;

class TransactionRepositoryImpl extends TransactionRepository {
  static const String baseUrl = 'http://192.168.68.104:3000';
  // static const String baseUrl = 'http://localhost:3000';

  @override
  Future<List<TransactionModel>> fetchTransaction() async {
    final response = await http.get(Uri.parse('$baseUrl/transactions'));
    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body);

      return transactionData.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }
}