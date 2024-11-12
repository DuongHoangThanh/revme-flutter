import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_12_screen.dart';

class Assessment11Screen extends StatefulWidget {
  static const String id = 'assessment_11_screen';

  const Assessment11Screen({super.key});

  @override
  State<Assessment11Screen> createState() => _Assessment11ScreenState();
}

class _Assessment11ScreenState extends State<Assessment11Screen> {
  int _currentValue = 120;
  String exercisePreference = '';

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
                  '11 of 15',
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
                      "Do you have a specific Exercise Preference?",
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
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CustomRadio(
                    value: 122,
                    text: 'Jogging',
                    icon: 'assets/ic_jogging.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Jogging';
                      });
                    },
                  ),
                  CustomRadio(
                    value: 123,
                    text: 'Walking',
                    icon: 'assets/ic_walking.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Walking';
                      });
                    },
                  ),
                  // hiking
                  CustomRadio(
                    value: 124,
                    text: 'Hiking',
                    icon: 'assets/ic_hiking.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Hiking';
                      });
                    },
                  ),
                  // skating
                  CustomRadio(
                    value: 125,
                    text: 'Skating',
                    icon: 'assets/ic_skating.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Skating';
                      });
                    },
                  ),
                  // cycling
                  CustomRadio(
                    value: 126,
                    text: 'Cycling',
                    icon: 'assets/ic_cycling.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Cycling';
                      });
                    },
                  ),
                  // weightlift
                  CustomRadio(
                    value: 127,
                    text: 'Weightlift',
                    icon: 'assets/ic_weightlift.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Weightlift';
                      });
                    },
                  ),
                  //cardio
                  CustomRadio(
                    value: 128,
                    text: 'Cardio',
                    icon: 'assets/ic_cardio.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Cardio';
                      });
                    },
                  ),
                  // yoga
                  CustomRadio(
                    value: 129,
                    text: 'Yoga',
                    icon: 'assets/ic_yoga.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Yoga';
                      });
                    },
                  ),
                  // orther
                  CustomRadio(
                    value: 130,
                    text: 'Other',
                    icon: 'assets/ic_other.png',
                    groupValue: _currentValue,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value!;
                        exercisePreference = 'Other';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.preferredExercise = exercisePreference;
                  Navigator.pushNamed(context, Assessment12Screen.id);
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
  final int groupValue;
  final String icon;

  final Function(int?)? onChanged;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.text,
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
          color: value == groupValue ? AppColors.mainColor : Color(0xFFE9E9E9),
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

              children: [
                SizedBox(height: 6),
                ImageIcon(
                  AssetImage(icon),
                  color: value == groupValue ? Colors.white : Color(0xFF676C75),
                  size: 40,
                ),
                SizedBox(height: 6),
                Text(
                  text.toString(),
                  style: TextStyle(
                    color: value == groupValue ? Colors.white : Color(0xFF676C75),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
