import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rev_me_app/core/models/day_workout.dart';
import 'package:rev_me_app/core/models/workout.dart';
import 'package:rev_me_app/view/widgets/item_day_workout.dart';
import 'package:rev_me_app/view/widgets/item_workout.dart';

import '../../../themes/colors.dart';

class WorkoutSreen extends StatefulWidget {
  static const String id = 'workout_screen';
  static double? percent=0;
   WorkoutSreen({super.key,} );

  @override
  State<WorkoutSreen> createState() => _WorkoutSreenState();
}

class _WorkoutSreenState extends State<WorkoutSreen> {

  List<DayWorkout> dayWorkouts = List.generate(10, (index) {
    var day = DateTime.now().day - 3;
    return DayWorkout(id: 1, day: day + index, month: "Nov");
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculatePercent();
  }

  void calculatePercent(){
    int total=0;
    int completed=0;
    for(int i=0;i<dayWorkouts.length;i++){
      if(dayWorkouts[i].isCompleted){
        completed++;
      }
      total++;
    }
    WorkoutSreen.percent=completed/total;
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  DayWorkout dayWorkout = dayWorkouts[index];
                  if (dayWorkout.day == DateTime.now().day) {
                    dayWorkout.isCompleted = true;
                  } else {
                    dayWorkout.isCompleted = false;
                  }
                  return ItemDayWorkout(
                    dayWorkout: dayWorkout,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          '2875 kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Consumed',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Complete',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          width: 110,
                          height: 15,
                          child: SliderTheme(
                            data: const SliderThemeData(
                                thumbColor: Colors.transparent,
                                overlayColor: Colors.transparent,
                                activeTrackColor: AppColors.mainColor,
                                inactiveTrackColor: Colors.black,
                                trackHeight: 4,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 1)),
                            child: Slider(
                              min: 0,
                              max: 20,
                              value: 12,
                              onChanged: (value) async {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        new CircularPercentIndicator(
                          radius: 30,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 7.0,
                          backgroundColor: Colors.black,
                          center: const Text(
                            "50%",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          percent: 0.5,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: AppColors.mainColor,
                        ),
                        const SizedBox(height: 12),

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          '1900 kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Remaining',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Complete',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          width: 110,
                          height: 15,
                          child: SliderTheme(
                            data: const SliderThemeData(
                                thumbColor: Colors.transparent,
                                overlayColor: Colors.transparent,
                                activeTrackColor: AppColors.mainColor,
                                inactiveTrackColor: Colors.black,
                                trackHeight: 4,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 1)),
                            child: Slider(
                              min: 0,
                              max: 20,
                              value: 12,
                              onChanged: (value) async {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text(
                        'All Workouts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: getWorkout().length,
                      itemBuilder: (context, index) {
                        Workout workout = getWorkout()[index];
                        return ItemWorkout(workout: workout);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Workout> getWorkout() {
    List<Workout> workouts = [];
    workouts.add(Workout(
      id: 1,
      name: 'Black Workout',
      image:
          'https://media4.giphy.com/media/M5kXUwhern0mQ/giphy.gif?cid=6c09b952ernmsoix5ipqli2mjoii2okbojbu2wpdm9nrw2t0&ep=v1_gifs_search&rid=giphy.gif&ct=g',
      quantity: '25 total',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: true,
    ));
    workouts.add(Workout(
      id: 1,
      name: 'Maximum Pull Up',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHqzbtJZz34f_Yyy-rq-PcjZEJz7tQPvdKMVd2CfRDqYC_KT_gKzB2ETIGYHQDrJJiAJ0&usqp=CAU',
      quantity: '25 total',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: true,
    ));
    workouts.add(Workout(
      id: 1,
      name: 'Intense Core Abs',
      image:
          'https://images.squarespace-cdn.com/content/v1/5d02eef8911a8d0001896ff8/1620146026554-ICIM1G14V2BEWQG1RGHS/31kz2m.gif',
      quantity: '25 total',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: false,
    ));
    workouts.add(Workout(
      id: 1,
      name: 'Back Warm Up',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYsp92icziCUAUuPO3mFjA2BwfKE7EuktXbdTcdKVbQm8Ux0Es9ts6RruuXelPeTHuTY4&usqp=CAU',
      quantity: '25 total',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      set: '30x peps Each',
      isCompleted: false,
    ));
    return workouts;
  }
}
