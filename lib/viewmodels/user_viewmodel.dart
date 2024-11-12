import 'package:flutter/material.dart';
import 'package:rev_me_app/data/local/UserPreferences.dart';
import '../core/models/user.dart';
import '../core/services/auth_service.dart';

class UserViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.signIn(username, password);
      _user = User.fromJson(response);
      UserPreferences().saveUser(_user!);
      print('User: $_user');
    } catch (e) {
      _errorMessage = e.toString();
      print('Login error: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<String> register(String username, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      final response = await _authService.signUp(username, email, password);

      // Check the message in the response
      if (response['message'] == "User registered successfully!") {
        return response['message'];
      } else {
        return response['message'];
      }
    } catch (e) {
      return "Registration failed: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void logout() {
    _user = null;
    notifyListeners();
  }
}
