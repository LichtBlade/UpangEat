import 'package:upang_eat/models/stall_model.dart';

abstract class StallRepository {
  Future<List<Stall>> fetchStalls();
  Future<Stall> fetchStallById(int id);
  
  Future<void> createStall({
    required String stallName,
    required int ownerId,
    required int contactNumber,
    required String description,
    required bool isActive,
  });

  Future<void> updateStall({
    required int stallId,
    required String stallName,
    required int ownerId,
    required int contactNumber,
    required String description,
    required bool isActive,
  });
  
  Future<void> deleteStall(int id);
}