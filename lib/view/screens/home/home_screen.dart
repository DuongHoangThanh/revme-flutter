import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/dialogs/dialog_check_assessment.dart';
import 'package:rev_me_app/view/widgets/item_banner.dart';
import 'package:rev_me_app/view/widgets/item_metric.dart';

import '../../../core/models/user.dart';
import '../../../data/local/UserPreferences.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../dialogs/profile/bottom_sheet_language.dart';
import '../assessment/assessment_1_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _token = '';
  User? _user;
  int _curentBanner = 0;
  @override
  void initState() {
    super.initState();
    UserPreferences().getToken().then((value) {
      setState(() {
        _token = value;
        print('Token: $_token');
      });
    });
    UserPreferences().getUser().then((value) {
      setState(() {
        _user = value!;
        print('User: $_user');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel()..fetchWorkouts(),
        child: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!viewModel.isCreatedAssessment) {
              DialogCheckAssessment().show(context);
            }
          });
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 52, left: 16, right: 16),
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
                                  const Text(
                                    "Welcome !!!",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (_user != null)
                                    Text(
                                      _user!.username,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                          color: const Color(0xFFF3F3F4),
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
                                  const Text(
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
                                      Navigator.pushNamed(
                                          context, Assessment1Screen.id);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          // add
                                          Icons.add_circle_outline,
                                          color: AppColors.mainColor,
                                          size: 20,
                                        ),
                                        SizedBox(
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
                                  percent: viewModel.percent / 100,
                                  center: Text(
                                    "${viewModel.percent.toInt()}%",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  progressColor: AppColors.mainColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: const Offset(2, 5),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            percent: viewModel
                                                    .caloriesBurnedPerDay /
                                                viewModel.caloriesIntakePerDay,
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Colors.black,
                                            center: new Text(
                                              textAlign: TextAlign.center,
                                              '${viewModel.caloriesBurnedPerDay.toInt()} kcal \n/${viewModel.caloriesIntakePerDay.toInt()}',
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
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Container(
                              height: 210,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIk4ZwoTr59cct06h9X0THts3BTpTKfAadQA&s',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                color: const Color(0xFFF3F3F4),
                                borderRadius: BorderRadius.circular(17),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: const Offset(2, 5),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            // enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _curentBanner = index;
                              });
                            },
                            autoPlayInterval: Duration(seconds: 2)),
                        items: viewModel.banners.map((banner) {
                          return ItemBanner(banner: banner);
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < viewModel.banners.length; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: i == _curentBanner
                                    ? AppColors.mainColor
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Fitness Metrics",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              List<ItemMetric> metrics = [
                                const ItemMetric(
                                  value: 88,
                                  title: "Hydration",
                                  unit: "%",
                                  icon: Icons.local_drink,
                                  color: Colors.orange,
                                  image:
                                      "https://w7.pngwing.com/pngs/905/956/png-transparent-blue-and-red-bar-graph-illustration-bar-chart-graph-of-a-function-ppt-material-infographic-blue-png-material-thumbnail.png",
                                ),
                                const ItemMetric(
                                  value: 75,
                                  title: "Steps",
                                  unit: "k",
                                  icon: Icons.directions_walk,
                                  color: Colors.blue,
                                  image: "https://example.com/steps_image.png",
                                ),
                                const ItemMetric(
                                  value: 120,
                                  title: "Heart Rate",
                                  unit: "bpm",
                                  icon: Icons.favorite,
                                  color: Colors.red,
                                  image:
                                      "https://example.com/heart_rate_image.png",
                                ),
                                const ItemMetric(
                                  value: 8,
                                  title: "Sleep",
                                  unit: "h",
                                  icon: Icons.bedtime,
                                  color: Colors.purple,
                                  image: "https://example.com/sleep_image.png",
                                ),
                                const ItemMetric(
                                  value: 120,
                                  title: "Calories",
                                  unit: "kcal",
                                  icon: Icons.fireplace,
                                  color: Colors.orange,
                                  image:
                                      "https://example.com/calories_image.png",
                                ),
                              ];
                              return metrics[index];
                            }),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 164,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD6D6D6),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(2, 5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            top: 8,
                                            bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: const Column(
                                          children: [
                                            Text(
                                              "25g",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Protein",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                            top: 8,
                                            bottom: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: const Column(
                                          children: [
                                            Text(
                                              "16g",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Carbs",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Salad & Egg',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '548kcal      20 min',
                                                style: TextStyle(
                                                    color: Color(0xFF555555),
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: const Image(
                                    image: AssetImage('assets/img_dish.png'),
                                    width: 170,
                                    height: 170,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("AI Suggestions",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("See All",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.mainColor,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://stayfitcentral.b-cdn.net/wp-content/uploads/2024/02/IMG_1087-1400x800.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                          color: const Color(0xFFD6D6D6),
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(2, 5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(2, 5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF787272).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Yoga & Meditation",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Metaverse Yoga\nTraining',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 24),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Brenda lee Sensai',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        IconlyLight.timeSquare,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '30 min',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        IconlyLight.activity,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '548kcal',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              ));
        }));
  }
}
