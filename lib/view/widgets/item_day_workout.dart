import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/day_workout.dart';

class ItemDayWorkout extends StatelessWidget {
  DayWorkout dayWorkout = DayWorkout();

  ItemDayWorkout({super.key, required this.dayWorkout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: Color(0xFFCACACA),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayWorkout.day.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dayWorkout.month,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
