import 'package:equatable/equatable.dart';

class FoodAnalyticModel extends Equatable {
  final String itemName;
  final String totalQuantitySold;

  const FoodAnalyticModel({
        required this.itemName,
        required this.totalQuantitySold,
      });

  factory FoodAnalyticModel.fromJson(Map<String, dynamic> json) {
    return FoodAnalyticModel(
        itemName: json['item_name'],
        totalQuantitySold: json['total_quantity_sold']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'total_quantity_sold': totalQuantitySold
    };
  }

  @override
  List<Object?> get props => [itemName, totalQuantitySold];
}
