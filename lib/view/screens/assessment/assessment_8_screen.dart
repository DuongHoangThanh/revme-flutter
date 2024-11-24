import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_9_screen.dart';

class Assessment8Screen extends StatefulWidget {
  static const String id = 'assessment_8_screen';

  const Assessment8Screen({super.key});

  @override
  State<Assessment8Screen> createState() => _Assessment8ScreenState();
}

class _Assessment8ScreenState extends State<Assessment8Screen> {
  int _currentValue = 1;
  String dietPreference = 'Plant Based';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Text(
              'Assessment',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '8 of 15',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Do you have a specific diet preference?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              GridView.count(
                  crossAxisCount: 2,
                  // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CustomRadio(
                      value: 1,
                      text: 'Plant Based',
                      subText: 'Vegan, Vegetarian',
                      icon: 'assets/ic_leaf.png',
                      groupValue: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value!;
                          dietPreference = 'Plant Based';
                        });
                      },
                    ),

                    CustomRadio(
                      value: 2,
                      text: 'Carbo Diet',
                      subText: 'Bread, etc',
                      icon: 'assets/ic_bread.png',
                      groupValue: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value!;
                          dietPreference = 'Carbo Diet';
                        });
                      },
                    ),
                    CustomRadio(
                      value: 3,
                      text: 'Protein Diet',
                      subText: 'Meat, Fish, etc',
                      icon: 'assets/ic_dinner.png',
                      groupValue: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value!;
                          dietPreference = 'Protein Diet';
                        });
                      },
                    ),
                    CustomRadio(
                      value: 4,
                      text: 'Balanced Diet',
                      subText: 'All types of food',
                      icon: 'assets/ic_traditional.png',
                      groupValue: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value!;
                          dietPreference = 'Balanced Diet';
                        });
                      },
                    ),
                  ]),
              SizedBox(
                height: 40,
              ),
              CustomButtonBlack(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.dietaryPreferences = dietPreference;
                  Navigator.pushNamed(context, Assessment9Screen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final int value;
  final String text;
  final String subText;
  final int groupValue;
  final String icon;

  final Function(int?)? onChanged;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.text,
    required this.subText,
    required this.icon,
    required this.groupValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null && value != groupValue) {
          onChanged!(value); // Trigger onChanged with the selected value
        }
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              value == groupValue ? AppColors.mainColor : Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: value == groupValue
                ? AppColors.mainColor.withOpacity(0.8)
                : Colors.transparent,
            width: 5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          text.toString(),
                          style: TextStyle(
                            color: value == groupValue
                                ? Colors.white
                                : Color(0xFF393C43),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      subText.toString(),
                      style: TextStyle(
                        color: value == groupValue
                            ? Colors.white
                            : Color(0xFF676C75),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ImageIcon(
                      AssetImage(icon),
                      color: value == groupValue
                          ? Colors.white
                          : Color(0xFF676C75),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
