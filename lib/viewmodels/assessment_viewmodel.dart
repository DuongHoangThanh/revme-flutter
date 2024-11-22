import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/assessment.dart';
import 'package:rev_me_app/core/services/assessment_service.dart';

class AssessmentViewModel extends ChangeNotifier {
 final AssessmentService _assessmentService = AssessmentService();
 Assessment? _assessment;

 String? _successMessage;
 bool _isLoading = false;
 String? _errorMessage;

 Assessment? get assessment => _assessment;
 bool get isLoading => _isLoading;
 String? get errorMessage => _errorMessage;
 String? get successMessage => _successMessage;

  Future<void> generateAndSavePlan(Assessment assessment, String token) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      _isLoading = true;
      print("Token : $token");
      // print("Assessment : $assessment");
      print(json.encode(assessment.toJson()));

      _successMessage= await _assessmentService.generateAndSavePlan(token,assessment);

      // Wait for 3 senconds and change _isLoading to false
      // await Future.delayed(Duration(seconds: 3));

      _isLoading = false;
      _successMessage = 'Assessment saved successfully';
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