import 'package:upang_eat/models/stall_model.dart';

abstract class StallRepository {
  Future<List<Stall>> fetchStalls();
  Future<Stall> fetchStallById(int id);
  Future<void> createStall();
  Future<void> updateStall(int id);
  Future<void> deleteStall(int id);
}