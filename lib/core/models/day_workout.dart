class DayWorkout {
  final int id;
  final int day;
  final String month;
  bool isCompleted = false;

  DayWorkout({
    this.id = 0,
    this.day = 0,
    this.month = '',
    this.isCompleted = false,
  });

  DayWorkout.requiredFields({
    required this.id,
    required this.day,
    required this.month,
    required this.isCompleted,
  });
}
