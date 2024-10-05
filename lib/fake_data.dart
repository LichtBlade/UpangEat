import 'package:upang_eat/models/category_model.dart';
import 'package:upang_eat/models/food_model.dart';
import 'package:upang_eat/models/stall_model.dart';
import 'package:upang_eat/models/tray_model.dart';

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
  static CategoryModel get fakeCategory => const CategoryModel(
      categoryId: 0,
      categoryName: "Burigir",
      imageUrl: "assets/categories/Bread.png");
  static TrayModel get fakeTray => const TrayModel(trayId: 0, userId: 0, itemId: 0, quantity: 1);
}
