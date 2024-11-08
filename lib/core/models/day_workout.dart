class DayWorkout {
  final int id;
  final int day;
  final String month;
  // final List<Exercise> exercises;
  DayWorkout({
    this.id = 0,
    this.day = 0,
    this.month = '',
    // this.exercises = const [],
  });


  DayWorkout.requiredFields({
    required this.id,
    required this.day,
    required this.month,
    // required this.exercises,
  });


}