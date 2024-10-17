import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class TransactionModel extends Equatable {
  final int transactionId;
  final int userId;
  final String transactionType;
  final int amount;
  final int? sourceId;
  final int? destinationId;
  final String? transactionDate;
  final String status;
  final String? description;

  const TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.transactionType,
    required this.amount,
    this.sourceId,
    this.destinationId,
    this.transactionDate,
    required this.status,
    this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transaction_id'],
      userId: json['user_id'],
      transactionType: _toSentenceCase(json['transaction_type']),
      amount: json['amount'],
      sourceId: json['source_id'],
      destinationId: json['destination_id'],
      transactionDate: json['transaction_date'] != null
          ? DateFormat("M/d/yy HH:mm").format(DateTime.parse(json['transaction_date']))
          : null,  // Handle potential null values
      status: _toSentenceCase(json['status']),
      description: json['description'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'user_id': userId,
      'transaction_type': transactionType,
      'amount': amount,
      'source_id': sourceId,
      'destination_id': destinationId,
      'transaction_date': transactionDate,
      'status': status,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
        transactionId,
        userId,
        transactionType,
        amount,
        sourceId,
        destinationId,
        transactionDate,
        status,
        description
      ];

  static String _toSentenceCase(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1).toLowerCase();
  }
}

