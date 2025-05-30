import 'package:flutter/cupertino.dart';

import '../core/models/banner.dart';
import '../core/services/workout_service.dart';
import '../data/local/UserPreferences.dart';

class HomeViewModel extends ChangeNotifier {

  final WorkoutService _workoutService = WorkoutService();
  List<Banners> _banners = [];
  double? _caloriesBurnedPerDay;
  double? _caloriesIntakePerDay;
  double? _percent;
  bool? _isCreatedAssessment;
  bool? _hasCheckedInToday;
  int? _attendanceStreak;

  double get percent => _percent ?? 0.0;
  double get caloriesBurnedPerDay => _caloriesBurnedPerDay ?? 0.0;
  double get caloriesIntakePerDay => _caloriesIntakePerDay ?? 0.0;
  bool get isCreatedAssessment => _isCreatedAssessment ?? true;
  List<Banners> get banners => _banners;
  bool? get hasCheckedInToday => _hasCheckedInToday;
  int? get attendanceStreak => _attendanceStreak;

  set caloriesIntakePerDay(double value) {
    _caloriesIntakePerDay = value;
    notifyListeners();
  }

  set caloriesBurnedPerDay(double value) {
    _caloriesBurnedPerDay = value;
    notifyListeners();
  }

  set percent(double value) {
    _percent = value;
    notifyListeners();
  }

  set isCreatedAssessment(bool value) {
    _isCreatedAssessment = value;
    notifyListeners();
  }

  Future<void> fetchWorkouts() async {
    fetchBanner();
    try {
      final date = DateTime.now().toIso8601String().split('T').first;
      final workouts = await _workoutService.getAllWorkouts(date);

      final completedWorkouts = workouts.where((workout) => workout.status).length;
      if(workouts.length==0){
        isCreatedAssessment = false;
      }
      percent = workouts.isNotEmpty ? ((completedWorkouts / workouts.length) * 100) : 0;

      caloriesBurnedPerDay = workouts.fold<double>(
        0,
        (sum, workout) => workout.status ? sum + workout.exercise.calories : sum,
      );

      caloriesIntakePerDay = workouts.fold<double>(
        0,
        (sum, workout) => sum + workout.exercise.calories,
      );




    } catch (e) {

      print('Error: $e');
    }
  }
  void fetchBanner(){
    _banners.add( Banners(
      title: 'Upper Strength 2',
      subtitle: "Feel the burn",
      imageUrl: 'https://thegioidotap.vn/wp-content/uploads/2020/12/195.jpg',
      number1: 25,
      unit1: 'min',
      icon1: 'https://img.icons8.com/ios/452/fire-element.png',
      number2: 412,
      unit2: 'kcal',
      icon2: 'https://img.icons8.com/ios/452/fire-element.png',
      actionText: 'Start Workout',
    ));

    _banners.add(Banners(
      title: 'Fresh Vegetables',
      subtitle: 'Additional nutrition',
      imageUrl: 'https://img2.exportersindia.com/product_images/bc-full/dir_59/1744394/fresh-vegetable-1485323630-1366194.jpeg',
      number1: 0,
      unit1: '',
      icon1: 'https://img.icons8.com/ios/452/fire-element.png',
      number2: 0,
      unit2: '',
      icon2: 'https://img.icons8.com/ios/452/fire-element.png',
      actionText: 'Start Workout',
    ));

    _banners.add( Banners(
      title: 'Running',
      subtitle: "Let's run together",
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeV7tN3YD1wXnqCb-VEStkzm1FdSDYgaREXWvVWKIlGyK-uEYWwELNDx-gbQPuKoEQ5r4&usqp=CAU',
      number1: 25,
      unit1: 'min',
      icon1: 'https://img.icons8.com/ios/452/fire-element.png',
      number2: 412,
      unit2: 'kcal',
      icon2: 'https://img.icons8.com/ios/452/fire-element.png',
      actionText: 'Start Workout',
    ));

    _banners.add(Banners(
      title: 'Fresh Salad',
      subtitle: 'Best for health',
      imageUrl: 'https://i-giadinh.vnecdn.net/2021/10/26/saladrauqua-1635240739-5476-1635240778.jpg',
      number1: 25,
      unit1: 'kcal',
      icon1: 'https://img.icons8.com/ios/452/fire-element.png',
      number2: 50,
      unit2: 'fat',
      icon2: 'https://img.icons8.com/ios/452/fire-element.png',
      actionText: 'Start Workout',
    ));

 _banners.add(Banners(
      title: 'Care with Health',
      subtitle: 'The importance of Health',
      imageUrl: 'https://media.licdn.com/dms/image/D5612AQGAeyIqwMDaog/article-cover_image-shrink_720_1280/0/1697722888828?e=2147483647&v=beta&t=F1nNmateGAzUazLNXX_1rZQNqQcDfSKKJUHf6uKdOB8',
      number1: 0,
      unit1: '',
      icon1: 'https://img.icons8.com/ios/452/fire-element.png',
      number2: 0,
      unit2: '',
      icon2: 'https://img.icons8.com/ios/452/fire-element.png',
      actionText: 'Start Workout',
    ));


  }
  void initCheckInStatus() {
    _hasCheckedInToday = false; // Default value
    _attendanceStreak = 0;      // Default value

    // You would fetch the actual values from storage or blockchain
    // For example:
    UserPreferences().getLastCheckInDate().then((lastDate) {
      if (lastDate != null) {
        final today = DateTime.now();
        final lastCheckIn = DateTime.parse(lastDate);

        // Check if the last check-in was today
        _hasCheckedInToday = lastCheckIn.year == today.year &&
            lastCheckIn.month == today.month &&
            lastCheckIn.day == today.day;

        notifyListeners();
      }
    });

    UserPreferences().getAttendanceStreak().then((streak) {
      _attendanceStreak = streak ?? 0;
      notifyListeners();
    });
  }
  Future<bool> checkInToEarnFIT() async {
    try {
      // 1. First, check if user already checked in today
      if (_hasCheckedInToday ?? false) {
        return false;
      }

      // 2. Set the check-in flag
      _hasCheckedInToday = true;

      // 3. Update the streak
      _attendanceStreak = (_attendanceStreak ?? 0) + 1;

      // 4. Save the check-in date and streak
      final today = DateTime.now().toIso8601String();
      await UserPreferences().setLastCheckInDate(today);
      await UserPreferences().setAttendanceStreak(_attendanceStreak ?? 0);

      // 5. Award FIT points to the user (using local storage instead of blockchain)
      // Base reward is 5 FIT points per check-in
      int rewardPoints = 5;
      
      // Bonus for streaks (1 extra point for each 5 days of streak)
      int streakBonus = (_attendanceStreak ?? 0) ~/ 5;
      int totalReward = rewardPoints + streakBonus;
      
      // Add FIT points to user's balance
      await UserPreferences().addFitPoints(totalReward);

      notifyListeners();
      return true;
    } catch (e) {
      print('Failed to check in: $e');
      return false;
    }
  }
}