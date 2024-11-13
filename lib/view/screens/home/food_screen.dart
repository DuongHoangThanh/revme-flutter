import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/models/day_workout.dart';
import '../../../themes/colors.dart';
import '../../widgets/item_day_workout.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<DayWorkout> dayWorkouts = List.generate(10, (index) {
    var day = DateTime.now().day - 3;
    return DayWorkout(id: 1, day: day + index, month: "Nov");
  });

  void _selectDay(int index) {
    setState(() {
      // Update only the selected item as `isCompleted`
      for (int i = 0; i < dayWorkouts.length; i++) {
        dayWorkouts[i].isCompleted = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    DayWorkout dayWorkout = dayWorkouts[index];
                    if (dayWorkout.day == DateTime.now().day) {
                      dayWorkout.isCompleted = true;
                    } else {
                      dayWorkout.isCompleted = false;
                    }
                    return ItemDayWorkout(
                      dayWorkout: dayWorkout,
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
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
                        const Text(
                          '2875 kcal',
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
                          backgroundColor: Colors.black,
                          percent: 0.6,
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
                        const Text(
                          '2875 kcal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Remaining',
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
              ItemFood(
                name: 'Salad withh Egg',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToNP55MZXGstNs8JI7TpuGxDSjUC3u3CUYUQ&s',
                calor: '294 kcal -100g',
                protein: 10,
                fat: 5,
                carb: 20,
                isChecked: false,
              ),
              SizedBox(
                height: 16,
              ),
              ItemFood(
                name: 'Avocado Dish',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXUv3XZsKac8VB4-3qPnwUtX2J-kTe6CxSLA&s',
                calor: '294 kcal -100g',
                protein: 10,
                fat: 5,
                carb: 20,
                isChecked: true,
              ),
              SizedBox(
                height: 16,
              ),
              ItemFood(
                name: 'Pan Cake',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSV9h_8K7xQUVmmotVvnRX3BMJDmsboWXxrCQ&s',
                calor: '294 kcal -100g',
                protein: 10,
                fat: 5,
                carb: 20,
                isChecked: true,
              ),
              SizedBox(
                height: 16,
              ),
              ItemFood(
                name: 'Avocado Dish',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6wx-iSjgW-FvMPmNzS57af2-OHa-MpYyWvw&s',
                calor: '294 kcal -100g',
                protein: 10,
                fat: 5,
                carb: 20,
                isChecked: true,
              ),
              SizedBox(
                height: 16,
              ),
              ItemFood(
                name: 'Avocado Dish',
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Salad_platter.jpg/1200px-Salad_platter.jpg',
                calor: '294 kcal -100g',
                protein: 10,
                fat: 5,
                carb: 20,
                isChecked: false,
              ),
              SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemFood extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String calor;

  final int protein;
  final int fat;
  final int carb;
  final bool isChecked;

  const ItemFood(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.calor,
      required this.protein,
      required this.fat,
      required this.carb,
      this.isChecked = false});

  @override
  State<ItemFood> createState() => _ItemFoodState();
}

class _ItemFoodState extends State<ItemFood> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 4),
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                      image: NetworkImage(widget.imageUrl),
                      height: 44,
                      width: 44,
                      fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.calor,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  isChecked
                      ? Icons.check_circle_outline_outlined
                      : Icons.circle_outlined,
                  color: isChecked ? AppColors.mainColor : Colors.orange,
                  size: 30,
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    width: 90,
                    height: 15,
                    child: SliderTheme(
                      data: const SliderThemeData(
                          thumbColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          activeTrackColor: AppColors.mainColor,
                          inactiveTrackColor: Colors.black,
                          trackHeight: 4,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 1)),
                      child: Slider(
                        min: 0,
                        max: 20,
                        value: 12,
                        onChanged: (value) async {},
                      ),
                    ),
                  ),
                ),
                Text(
                  '${widget.protein}g\nProtein',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 70),
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    width: 90,
                    height: 15,
                    child: SliderTheme(
                      data: const SliderThemeData(
                          thumbColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          activeTrackColor: AppColors.mainColor,
                          inactiveTrackColor: Colors.black,
                          trackHeight: 4,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 1)),
                      child: Slider(
                        min: 0,
                        max: 20,
                        value: 12,
                        onChanged: (value) async {},
                      ),
                    ),
                  ),
                ),
                Text(
                  '${widget.fat}g\nFats',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 80),
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    width: 90,
                    height: 15,
                    child: SliderTheme(
                      data: const SliderThemeData(
                          thumbColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          activeTrackColor: AppColors.mainColor,
                          inactiveTrackColor: Colors.black,
                          trackHeight: 4,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 1)),
                      child: Slider(
                        min: 0,
                        max: 20,
                        value: 12,
                        onChanged: (value) async {},
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '${widget.carb}g\nCarbs',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
