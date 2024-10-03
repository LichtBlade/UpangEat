import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final int transactionId;
  final String transactionType;
  final DateTime transactionDate;
  final double transactionAmount;

  const TransactionModel({
    required this.transactionId,
    required this.transactionType,
    required this.transactionDate,
    required this.transactionAmount,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        transactionId: json['transaction_id'],
        transactionType: json['transaction_name'],
        transactionDate: json['transaction_date'],
        transactionAmount: json['transaction_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'transaction_name': transactionType,
      'transaction_amount': transactionDate,
      'transaction_date': transactionAmount,
    };
  }

  @override
  List<Object?> get props => [transactionId, transactionType, transactionDate, transactionAmount];
}
