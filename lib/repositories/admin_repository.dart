import 'package:upang_eat/models/stall_model.dart';

abstract class AdminRepository {
  Future<List<Stall>> fetchStalls();
  Future<Stall> fetchStallById(int id);
  Future<void> createStall({required String stallName, String? description});
  Future<void> updateStall(int id, String stallName, {String? description});
  Future<void> deleteStall(int id);
}
