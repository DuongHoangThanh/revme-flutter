import 'package:flutter/material.dart';

import '../core/models/workout.dart';
import '../core/services/workout_service.dart';

class WorkoutViewModel extends ChangeNotifier {
  final WorkoutService _workoutService = WorkoutService();
  List<Workout> _workouts = [];
  double? _caloriesBurnedPerDay;
  double? _caloriesIntakePerDay;
  int? _percent;
  bool _isChooseWorkout = false;


  List<Workout> get workouts => _workouts;

  double get caloriesBurnedPerDay => _caloriesBurnedPerDay ?? 0.0;

  double get caloriesIntakePerDay => _caloriesIntakePerDay ?? 0.0;

  int get percent => _percent ?? 0;

  bool get isChooseWorkout => _isChooseWorkout;

  set caloriesIntakePerDay(double value) {
    _caloriesIntakePerDay = value;
    notifyListeners();
  }

  set caloriesBurnedPerDay(double value) {
    _caloriesBurnedPerDay = value;
    notifyListeners();
  }

  set percent(int value) {
    _percent = value;
    notifyListeners();
  }

  set isChooseWorkout(bool value) {
    _isChooseWorkout = value;
    notifyListeners();
  }

  Future<void> fetchWorkouts(String date) async {
    try {
      final workouts = await _workoutService.getAllWorkouts(date);
      _workouts = workouts;

      caloriesBurnedPerDay = _workouts.fold<double>(
        0,
        (sum, workout) =>
            workout.status ? sum + workout.exercise.calories : sum,
      );
      caloriesIntakePerDay = _workouts.fold<double>(
        0,
        (sum, workout) => sum + workout.exercise.calories,
      );

      // Tính phần trăm hoàn thành các bài tập
      final completedWorkouts =
          _workouts.where((workout) => workout.status).length;
      percent = _workouts.isNotEmpty
          ? ((completedWorkouts / _workouts.length) * 100).toInt()
          : 0;

      print('Completion percentage: $percent%');

      // Thông báo cho các listeners
      notifyListeners();
    } catch (e) {
      // Xử lý lỗi
      print('Failed to fetch workouts: $e');
    }
  }

  // update workout status
  Future<void> updateWorkoutStatus(int id, bool status) async {
    try {
      final message = await _workoutService.updateWorkoutStatus(id, status);
      print(message);

      // Thông báo cho các listeners
      notifyListeners();
    } catch (e) {
      // Xử lý lỗi
      print('Failed to update workout status: $e');
    }
  }
}
