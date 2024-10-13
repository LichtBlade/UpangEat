import 'package:upang_eat/models/stall_model.dart';

abstract class AdminRepository {
  Future<List<Stall>> fetchStalls();
  Future<Stall> fetchStallById(int id);
  Future<void> createStall({
    required stallName,
    String? description,
    required String ownerId,
    required String contactNo,
  });
  Future<void> updateStall(
      {required int id, required String stallName, String? description});
  Future<void> deleteStall(int id);
}
