class Exercise {
  final int id;
  final String name ;
  String? description;
  final String imageUrl;
  final String videoUrl;
  final int reps;
  final int sets;
  final int durationMinutes;
  final double calories;
  String? updatedAt;
  String? createdAt;


  Exercise({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.reps,
    required this.sets,
    required this.durationMinutes,
    required this.calories,
    this.updatedAt,
    this.createdAt,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      reps: json['reps'],
      sets: json['sets'],
      durationMinutes: json['durationMinutes'],
      calories: json['calories'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'reps': reps,
      'sets': sets,
      'durationMinutes': durationMinutes,
      'calories': calories,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }
}