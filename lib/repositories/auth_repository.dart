import 'package:upang_eat/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> authenticate(String email, String password);
}
