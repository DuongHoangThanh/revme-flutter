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
              itemCount: 30,
              itemBuilder: (context, index) {
                DayWorkout dayWorkout = DayWorkout(id: 1, day: index + 1, month: "Nov");
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
                        itemCount: getWorkout().length,
                        itemBuilder: (context, index) {
                          Workout workout = getWorkout()[index];
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

  List<Workout> getWorkout(){
    List<Workout> workouts = [];
    workouts.add(Workout(
      id: 1,
      name: 'Black Workout',
      image: 'https://media4.giphy.com/media/M5kXUwhern0mQ/giphy.gif?cid=6c09b952ernmsoix5ipqli2mjoii2okbojbu2wpdm9nrw2t0&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      quantity: '25 total',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: true,

    )); workouts.add(Workout(
      id: 1,
      name: 'Maximum Pull Up',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHqzbtJZz34f_Yyy-rq-PcjZEJz7tQPvdKMVd2CfRDqYC_KT_gKzB2ETIGYHQDrJJiAJ0&usqp=CAU',
      quantity: '25 total',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: true,
    )); workouts.add(Workout(
      id: 1,
      name: 'Intense Core Abs',
      image: 'https://images.squarespace-cdn.com/content/v1/5d02eef8911a8d0001896ff8/1620146026554-ICIM1G14V2BEWQG1RGHS/31kz2m.gif',
      quantity: '25 total',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: false,
    )); workouts.add(Workout(
      id: 1,
      name: 'Back Warm Up',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYsp92icziCUAUuPO3mFjA2BwfKE7EuktXbdTcdKVbQm8Ux0Es9ts6RruuXelPeTHuTY4&usqp=CAU',
      quantity: '25 total',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: false,
    ));
    return workouts;
  }
}
