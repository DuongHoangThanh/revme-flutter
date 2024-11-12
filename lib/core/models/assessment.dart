class Assessment {
  static final Assessment _instance = Assessment._internal();

  factory Assessment() => _instance;

  Assessment._internal();

  String? gender;
  int? age;
  double? height;
  double? weight;
  String? activity_level;
  String? health_conditions;
  String? current_diet;
  String? dietary_preferences;
  String? favorite_foods;
  String? workout_experience;
  String? preferred_exercise;
  int? daily_workout_time;
  String? sleep_quality;
  String? stress_level;
  // created_at
  DateTime? created_at;
  // updated_at
  DateTime? updated_at;

  @override
  String toString() {
    return 'Assessment{gender: $gender, age: $age, height: $height, weight: $weight, activity_level: $activity_level, health_conditions: $health_conditions, current_diet: $current_diet, dietary_preferences: $dietary_preferences, favorite_foods: $favorite_foods, workout_experience: $workout_experience, preferred_exercise: $preferred_exercise, daily_workout_time: $daily_workout_time, sleep_quality: $sleep_quality, stress_level: $stress_level, created_at: $created_at, updated_at: $updated_at}';
  }

// Map<String, dynamic> toJson() {
//   return {
//     'gender': gender,
//     'age': age,
//     'height': height,
//     'weight': weight,
//     // Add more fields
//   };
// }


}
