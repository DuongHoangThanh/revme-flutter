class Assessment {
  static final Assessment _instance = Assessment._internal();

  factory Assessment() => _instance;

  Assessment._internal();

  int? id;
  String? gender;
  int? age;
  double? height;
  double? weight;
  String? activityLevel;
  String? healthConditions;
  String? currentDiet;
  String? dietaryPreferences;
  String? favoriteFoods;
  String? workoutExperience;
  String? preferredExercise;
  int? dailyWorkoutTime;
  String? sleepQuality;
  String? stressLevel;

  // created_at
  DateTime? created_at;

  // updated_at
  DateTime? updated_at;

  @override
  String toString() {
    return 'Assessment{id: $id,gender: $gender, age: $age, height: $height, weight: $weight, activity_level: $activityLevel, health_conditions: $healthConditions, current_diet: $currentDiet, dietary_preferences: $dietaryPreferences, favorite_foods: $favoriteFoods, workout_experience: $workoutExperience, preferred_exercise: $preferredExercise, daily_workout_time: $dailyWorkoutTime, sleep_quality: $sleepQuality, stress_level: $stressLevel, created_at: $created_at, updated_at: $updated_at}';
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'activityLevel': activityLevel,
      'healthConditions': healthConditions,
      'currentDiet': currentDiet,
      'dietaryPreferences': dietaryPreferences,
      'favoriteFoods': favoriteFoods,
      'workoutExperience': workoutExperience,
      'preferredExercise': preferredExercise,
      'dailyWorkoutTime': dailyWorkoutTime,
      'sleepQuality': sleepQuality,
      'stressLevel': stressLevel,
    };
  }

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment._internal()
      ..id = json['id']
      ..gender = json['gender']
      ..age = json['age']
      ..height = json['height']
      ..weight = json['weight']
      ..activityLevel = json['activityLevel']
      ..healthConditions = json['healthConditions']
      ..currentDiet = json['currentDiet']
      ..dietaryPreferences = json['dietaryPreferences']
      ..favoriteFoods = json['favoriteFoods']
      ..workoutExperience = json['workoutExperience']
      ..preferredExercise = json['preferredExercise']
      ..dailyWorkoutTime = json['dailyWorkoutTime']
      ..sleepQuality = json['sleepQuality']
      ..stressLevel = json['stressLevel']
      ..created_at = DateTime.parse(json['created_at'])
      ..updated_at = DateTime.parse(json['updated_at']);
  }
}
