
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/user.dart';

class UserPreferences {

  // Use Share Preferences to store user data
  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  // Get user data from Share Preferences
  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // get token from Share Preferences
 Future<String> getToken()  async {
    User? user = await getUser();
    return user!.token;
  }

  Future<String?> getCookie() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cookie');
  }
}