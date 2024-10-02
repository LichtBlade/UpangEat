import 'package:equatable/equatable.dart';

class TrayModel extends Equatable {
  final int trayId;
  final int userId;
  final int itemId;
  final int quantity;

  const TrayModel(
      {required this.trayId,
        required this.userId,
        required this.itemId,
        required this.quantity,});

  factory TrayModel.fromJson(Map<String, dynamic> json) {
    return TrayModel(
        trayId: json['tray_id'],
        userId: json['user_id'],
        itemId: json['item_id'],
        quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tray_id': trayId,
      'user_id': userId,
      'item_id': itemId,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [trayId, userId, itemId, quantity];
}
