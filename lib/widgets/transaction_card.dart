import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upang_eat/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.white,
      elevation: 16,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TransactionDateAndType(transactionDate: transaction.transactionDate!, transactionType: transaction.transactionType),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(child: _Amount(amount: transaction.amount, transactionType: transaction.transactionType,)),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionDateAndType extends StatelessWidget {
  final String transactionType;
  final String transactionDate;
  const _TransactionDateAndType({super.key, required this.transactionType, required this.transactionDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            transactionType,
            style: const TextStyle(
              color: Color(0xFFDE0F39),
              fontSize: 20,
            ),
          ),
          Text(
            transactionDate,
            style: const TextStyle(
              color: Color(0xFF202020),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  final String transactionType;
  final int amount;
  const _Amount({super.key, required this.amount, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${getTransactionAmountWithSign(transactionType)}₱$amount",
      textAlign: TextAlign.end,
      style: TextStyle(
        color: getTransactionColor(transactionType),
        fontSize: 20,
      ),
    );
  }
  Color getTransactionColor(String transactionType) {
    switch (transactionType) {
      case 'Deposit':
      case 'Receive':
        return Colors.green;
      case 'Send':
      case 'Refund':
      case 'Withdraw':
        return Colors.red;
      default:
        return Colors.black; // Or a default color of your choice
    }
  }

  String getTransactionAmountWithSign(String transactionType) {
    switch (transactionType) {
      case 'Deposit':
      case 'Receive':
        return '+';
      case 'Send':
      case 'Refund':
      case 'Withdraw':
        return '-';
      default:
        return '';
    }
  }
}
