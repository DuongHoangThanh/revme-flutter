import 'package:rev_me_app/core/models/user.dart';

class Goal {
  int id;
  String? goalName;
  String? description;
  String? estimatedDuration;
  String? createdAt;
  String? updatedAt;
  User? user;

  Goal({
    required this.id,
    this.goalName,
    this.description,
    this.estimatedDuration,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      goalName: json['goalName'],
      description: json['description'],
      estimatedDuration: json['estimatedDuration'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      // user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'goalName': goalName,
      'description': description,
      'estimatedDuration': estimatedDuration,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'user': user?.toJson(),
    };
  }
}
