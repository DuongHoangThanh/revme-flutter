import 'package:rev_me_app/core/models/plan.dart';

import 'food.dart';

class Meal {
  int id;
  bool status;
  String note;
  Food food;
  Plan plan;
  String? createdAt;
  String? updatedAt;

  Meal({
    required this.id,
    required this.status,
    required this.note,
    required this.food,
    required this.plan,
    this.createdAt,
    this.updatedAt,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      status: json['status'],
      note: json['note'],
      food: Food.fromJson(json['food']),
      plan: Plan.fromJson(json['plan']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'note': note,
      'food': food.toJson(),
      'plan': plan.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}