import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rev_me_app/themes/colors.dart';

import '../assessment/assessment_1_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(57),
                            child: Image.network(
                              'https://picsum.photos/250?image=9',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome !!!",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Duy Chánh",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/ic_verify.png'),
                          color: Colors.black,
                          size: 30,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        ImageIcon(
                          AssetImage('assets/ic_notification.png'),
                          color: Colors.black,
                          size: 30,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F4),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(1, 1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Workout Progress !",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Assessment1Screen.id);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    // add
                                    Icons.add_circle_outline,
                                    color: AppColors.mainColor,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Create your own workout",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: CircularPercentIndicator(
                            radius: 30.0,
                            // Adjusted radius to fit within the container
                            lineWidth: 7,
                            percent: 0.75,
                            center: Text('75%'),
                            progressColor: AppColors.mainColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 210,
                      width: 180,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Calories",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ImageIcon(
                                  AssetImage('assets/ic_fire.png'),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  new CircularPercentIndicator(
                                      radius: 60,
                                      animation: true,
                                      animationDuration: 1200,
                                      lineWidth: 12.0,
                                      percent: 0.6,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.black,
                                      center: new Text(
                                        textAlign: TextAlign.center,
                                        "730\n /Kcal",
                                        style: new TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        height: 161,
                        decoration: BoxDecoration(
                          color: Color(0xFFF3F3F4),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Steps",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "230",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 154,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFF252525),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sleep",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                new CircularPercentIndicator(
                                  radius: 40,
                                  animation: true,
                                  animationDuration: 1200,
                                  lineWidth: 10.0,
                                  backgroundColor: Colors.black,
                                  percent: 0.6,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: AppColors.mainColor,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '5/8',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'hours',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: Image(
                            image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIk4ZwoTr59cct06h9X0THts3BTpTKfAadQA&s',
                            ),

                            height: 242,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
