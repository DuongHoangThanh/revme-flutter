import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/day_workout.dart';
import 'package:rev_me_app/themes/colors.dart';

class ItemDayWorkout extends StatefulWidget {
  final DayWorkout dayWorkout;

  ItemDayWorkout({super.key, required this.dayWorkout});

  @override
  _ItemDayWorkoutState createState() => _ItemDayWorkoutState();
}

class _ItemDayWorkoutState extends State<ItemDayWorkout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.dayWorkout.isCompleted = !widget.dayWorkout.isCompleted;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: 40,
          decoration: BoxDecoration(
            color: widget.dayWorkout.isCompleted
                ? AppColors.mainColor
                : Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.dayWorkout.day.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.dayWorkout.isCompleted ? Colors.white : Colors.black,
                ),
              ),
              Text(
                widget.dayWorkout.month,
                style: TextStyle(
                  fontSize: 12,
                  color: widget.dayWorkout.isCompleted ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}