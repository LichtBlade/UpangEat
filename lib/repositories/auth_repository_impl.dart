import 'auth_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl;

  AuthRepositoryImpl({required this.baseUrl});

@override
  Future<String> authenticate({required String email, required String password}) async {
    print('Authenticating with email: $email, password: $password');

        final response = await http.post(
        Uri.parse('http://localhost:3000/login'),
         headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
           },
        body: jsonEncode({'email': email, 'password': password}), // Ensure correct encoding
       );

    print('API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('Parsed response: ${jsonData['user_type']}');
          return jsonData['user_type']; // Assuming the API returns `user_type`
          } else {
        throw Exception('Failed to authenticate');
      }
    }
}
