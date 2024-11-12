class Workout {
  int id;
  String name;
  String image;
  String quantity;
  String set;
  String description = '';

  Workout({
    this.id = 0,
    this.name = '',
    this.image = '',
    this.quantity = '',
    this.set = '',
    this.description = '',
  });

  Workout.requiredFields({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.set,
    required this.description,
  });

}
