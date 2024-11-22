import 'goal.dart';

class Plan {
  final int id;
  final String nameDay;
  final String specificDate;
  final String description;
  final int totalWorkoutsTarget;
  final int totalMealsTarget;
  final double caloriesBurnedPerDay;
  final double caloriesIntakePerDay;
  final double waterIntakeTarget;
  String? createdAt;
  String? updatedAt;
  Goal? goal;

  Plan({
    required this.id,
    required this.nameDay,
    required this.specificDate,
    required this.description,
    required this.totalWorkoutsTarget,
    required this.totalMealsTarget,
    required this.caloriesBurnedPerDay,
    required this.caloriesIntakePerDay,
    required this.waterIntakeTarget,
    this.createdAt,
    this.updatedAt,
    this.goal,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      nameDay: json['nameDay'],
      specificDate: json['specificDate'],
      description: json['description'],
      totalWorkoutsTarget: json['totalWorkoutsTarget'],
      totalMealsTarget: json['totalMealsTarget'],
      caloriesBurnedPerDay: json['caloriesBurnedPerDay'],
      caloriesIntakePerDay: json['caloriesIntakePerDay'],
      waterIntakeTarget: json['waterIntakeTarget'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      goal: json['goal'] != null ? Goal.fromJson(json['goal']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameDay': nameDay,
      'specificDate': specificDate,
      'description': description,
      'totalWorkoutsTarget': totalWorkoutsTarget,
      'totalMealsTarget': totalMealsTarget,
      'caloriesBurnedPerDay': caloriesBurnedPerDay,
      'caloriesIntakePerDay': caloriesIntakePerDay,
      'waterIntakeTarget': waterIntakeTarget,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'goal': goal?.toJson(),
    };
  }
}
