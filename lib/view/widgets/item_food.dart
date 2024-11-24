import 'package:flutter/material.dart';

import '../../core/models/meal.dart';
import '../../themes/colors.dart';

class ItemFood extends StatefulWidget {
  final Meal meal;
  final bool isToday;
  final VoidCallback? onPressed;

  const ItemFood({
    super.key,
    required this.meal,
    required this.isToday,
    this.onPressed,
  });

  @override
  State<ItemFood> createState() => _ItemFoodState();
}

class _ItemFoodState extends State<ItemFood> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed!();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
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
                        image: NetworkImage(widget.meal.food.imageUrl!),
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
                            widget.meal.food.name,
                            style:  TextStyle(
                              color: widget.meal.status
                                  ? AppColors.mainColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.meal.food.calories.toString() + ' cal',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (widget.isToday == true)
                    Icon(
                      widget.meal.status
                          ? Icons.check_circle_outline_outlined
                          : Icons.circle_outlined,
                      color: widget.meal.status
                          ? AppColors.mainColor
                          : Colors.orange,
                      size: 30,
                    ),
                  if (widget.isToday == false)
                    Icon(
                      widget.meal.status
                          ? Icons.check_circle_outline_outlined
                          : Icons.circle_outlined,
                      color: widget.meal.status
                          ? AppColors.mainColor
                          : Colors.red,
                      size: 30,
                    ),

                  const SizedBox(
                    width: 8,
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
                    '${widget.meal.food.protein}g\nProtein',
                    style: const TextStyle(
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
                    '${widget.meal.food.fats}g\nFats',
                    style: const TextStyle(
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
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '${widget.meal.food.carbs}g\nCarbs',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
