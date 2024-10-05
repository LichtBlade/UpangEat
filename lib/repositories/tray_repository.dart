import 'package:upang_eat/models/tray_model.dart';

abstract class TrayRepository {
  Future<List<TrayModel>> fetchTrayByUserId(int id);
  Future<void> addToTray(TrayModel tray);
}