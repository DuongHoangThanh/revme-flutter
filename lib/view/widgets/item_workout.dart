import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:rev_me_app/core/models/workout.dart';
import 'package:rev_me_app/themes/colors.dart';

import '../screens/workout/workout_detail_sreen.dart';

class ItemWorkout extends StatelessWidget {
  final Workout workout;
  ItemWorkout({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, WorkoutDetailScreen.id);
        // send workout to WorkoutDetailScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutDetailSreen(workout: workout),
          ),
        );


      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(

              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    workout.image,
                    height: 100,
                    width:112 ,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workout.name,
                          style:  TextStyle(
                            color: workout.isCompleted ? AppColors.mainColor : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          workout.isCompleted ? Icons.check_circle : Icons.circle,
                          color: workout.isCompleted ? AppColors.mainColor : Colors.white,
                          size: 24,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.grey,
                          size: 24,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${workout.quantity}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          IconlyBold.discovery,
                          color: Colors.grey,
                          size: 24,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${workout.set}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),


            Icon (
              Icons.arrow_forward_rounded,
              color: workout.isCompleted ? AppColors.mainColor : Colors.black,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
