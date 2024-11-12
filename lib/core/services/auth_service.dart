import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rev_me_app/data/remote/ApiService.dart';

import '../models/user.dart';

class AuthService {

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    final url = Uri.parse('${ApiService.URL_BASE}/auth/signin');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to sign in');
    }
  }

  Future<Map<String, dynamic>> signUp(String username, String email, String password) async {
    final url = Uri.parse('${ApiService.URL_BASE}/auth/signup');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'role': ["ROLE_USE"],
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to sign up');
    }
  }
}