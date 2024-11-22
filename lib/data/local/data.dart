import 'package:rev_me_app/core/models/exercise.dart';
import 'package:rev_me_app/core/models/workout.dart';

import '../../core/models/plan.dart';

class Data {
  List<Exercise> getExercises() {
    var exercises = <Exercise>[];
    exercises.add(Exercise(
      id: 1,
      name: 'Push-ups',
      imageUrl:
          'https://cdn.centr.com/content/31000/30074/images/landscapedesktop2x-unleashed-lz-aj-dc-tricep-push-up.jpg',
      description:
          'Upper body workout that targets chest and arms. It is a great exercise to build strength and endurance.',
      videoUrl: 'https://www.youtube.com/watch?v=b5e8QwnKAP0',
      calories: 100,
      durationMinutes: 10,
      reps: 10,
      sets: 3,
    ));
    exercises.add(Exercise(
      id: 2,
      name:
          'Plank',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSry2BfvkC1yalItPT88ZTHq4mu1SxEaHqwPA&s',
      description:
          'Core strengthening exercise. It is a great exercise to build strength and endurance.',
      videoUrl: 'https://www.youtube.com/watch?v=5Il95mQ30Ro',
      calories: 100,
      durationMinutes: 10,
      reps: 10,
      sets: 3,
    ));
    exercises.add(Exercise(
      id: 3,
      name: 'Lunges',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnuuHIOod2v0oYWqo2CczjvHE2dImPusHM7w&s',
      description:
          'Upper body workout that targets chest and arms. It is a great exercise to build strength and endurance.',
      videoUrl: 'https://www.youtube.com/watch?v=b5e8QwnKAP0',
      calories: 100,
      durationMinutes: 10,
      reps: 10,
      sets: 3,
    ));
    exercises.add(Exercise(
      id: 4,
      name:
          'Burpees',
      imageUrl: 'https://images.healthshots.com/healthshots/en/uploads/2020/12/07104712/burpees.jpg',
      description:
          'Core strengthening exercise. It is a great exercise to build strength and endurance.',
      videoUrl: 'https://www.youtube.com/watch?v=5Il95mQ30Ro',
      calories: 100,
      durationMinutes: 10,
      reps: 10,
      sets: 3,
    ));

    exercises.add(Exercise(
      id: 5,
      name: 'Jump Rope',
      imageUrl:
          'https://www.crossrope.com/cdn/shop/articles/HowToJumpRope_HeaderDave_1919x.jpg?v=1723479824',
      description:
          'Upper body workout that targets chest and arms. It is a great exercise to build strength and endurance.',
      videoUrl: 'https://www.youtube.com/watch?v=b5e8QwnKAP0',
      calories: 100,
      durationMinutes: 10,
      reps: 10,
      sets: 3,
    ));
    return exercises;
  }

  List<Plan> getPlan() {
    var plans = <Plan>[];
    plans.add(Plan(
      id: 1,
      nameDay: 'Day 1',
      caloriesBurnedPerDay: 1000,
      caloriesIntakePerDay: 2000,
      description: 'Running and increase stamina',
      specificDate: '2024-17-11',
      totalMealsTarget: 3,
      totalWorkoutsTarget: 3,
      waterIntakeTarget: 2.5,
    ));
    plans.add(Plan(
      id: 2,
      nameDay: 'Day 2',
      caloriesBurnedPerDay: 1000,
      caloriesIntakePerDay: 2000,
      description: 'Running and increase stamina',
      specificDate: '2024-18-10',
      totalMealsTarget: 3,
      totalWorkoutsTarget: 3,
      waterIntakeTarget: 2.5,
    ));

    plans.add(Plan(
      id: 3,
      nameDay: 'Day 3',
      caloriesBurnedPerDay: 1000,
      caloriesIntakePerDay: 2000,
      description: 'Running and increase stamina',
      specificDate: '2024-19-10',
      totalMealsTarget: 3,
      totalWorkoutsTarget: 3,
      waterIntakeTarget: 2.5,
    ));

    plans.add(Plan(
      id: 4,
      nameDay: 'Day 4',
      caloriesBurnedPerDay: 1000,
      caloriesIntakePerDay: 2000,
      description: 'Running and increase stamina',
      specificDate: '2024-20-10',
      totalMealsTarget: 3,
      totalWorkoutsTarget: 3,
      waterIntakeTarget: 2.5,
    ));
    return plans;
  }


  List<Workout> getWorkout() {
    var workouts = <Workout>[];
    workouts.add(Workout(
      id: 1,
      note: 'Running and increase stamina',
      status: true,
      plan: getPlan()[1],
      createdAt: '2024-17-11',
      exercise: getExercises()[1],
    ));
    workouts.add(Workout(
      id: 2,
      note: 'Body weight workout',
      status: true,
      plan: getPlan()[1],
      createdAt: '2024-18-11',
      exercise: getExercises()[2],
    ));

    workouts.add(Workout(
      id: 3,
      note: 'Cardio workout',
      status: false,
      plan: getPlan()[1],
      createdAt: '2024-17-11',
      exercise: getExercises()[3],
    ));

    workouts.add(Workout(
      id: 4,
      note: 'Running and increase stamina',
      status: true,
      plan: getPlan()[1],
      createdAt: '2024-17-11',
      exercise: getExercises()[4],
    ));

    workouts.add(Workout(
      id: 5,
      note: 'Running and increase stamina',
      status: true,
      plan: getPlan()[1],
      createdAt: '2024-17-11',
      exercise: getExercises()[0],
    ));

    return workouts;
  }
}
class WorkoutData {
  static final WorkoutData _instance = WorkoutData._internal();

  factory WorkoutData() => _instance;

  WorkoutData._internal();

  final List<Workout> workouts = [];

  void initializeWorkouts() {
    workouts.clear();
    workouts.add(Workout(
      id: 1,
      note: 'Running and increase stamina',
      status: true,
      plan: Data().getPlan()[1],
      createdAt: '2024-17-11',
      exercise: Data().getExercises()[1],
    ));
    workouts.add(Workout(
      id: 2,
      note: 'Body weight workout',
      status: true,
      plan: Data(). getPlan()[1],
      createdAt: '2024-18-11',
      exercise: Data().getExercises()[2],
    ));

    workouts.add(Workout(
      id: 3,
      note: 'Cardio workout',
      status: false,
      plan: Data().getPlan()[1],
      createdAt: '2024-17-11',
      exercise: Data().getExercises()[3],
    ));

    workouts.add(Workout(
      id: 4,
      note: 'Running and increase stamina',
      status: true,
      plan: Data().getPlan()[1],
      createdAt: '2024-17-11',
      exercise: Data().getExercises()[4],
    ));

    workouts.add(Workout(
      id: 5,
      note: 'Running and increase stamina',
      status: true,
      plan: Data().getPlan()[1],
      createdAt: '2024-17-11',
      exercise: Data().getExercises()[0],
    ));
    // Add other workouts here
  }
}
