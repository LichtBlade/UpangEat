import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final String baseUrl;

  UserRepositoryImpl({required this.baseUrl});

  @override
  Future<void> createUser({
    required String firstName,
    required String lastName,
    required String studentId,
    required String email,
    required String password,
    required String mobile,
    required String userType,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'student_id': studentId,
        'email': email,
        'password': password,
        'mobile': mobile,
        'user_type': userType,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }
}
