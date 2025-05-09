class Food {
  int id;
  String name;
  String? description;
  String? imageUrl;
  double? calories;
  double? protein;
  double? carbs;
  double? fat;
  String? createdAt;
  String? updatedAt;

  Food({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.createdAt,
    this.updatedAt,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fat,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}