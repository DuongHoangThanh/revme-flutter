import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_6_screen.dart';

class Assessment5Screen extends StatefulWidget {
  static const String id = 'assessment_5_screen';

  const Assessment5Screen({super.key});

  @override
  State<Assessment5Screen> createState() => _Assessment5ScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _Assessment5ScreenState extends State<Assessment5Screen> {
  int _currentValue = 3;
  String activityLevel = 'Sedentary';
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
                  '5 of 15',
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
                      "What is your activity level?",
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
                height: 60,
              ),

              CustomRadio(
                value: 1,
                text: 'Sedentary',
                icon: Icons.accessibility,
                groupValue: _currentValue,
                onChanged: (int? value) {
                  setState(() {
                    _currentValue = value!;
                    activityLevel = 'Sedentary';
                  });
                },

              ),
              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 2,
                text: 'Lightly Active',
                icon: Icons.accessibility,
                groupValue: _currentValue,
                onChanged: (int? value) {
                  setState(() {
                    _currentValue = value!;
                    activityLevel = 'LightlyActive';
                  });
                },

              ),
              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 3,
                text: 'Moderately Active',
                icon: Icons.accessibility,
                groupValue: _currentValue,
                onChanged: (int? value) {
                  setState(() {
                    _currentValue = value!;
                    activityLevel = 'ModeratelyActive';
                  });
                },

              ),
              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 180,
                text: 'Very Active',
                icon: Icons.accessibility,
                groupValue: _currentValue,
                onChanged: (int? value) {
                  setState(() {
                    _currentValue = value!;
                    activityLevel = 'VeryActive';
                  });
                },

              ),
              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 200,
                text: 'Super Active',
                icon: Icons.accessibility,
                groupValue: _currentValue,
                onChanged: (int? value) {
                  setState(() {
                    _currentValue = value!;
                    activityLevel = 'SuperActive';
                  });
                },
              ),

              const SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Countinue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.activityLevel = activityLevel;

                  Navigator.pushNamed(
                    context,
                    Assessment6Screen.id,
                  );
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
  final IconData icon;

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          
          color: value == groupValue ? AppColors.mainColor : Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: value == groupValue
                ? AppColors.mainColor.withOpacity(0.8)
                : Colors.transparent,
            width: 5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                text.toString(),
                style: TextStyle(
                  color: value == groupValue ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(
               value == groupValue ? Icons.check_box_outlined : Icons.check_box_outline_blank,
                color: value == groupValue ? Colors.white : Colors.black,
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
