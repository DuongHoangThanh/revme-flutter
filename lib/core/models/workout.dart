import 'package:rev_me_app/core/models/plan.dart';

import 'exercise.dart';

class Workout {
  int id;
  String? note;
  bool status;
  Exercise exercise;
  Plan plan;
  String? createdAt;
  String? updatedAt;

  Workout({
    required this.id,
     this.note,
    required this.status,
    required this.exercise,
    required this.plan,
    this.createdAt,
    this.updatedAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      note: json['note'],
      status: json['status'],
      exercise: Exercise.fromJson(json['exercise']),
      plan: Plan.fromJson(json['plan']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'status': status,
      'exercise': exercise.toJson(),
      'plan': plan.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
  void updateStatus(bool newStatus) {
    status = newStatus;
  }
}
