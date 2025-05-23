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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final viewModel = Provider.of<HomeViewModel>(context, listen: false);
        viewModel.initCheckInStatus();
      }
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
                      _buildAttendanceCheckInCard(context, viewModel),
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
                            autoPlayInterval: const Duration(seconds: 2)),
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
                      SizedBox(
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
                      _buildGoalTrackerCard(context, viewModel),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildCommunityChallenges(context, viewModel),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildNFTAchievementsSection(context, viewModel),
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
                      _buildNutritionTracker(context, viewModel),
                      _buildTodaysWorkoutPlan(context, viewModel),
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

  // Add this new widget in HomeScreen class
  Widget _buildAttendanceCheckInCard(
      BuildContext context, HomeViewModel viewModel) {
    // Track if user has already checked in today
    bool hasCheckedInToday = viewModel.hasCheckedInToday ?? false;
    int streak = viewModel.attendanceStreak ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mainColor,
            Color(0xFFFF8F00),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements - more creative pattern
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          // Small decorative circles
          Positioned(
            top: 20,
            right: 100,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 60,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ),

          // Main content with column layout (fixes overflow)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with title and streak badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.token,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Daily Check-In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // Streak counter with animation
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            color: Colors.orangeAccent,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$streak days',
                            style: const TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Weekly streak indicator
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 7; i++)
                        _buildDayIndicator(
                            i < streak % 7, i == DateTime.now().weekday - 1),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Bottom row with reward text and button
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hasCheckedInToday
                                ? 'You\'ve earned tokens today!'
                                : 'Check in for 5 FIT tokens',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hasCheckedInToday
                                ? 'Come back tomorrow for more'
                                : 'Maintain your streak for bonuses',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Button that animates when pressed
                    SizedBox(
                      width: 90, // Slightly smaller to prevent overflow
                      child: ElevatedButton(
                        onPressed: hasCheckedInToday
                            ? null
                            : () => _handleCheckIn(context, viewModel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasCheckedInToday
                              ? Colors.grey.withOpacity(0.7)
                              : Colors.white,
                          foregroundColor: AppColors.mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 4,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: Colors.grey.shade400,
                          disabledForegroundColor: Colors.white70,
                        ),
                        child: Text(
                          hasCheckedInToday ? 'Claimed' : 'Check In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: hasCheckedInToday
                                ? Colors.white
                                : AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Helper widget for day indicator bubbles in streak tracker
  Widget _buildDayIndicator(bool isCompleted, bool isToday) {
    return Column(
      children: [
        Container(
          width: isToday ? 24 : 20,
          height: isToday ? 24 : 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? Colors.white : Colors.white.withOpacity(0.3),
            border: isToday ? Border.all(color: Colors.white, width: 2) : null,
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check,
                  size: 14,
                  color: AppColors.mainColor,
                )
              : null,
        ),
        if (isToday)
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
      ],
    );
  }

// Add this method to handle check-in
  void _handleCheckIn(BuildContext context, HomeViewModel viewModel) {
    viewModel.checkInToEarnFIT().then((success) {
      if (success) {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Check-in Success",
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation1, animation2) {
            return Container(); // Not used
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            );

            return ScaleTransition(
              scale:
                  Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
              child: FadeTransition(
                opacity: animation,
                child: AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  elevation: 0,
                  content: Container(
                    width: 320,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.mainColor, Color(0xFFFF8F00)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated check mark
                        TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 800),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, value, child) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: value,
                                      strokeWidth: 6,
                                      color: Colors.white,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Congratulations!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.token,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '5 FIT Tokens',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'You\'ve earned tokens for today\'s check-in!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.mainColor,
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Awesome!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildGoalTrackerCard(BuildContext context, HomeViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade700, Colors.blue.shade500],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade700.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Weekly Goal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  '4/7 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: 4 / 7, // Replace with actual progress
                minHeight: 12,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            // Goal description
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Complete 7 workouts this week',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+25 FIT',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityChallenges(
      BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Community Challenges",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Join All",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildChallengeCard(
                title: "10K Steps Daily",
                participants: 1243,
                daysLeft: 5,
                progress: 0.7,
                reward: 50,
                iconData: Icons.directions_walk,
                gradientColors: [Colors.green.shade600, Colors.green.shade400],
              ),
              const SizedBox(width: 16),
              _buildChallengeCard(
                title: "30-Day Plank",
                participants: 857,
                daysLeft: 12,
                progress: 0.6,
                reward: 75,
                iconData: Icons.fitness_center,
                gradientColors: [
                  Colors.purple.shade700,
                  Colors.purple.shade500
                ],
              ),
              const SizedBox(width: 16),
              _buildChallengeCard(
                title: "Weight Loss",
                participants: 2104,
                daysLeft: 21,
                progress: 0.3,
                reward: 100,
                iconData: Icons.monitor_weight,
                gradientColors: [
                  Colors.orange.shade700,
                  Colors.orange.shade500
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required int participants,
    required int daysLeft,
    required double progress,
    required int reward,
    required IconData iconData,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.token,
                        size: 14,
                        color: AppColors.mainColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$reward FIT',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$participants people joined',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$daysLeft days left',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Join',
                    style: TextStyle(
                      color: gradientColors[0],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNFTAchievementsSection(
      BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My NFT Achievements",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "View All",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildNFTCard(
                name: "First Marathon",
                date: "Oct 15, 2024",
                image:
                    "https://media.istockphoto.com/id/1244669138/vector/running-woman.jpg?s=612x612&w=0&k=20&c=p9uNl-f2b0sAv6YALtNlyBlQDtY0PI4MX_s1ZoN6HYA=",
                rarity: "Rare",
                unlocked: true,
              ),
              const SizedBox(width: 16),
              _buildNFTCard(
                name: "30-Day Streak",
                date: "Nov 2, 2024",
                image:
                    "https://play-lh.googleusercontent.com/fQZdfpvD99Cr6FHHXX6DeOaZk_PIXOlGbSo3L7X5TJ-KuyDVImlYx9rT-EV6b3EEHA=w240-h480-rw",
                rarity: "Epic",
                unlocked: true,
              ),
              const SizedBox(width: 16),
              _buildNFTCard(
                name: "Weight Goal",
                date: "???",
                image:
                    "https://media.self.com/photos/5a0cb9c1e91faa1fe33155f7/4:3/w_2560%2Cc_limit/Fertility-and-Weight.jpg",
                rarity: "Legendary",
                unlocked: false,
              ),
              const SizedBox(width: 16),
              _buildNFTCard(
                name: "First 5K",
                date: "???",
                image:
                    "https://media.istockphoto.com/id/1281237710/photo-of",
                rarity: "Legendary",
                unlocked: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNFTCard({
    required String name,
    required String date,
    required String image,
    required String rarity,
    required bool unlocked,
  }) {
    Color borderColor;
    switch (rarity) {
      case "Common":
        borderColor = Colors.grey;
        break;
      case "Rare":
        borderColor = Colors.blue;
        break;
      case "Epic":
        borderColor = Colors.purple;
        break;
      case "Legendary":
        borderColor = Colors.orange;
        break;
      default:
        borderColor = Colors.grey;
    }

    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: unlocked ? borderColor : Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: Stack(
              children: [
                Image.network(
                  image,
                  width: 110,
                  height: 90,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 110,
                      height: 90,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 110,
                    height: 90,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
                if (!unlocked)
                  Container(
                    width: 110,
                    height: 90,
                    color: Colors.black.withOpacity(0.7),
                    child: const Center(
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      rarity,
                      style: TextStyle(
                        color: borderColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: unlocked ? Colors.black : Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10,
                    color: unlocked
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 12,
                      color: unlocked ? borderColor : Colors.grey.shade400,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      unlocked ? "Verified" : "Locked",
                      style: TextStyle(
                        fontSize: 10,
                        color: unlocked ? borderColor : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysWorkoutPlan(
      BuildContext context, HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Workout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: AppColors.mainColor,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "45 min",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildWorkoutExercise(
            name: "Warm-up",
            duration: "5 min",
            isCompleted: true,
          ),
          _buildWorkoutExercise(
            name: "Push-ups",
            sets: "3 sets × 15 reps",
            isCompleted: true,
          ),
          _buildWorkoutExercise(
            name: "Squats",
            sets: "3 sets × 20 reps",
            isCompleted: false,
          ),
          _buildWorkoutExercise(
            name: "Plank",
            duration: "3 × 60 sec",
            isCompleted: false,
          ),
          _buildWorkoutExercise(
            name: "Cool-down Stretch",
            duration: "5 min",
            isCompleted: false,
            isLast: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Start Workout",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutExercise({
    required String name,
    String? duration,
    String? sets,
    required bool isCompleted,
    bool isLast = false,
  }) {
    return Row(
      children: [
        // Timeline dot and line
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.mainColor : Colors.grey.shade300,
                border: Border.all(
                  color:
                      isCompleted ? AppColors.mainColor : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: isCompleted ? AppColors.mainColor : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        // Exercise details
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:
                            isCompleted ? Colors.grey.shade600 : Colors.black,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (duration != null || sets != null)
                      Text(
                        duration ?? sets!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                  ],
                ),
                if (!isCompleted)
                  const Icon(
                    Icons.play_circle_fill,
                    color: AppColors.mainColor,
                    size: 28,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionTracker(BuildContext context, HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nutrition Tracker",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutrientCircle(
                label: "Calories",
                current: 1245,
                target: 2000,
                color: Colors.orange,
                unit: "kcal",
              ),
              _buildNutrientCircle(
                label: "Protein",
                current: 76,
                target: 140,
                color: Colors.red,
                unit: "g",
              ),
              _buildNutrientCircle(
                label: "Carbs",
                current: 145,
                target: 250,
                color: Colors.blue,
                unit: "g",
              ),
              _buildNutrientCircle(
                label: "Fat",
                current: 45,
                target: 65,
                color: Colors.green,
                unit: "g",
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Meals",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Add Meal",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMealItem(
            name: "Breakfast",
            time: "08:30 AM",
            calories: 450,
            image: "assets/breakfast.jpg",
          ),
          const SizedBox(height: 12),
          _buildMealItem(
            name: "Lunch",
            time: "12:45 PM",
            calories: 680,
            image: "assets/lunch.jpg",
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientCircle({
    required String label,
    required int current,
    required int target,
    required Color color,
    required String unit,
  }) {
    final double progress = current / target;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: progress > 1.0 ? 1.0 : progress,
                strokeWidth: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Column(
              children: [
                Text(
                  current.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  unit,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14,
          ),
        ),
        Text(
          "Goal: $target$unit",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildMealItem({
    required String name,
    required String time,
    required int calories,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade300,
                child: const Icon(Icons.restaurant),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  "$calories kcal",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
