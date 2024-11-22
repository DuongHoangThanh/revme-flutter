import 'package:flutter/material.dart';
import '../core/models/meal.dart';
import '../core/services/meal_service.dart';

class MealViewModel extends ChangeNotifier {
  final MealService _mealService = MealService();
  List<Meal> _meals = [];
  double? _caloriesConsumedPerDay;
  double? _caloriesTargetPerDay;
  int? _percent;

  List<Meal> get meals => _meals;

  double get caloriesConsumedPerDay => _caloriesConsumedPerDay ?? 0.0;

  double get caloriesTargetPerDay => _caloriesTargetPerDay ?? 0.0;

  int get percent => _percent ?? 0;

  set caloriesConsumedPerDay(double value) {
    _caloriesConsumedPerDay = value;
    notifyListeners();
  }

  set caloriesTargetPerDay(double value) {
    _caloriesTargetPerDay = value;
    notifyListeners();
  }

  set percent(int value) {
    _percent = value;
    notifyListeners();
  }

  // Lấy danh sách meals từ API
  Future<void> fetchMeals(String date) async {
    try {
      final meals = await _mealService.getAllMeals(date);
      _meals = meals;

      // Tính toán lượng calo
      caloriesTargetPerDay = _meals.fold<double>(
        0,
        (sum, meal) => sum + (meal.food.calories ?? 0.0),
      );
      // Tính toán lượng calo đã tiêu thụ
      caloriesConsumedPerDay = _meals.fold<double>(
        0,
        (sum, meal) => meal.status ? sum + (meal.food.calories ?? 0.0) : sum,
      );

      // Tính phần trăm hoàn thành meals
      final completedMeals = _meals.where((meal) => meal.status).length;
      percent = _meals.isNotEmpty
          ? ((completedMeals / _meals.length) * 100).toInt()
          : 0;
      notifyListeners();
    } catch (e) {
      print('Failed to fetch meals: $e');
    }
  }

  // Cập nhật trạng thái meal
  Future<void> updateMealStatus(int id, bool status) async {
    try {
      caloriesConsumedPerDay = _meals.fold<double>(
        0,
            (sum, meal) => meal.status ? sum + (meal.food.calories ?? 0.0) : sum,
      );
      final completedMeals = _meals.where((meal) => meal.status).length;
      percent = _meals.isNotEmpty
          ? ((completedMeals / _meals.length) * 100).toInt()
          : 0;

      final updatedMeal = await _mealService.updateMealStatus(id, status);

      final index = _meals.indexWhere((meal) => meal.id == id);
      if (index != -1) {
        _meals[index] = updatedMeal;
      }

      // Cập nhật lại calories và percent


      notifyListeners();
    } catch (e) {
      print('Failed to update meal status: $e');
    }
  }
}
