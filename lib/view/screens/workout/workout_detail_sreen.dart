import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../core/models/workout.dart';
import '../../../viewmodels/workout_viewmodel.dart';

class WorkoutDetailScreen extends StatefulWidget {
  static const String id = 'workout_detail_sreen';

  Workout? workout;

  WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void dispose() {
    super.dispose();
    _youtubePlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.workout!.exercise.videoUrl,
      )!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    return ChangeNotifierProvider(
        create: (context) => WorkoutViewModel(),
        child: Consumer<WorkoutViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [

                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.workout!.exercise.imageUrl,
                              scale: 1),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _youtubePlayerController.dispose();
                                            _youtubePlayerController.pause();
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 100),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: Text(
                                      widget.workout!.exercise.durationMinutes
                                              .toString() +
                                          ' min',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Center(
                                    child: Text(
                                      widget.workout!.exercise.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'With Azunyan U. Wu',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.workout!.exercise.durationMinutes
                                              .toString() +
                                          ' min',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Text(
                                      'Time',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                Container(
                                  height: 60,
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department_rounded,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.workout!.exercise.calories
                                              .toString() +
                                          ' cal',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      'Calories',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 60,
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.workspaces_outline,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.workout!.exercise.sets.toString() +
                                          ' sets',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      'Sets',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text("Description :",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.workout!.exercise.description ?? '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 20),
                            if (viewModel.isChooseWorkout == true)
                            Container(
                              height: 200,
                              child: YoutubePlayer(
                                controller: _youtubePlayerController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.amber,
                                progressColors: const ProgressBarColors(
                                  playedColor: Colors.amber,
                                  handleColor: Colors.amberAccent,
                                ),
                                onReady: () {
                                  // _controller.addListener(listener);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 16,
                            ),
                            if (viewModel.isChooseWorkout)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    viewModel.updateWorkoutStatus(
                                        widget.workout!.id, true);
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomNavigationBar(
                                              indexScreen: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Complete",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 12),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                                ),
                              ),
                            if (viewModel.isChooseWorkout == false)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    viewModel.isChooseWorkout = true;
                                  });

                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Start Workout",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 12),
                                          Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                          )
                                        ],
                                      )),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
        }));
  }
}
