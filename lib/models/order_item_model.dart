import 'package:equatable/equatable.dart';

class OrderItemModel extends Equatable {
  final String itemName;
  final int quantity;
  final int subtotal;
  final String? imageUrl;

  const OrderItemModel({
    required this.itemName,
    required this.quantity,
    required this.subtotal,
    this.imageUrl,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemName: json['item_name'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      imageUrl: json['image_url'] == "" ? "assets/stalls/profiles/1.jpg" : "assets/stalls/profiles/1.jpg",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'quantity': quantity,
      'subtotal': subtotal,
      'image_url': imageUrl
    };
  }

  @override
  List<Object?> get props => [itemName,quantity,
    subtotal,
    imageUrl];
}