import 'auth_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl;

  AuthRepositoryImpl({required this.baseUrl});

@override
  Future<String> authenticate({required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/login');
    print('Making API request to: $url'); // debugging API request
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    
    print('API Response: ${response.statusCode} - ${response.body}'); // debugging API response

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Parsed user type: ${data['user_type']}'); // debugging parsed data
      return data['user_type']; 
    } else {
      throw Exception('Failed to authenticate: ${response.body}');
    }
  }
}
