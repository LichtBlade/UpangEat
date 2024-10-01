import 'package:equatable/equatable.dart';

class FoodModel extends Equatable {
  final int foodItemId;
  final int stallId;
  final String itemName;
  final String? description;
  final int price;
  final String? imageUrl;
  final bool isAvailable;
  final bool isBreakfast;
  final bool isLunch;
  final bool isMerienda;
  final String? stallName;

  const FoodModel(
      {required this.foodItemId,
      required this.stallId,
      required this.itemName,
      this.description,
      required this.price,
      this.imageUrl,
      required this.isAvailable,
      required this.isBreakfast,
      required this.isLunch,
      required this.isMerienda,
      this.stallName});

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodItemId: json['item_id'],
      stallId: json['stall_id'],
      itemName: json['item_name'],
      description: json['description'] ?? "No Desc",
      price: json['price'],
      imageUrl: json['image_url'] ?? "assets/stalls/profiles/1.jpg",
      isAvailable: json['is_available'] == 1,
      isBreakfast: json['is_breakfast'] == 1,
      isLunch: json['is_lunch'] == 1,
      isMerienda: json['is_merienda'] == 1,
        stallName: json['stall_name'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food_item_id': foodItemId,
      'stall_id': stallId,
      'item_name': itemName,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'is_available': isAvailable ? 1 : 0,
      'is_breakfast': isBreakfast ? 1 : 0,
      'is_lunch': isLunch ? 1 : 0,
      'is_merienda': isMerienda ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [foodItemId, stallId, itemName, description, price, imageUrl, isAvailable, isBreakfast, isLunch, isMerienda];
}
