import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/day_workout.dart';
import 'package:rev_me_app/core/models/workout.dart';
import 'package:rev_me_app/view/widgets/item_day_workout.dart';
import 'package:rev_me_app/view/widgets/item_workout.dart';

class WorkoutSreen extends StatefulWidget {
  const WorkoutSreen({super.key});

  @override
  State<WorkoutSreen> createState() => _WorkoutSreenState();
}

class _WorkoutSreenState extends State<WorkoutSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Workout',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                ImageIcon(
                  const AssetImage('assets/ic_verify.png'),
                  color: Colors.black,
                  size: 30,
                ),
                const SizedBox(width: 4),
                ImageIcon(
                  const AssetImage('assets/ic_notification.png'),
                  color: Colors.black,
                  size: 30,
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                DayWorkout dayWorkout = DayWorkout(id: 1, day: index + 1, month: "Feb");
                return ItemDayWorkout(dayWorkout: dayWorkout);
              },
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE9E9E9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'All Workouts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 8, // Specify the number of items
                        itemBuilder: (context, index) {
                          Workout workout = Workout(
                            id: index,
                            name: 'Workout $index',
                            image: 'https://hdfitness.vn/wp-content/uploads/2022/03/A-252-min-1024x683.jpg',
                            quantity: '25 total',
                            set: '30x peps Each',
                          );
                          return ItemWorkout(workout: workout);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
