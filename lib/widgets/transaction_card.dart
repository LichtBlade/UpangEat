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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 100,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 10),
                child: Row(
                  children: [
                    Text(
                      transaction.transactionType,
                      style: const TextStyle(
                        color: Color(0xFFDE0F39),
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(top: 10, right: 40),
                        child: Text(
                          transaction.amount.toStringAsFixed(2), // Display as currency
                          style: const TextStyle(
                            color: Color(0xFF202020),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      "text",
                      // DateFormat('yyyy-MM-dd').format(transaction.transactionDate), // Format the date
                      style: const TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
