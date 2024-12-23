import 'package:flutter/material.dart';
import '../core/models/meal.dart';
import '../core/services/meal_service.dart';
import 'package:intl/intl.dart';

class MealViewModel extends ChangeNotifier {
  final MealService _mealService = MealService();
  List<Meal> _meals = [];
  double? _caloriesConsumedPerDay;
  double? _caloriesTargetPerDay;
  int? _percent;
  bool? _isToday;

  List<Meal> get meals => _meals;

  double get caloriesConsumedPerDay => _caloriesConsumedPerDay ?? 0.0;

  double get caloriesTargetPerDay => _caloriesTargetPerDay ?? 0.0;

  int get percent => _percent ?? 0;

  bool get isToday => _isToday ?? true;

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

  set isToday(bool value) {
    _isToday = value;
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

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (date == today) {
        _isToday = true;
      } else {
        _isToday = false;
      }

      notifyListeners();
    } catch (e) {
      print('Failed to fetch meals: $e');
    }
  }

  // Cập nhật trạng thái meal
  Future<void> updateMealStatus(int id, bool status, String date) async {
    _isToday = false;
    try {
      final index = _meals.indexWhere((meal) => meal.id == id);

      // Lấy ngày hiện tại
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      // Lấy ngày của meal
      if (date == today) {
        _isToday = true;

        _meals[index].status = status;
        final statusMeal = await _mealService.updateMealStatus(id, status);
        // print(statusMeal);

        caloriesConsumedPerDay = _meals.fold<double>(
          0,
          (sum, meal) => meal.status ? sum + (meal.food.calories ?? 0.0) : sum,
        );
        final completedMeals = _meals.where((meal) => meal.status).length;
        percent = _meals.isNotEmpty
            ? ((completedMeals / _meals.length) * 100).toInt()
            : 0;
      } else {
        _isToday = false;
      }
      notifyListeners();
    } catch (e) {
      print('Failed to update meal status: $e');
    }
  }
}
