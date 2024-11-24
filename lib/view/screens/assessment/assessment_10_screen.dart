import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_11_screen.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';

class Assessment10Screen extends StatefulWidget {
  static const String id = 'assessment_10_screen';

  const Assessment10Screen({super.key});

  @override
  State<Assessment10Screen> createState() => _Assessment10ScreenState();
}

class _Assessment10ScreenState extends State<Assessment10Screen> {
  int _currentValue = 120;
  String workoutExperience = '';

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
                  '10 of 15',
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
                      "What is your workout experience ?",
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

              CustomRadio(
                value: 120,
                text: 'Beginner',
                icon: Icons.check_box_outline_blank,
                groupValue: _currentValue,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value!;
                    workoutExperience = 'Beginner';
                  });
                },
              ),

              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 121,
                text: 'Intermediate',
                icon: Icons.check_box_outline_blank,
                groupValue: _currentValue,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value!;
                    workoutExperience = 'Intermediate';
                  });
                },
              ),

              SizedBox(
                height: 16,
              ),

              CustomRadio(
                value: 122,
                text: 'Advanced',
                icon: Icons.check_box_outline_blank,
                groupValue: _currentValue,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value!;
                    workoutExperience = 'Advanced';
                  });
                },
              ),

              SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.workoutExperience = workoutExperience;
                  Navigator.pushNamed(context, Assessment11Screen.id);
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
        height: 60,
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
