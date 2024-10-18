import 'package:upang_eat/models/tray_model.dart';

import '../models/food_model.dart';

abstract class TrayRepository {
  // Future<List<TrayModel>> fetchTrayByUserId(int id);
  Future<dynamic> addToTray(TrayModel tray);
  Future<void> deleteTray(int id);
  Future<void> deleteListOfTrays(List<int> trayIdsToDelete);
  Future<TrayModel> updateTray(TrayModel tray, int id);
  Future<List<FoodModel>> fetchTrayFood(int id);
}