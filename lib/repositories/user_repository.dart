import 'package:upang_eat/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> fetchUsers();
  Future<List<UserModel>> fetchUserById(int id);

  Future<void> createUser({
    required String firstName,
    required String lastName,
    required String studentId,
    required String email,
    required String password,
    required String mobile,
    required String userType,
  });

  Future<void> updateUser(
    int id,
    String studentId,
    String firstName,
    String lastName,
    String email,
    String password,
    String mobile,
    String userType,
  );

  Future<void> deleteUser(int id);
}
