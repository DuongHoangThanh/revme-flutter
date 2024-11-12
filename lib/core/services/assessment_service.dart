import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rev_me_app/data/remote/ApiService.dart';

import '../models/assessment.dart';
import '../models/user.dart';

class AssessmentService {

  Future<String> generateAndSavePlan(String token, Assessment assessment) async {
    final url = Uri.parse('${ApiService.URL_BASE}/api/plan/generate-and-save');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(assessment.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body; // Return the success message
    } else {
      throw Exception('Failed to generate and save plan: ${response.body}');
    }
  }
}
