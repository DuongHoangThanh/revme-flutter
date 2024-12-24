import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:rev_me_app/core/models/workout.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../screens/workout/workout_detail_sreen.dart';
import 'package:intl/intl.dart';

class ItemWorkout extends StatelessWidget {
  final Workout workout;

  ItemWorkout({super.key, required this.workout});

  var today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // check is today or not

        var specificDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(workout.plan.specificDate));

        if (specificDate == today) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutDetailScreen(workout: workout),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You can only view today\'s workout'),
              duration: Duration(seconds: 2),
            ),
          );
        }
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
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    workout.exercise.imageUrl,
                    height: 100,
                    width: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://login.medlatec.vn//ImagePath/images/20201223/20201223_lich-tap-gym-cho-nguoi-moi-bat-dau-co-the-tham-khao.jpg',
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                      );
                    },
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
                          workout.exercise.name,
                          style: TextStyle(
                            color: workout.status
                                ? AppColors.mainColor
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: workout.status
                              ? AppColors.mainColor
                              : Color(0xff9a9a9a),
                          size: 24,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${workout.exercise.durationMinutes} min',
                          style: TextStyle(
                            color: workout.status
                                ? AppColors.mainColor
                                : Color(0xff9a9a9a),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          IconlyBold.discovery,
                          color: workout.status
                              ? AppColors.mainColor
                              : Color(0xff9a9a9a),
                          size: 24,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${workout.exercise.calories} cal',
                          style: TextStyle(
                            color: workout.status
                                ? AppColors.mainColor
                                : Color(0xff9a9a9a),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              workout.status!
                  ? Icons.check_circle
                  : Icons.arrow_forward_rounded,
              color: workout.status! ? AppColors.mainColor : Colors.black,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
