import 'package:upang_eat/models/user_model.dart';

import '../main.dart';
import 'auth_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepositoryImpl extends AuthRepository {
  final String baseUrl = IpAddress.ipAddress;


@override
  Future<UserModel> authenticate(String email,String password) async {
    print('Authenticating with email: $email, password: $password');

        final response = await http.post(Uri.parse('$baseUrl/login'),
         headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}), // Ensure correct encoding
       );

    print('API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return UserModel.fromJson(userData);
          } else {
        throw Exception('Failed to authenticate');
      }
    }
}
