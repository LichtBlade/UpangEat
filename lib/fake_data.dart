import 'package:upang_eat/models/category_model.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/order_item_model.dart';
import 'package:upang_eat/models/order_model.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/models/tray_model.dart';
import 'package:upang_eat/widgets/seller_center_widgets/order_item_card.dart';

class FakeData {
  static FoodModel get fakeFood => const FoodModel(
      stallId: 0,
      foodItemId: 0,
      isAvailable: false,
      isBreakfast: false,
      isLunch: false,
      isMerienda: false,
      itemName: "Lumpiang Shanghai",
      price: 100,
      description: "Masarap to pag may birthday",
      imageUrl: "assets/stalls/profiles/1.jpg",
      stallName: "Boss Sisig!");
  static Stall get fakeStall => const Stall(
      stallId: 1,
      stallName: "Mekus Mekus tayo insan!",
      ownerId: 1,
      isActive: false,
      imageUrl: "assets/stalls/profiles/1.jpg",
      description: "Masamsamit so dirty puday neto!",
      imageBannerUrl: "assets/stalls/banners/BossSisigBanner.jpg",
      contactNumber: 09270734452);
  static CategoryModel get fakeCategory => const CategoryModel(categoryId: 0, categoryName: "Burigir", imageUrl: "assets/categories/Bread.png");
  static TrayModel get fakeTray => const TrayModel(trayId: 0, userId: 0, itemId: 0, quantity: 1);

  static List<OrderModel> get fakeOrder =>  const[
    OrderModel(
      orderId: 0,
      userId: 0, stallId: 0,
      orderDate: "9/21/24 18:15",
      totalAmount: 440,
      items: [
        OrderItemModel(itemName: "Burger", quantity: 2, subtotal: 240, imageUrl: "assets/stalls/profiles/1.jpg"),
        OrderItemModel(itemName: "Pancit Canton", quantity: 1, subtotal: 50, imageUrl: "assets/stalls/profiles/1.jpg"),
        OrderItemModel(itemName: "BJ", quantity: 1, subtotal: 150, imageUrl: "assets/stalls/profiles/1.jpg"),
      ],
      orderStatus: "pending"),
    OrderModel(
        orderId: 0,
        userId: 0, stallId: 0,
        orderDate: "9/22/24 06:15",
        totalAmount: 560,
        items: [
          OrderItemModel(itemName: "Tapsilog", quantity: 1, subtotal: 110, imageUrl: "assets/stalls/profiles/1.jpg"),
          OrderItemModel(itemName: "Iced Tea", quantity: 1, subtotal: 50, imageUrl: "assets/stalls/profiles/1.jpg"),
          OrderItemModel(itemName: "Durex: Fetherlite 3s", quantity: 1, subtotal: 160, imageUrl: "assets/stalls/profiles/1.jpg"),
        ],
        orderStatus: "pending"),
  ];
}
