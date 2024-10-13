import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:upang_eat/models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final String baseUrl;

  UserRepositoryImpl({required this.baseUrl});

  @override
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      // remove print statement after testing
      print(users.map((json) => UserModel.fromJson(json)).toList());
      return users.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<List<UserModel>> fetchUserById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      // remove print statement after testing
      print(users.map((json) => UserModel.fromJson(json)).toList());
      return users.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

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

  @override
  Future<void> updateUser(
      int id,
      String studentId,
      String firstName,
      String lastName,
      String email,
      String password,
      String mobile,
      String userType) async {
    final response = await http.put(
      Uri.parse(
        '$baseUrl/users/$id',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "student_id": studentId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "phone_number": mobile,
        "user_type": userType
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
