import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/core/models/meal.dart';
import 'package:rev_me_app/viewmodels/meal_viewmodel.dart';

import '../../../themes/colors.dart';
import '../../widgets/item_food.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String _selectedValue = DateTime.now().toIso8601String().split('T').first;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MealViewModel()
          ..fetchMeals(DateTime.now().toIso8601String().split('T').first),
        child: Consumer<MealViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Food Summary',
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
                    SizedBox(
                      height: 10,
                    ),
                    DatePicker(
                      DateTime.now().subtract(Duration(days: 2)),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: AppColors.mainColor,
                      selectedTextColor: Colors.white,
                      daysCount: 10,
                      width: 60,
                      height: 88,
                      onDateChange: (date) {
                        setState(() {
                          _selectedValue =
                              date.toIso8601String().split('T').first;
                          print(_selectedValue);
                          viewModel.fetchMeals(_selectedValue);
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    Container(
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
                                viewModel.caloriesConsumedPerDay
                                        .toInt()
                                        .toString() +
                                    ' kcal',
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
                                'F - 10/12g',
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
                                center: new Text(
                                  viewModel.percent.toString() + '%',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                backgroundColor: Colors.black,
                                percent: viewModel.percent / 100,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: AppColors.mainColor,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'C - 10/12g',
                                style: TextStyle(
                                  color: Color(0xFF858585),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                viewModel.caloriesTargetPerDay
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
                                'F - 10/12g',
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
                    const SizedBox(height: 30),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.meals.length,
                      itemBuilder: (context, index) {
                        Meal meal = viewModel.meals[index];

                        return ItemFood(
                          meal: meal,
                          isToday: viewModel.isToday,
                          onPressed: () {
                            viewModel.updateMealStatus(
                              meal.id,
                              true,
                              _selectedValue,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
