import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:rev_me_app/core/models/workout.dart';

import 'package:rev_me_app/view/widgets/item_workout.dart';

import '../../../themes/colors.dart';
import '../../../viewmodels/workout_viewmodel.dart';

class WorkoutSreen extends StatefulWidget {
  static const String id = 'workout_screen';

  WorkoutSreen({
    super.key,
  });

  @override
  State<WorkoutSreen> createState() => _WorkoutSreenState();
}

class _WorkoutSreenState extends State<WorkoutSreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkoutViewModel()
          ..fetchWorkouts(DateTime.now().toIso8601String().split('T').first),
        child: Consumer<WorkoutViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
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
                              AssetImage('assets/ic_verify.png'),
                              color: Colors.black,
                              size: 30,
                            ),
                            SizedBox(width: 4),
                            ImageIcon(
                              AssetImage('assets/ic_notification.png'),
                              color: Colors.black,
                              size: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  DatePicker(
                    DateTime.now().subtract(Duration(days: 2)),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.mainColor,
                    selectedTextColor: Colors.white,
                    daysCount: 10,
                    height: 88,
                    onDateChange: (date) {
                      setState(() {
                        var _selectedValue =
                            date.toIso8601String().split('T').first;
                        print(_selectedValue);
                        viewModel.fetchWorkouts(_selectedValue);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                              Text(
                                viewModel.caloriesBurnedPerDay
                                        .toInt()
                                        .toString() +
                                    ' kcal',
                                style: const TextStyle(
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
                                center: Text(
                                  viewModel.percent.toString() + '%',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                percent: viewModel.percent / 100,
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
                              Text(
                                viewModel.caloriesIntakePerDay
                                        .toInt()
                                        .toString() +
                                    ' kcal',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Total',
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'All Workouts',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.workouts.length,
                            itemBuilder: (context, index) {
                              Workout workout = viewModel.workouts[index];

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
        }));
  }
}
