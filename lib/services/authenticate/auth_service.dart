import 'dart:convert';
import 'package:hanaang_app/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.apiUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }

  Future<Map<String, dynamic>> logout(String token) async {
    final response = await http.post(Uri.parse('${BaseUrl.apiUrl}/logout'),
        body: jsonEncode({}),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message']);
    }
  }
}
