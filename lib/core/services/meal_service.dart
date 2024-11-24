import 'dart:convert';
import '../../data/local/UserPreferences.dart';
import '../../data/remote/ApiService.dart';
import 'package:http/http.dart' as http;

import '../models/meal.dart';

class MealService {
  Future<List<Meal>> getAllMeals(String date) async {
    final url = Uri.parse('${ApiService.URL_BASE}/meals/$date');
    print(url);
    var cookie = await UserPreferences().getCookie();

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json", 'Cookie': cookie!},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = json.decode(response.body);
      final List<dynamic> mealsJson = responseJson['mealPlans'];
      return mealsJson.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  // Cập nhật trạng thái meal
  Future<String> updateMealStatus(int id, bool status) async {
    var token = await UserPreferences().getToken();

    final url = Uri.parse(
        '${ApiService.URL_BASE}/meals/complete/$id?Authorization=$token');
    var cookie = await UserPreferences().getCookie();

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Cookie': cookie!,
      },
    );

    if (response.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception(
          'Failed to update meal status: ${response.statusCode} - ${response.body}');
    }
  }
}
