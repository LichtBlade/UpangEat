abstract class UserRepository {
  Future<void> createUser({
    required String firstName,
    required String lastName,
    required String studentId,
    required String email,
    required String password,
    required String mobile,
    required String userType,
  });
}
