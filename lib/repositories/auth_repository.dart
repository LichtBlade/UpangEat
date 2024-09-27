abstract class AuthRepository {
  Future<String> authenticate({required String email, required String password});
}
