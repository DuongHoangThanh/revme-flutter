import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/assessment.dart';
import 'package:rev_me_app/core/services/assessment_service.dart';
import 'package:rev_me_app/data/local/UserPreferences.dart';

class AssessmentViewModel extends ChangeNotifier {
  final AssessmentService _assessmentService = AssessmentService();
  Assessment? _assessment;

  UserPreferences _userPreferences = UserPreferences();
  String? _successMessage;
  bool _isLoading = false;
  String? _errorMessage;

  Assessment? get assessment => _assessment;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  Future<void> generateAndSavePlan(Assessment assessment) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      _isLoading = true;
      String token = await _userPreferences.getToken();
      _successMessage =
          await _assessmentService.generateAndSavePlan(token, assessment);
      print("Token : $token");
      _assessment = assessment;
    } catch (e) {
      _errorMessage = e.toString();
      print('Error: $_errorMessage');
    } finally {
      _isLoading = false;
      print('Success: $_successMessage');
      notifyListeners();
    }
  }
}
