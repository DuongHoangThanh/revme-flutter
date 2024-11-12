import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_13_screen.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';

class Assessment12Screen extends StatefulWidget {
  static const String id = 'assessment_12_screen';

  const Assessment12Screen({super.key});

  @override
  State<Assessment12Screen> createState() => _Assessment12ScreenState();
}

class _Assessment12ScreenState extends State<Assessment12Screen> {
  int _currentValue = 120;

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
                  '12 of 15',
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
                      "Daily workout time" ,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_currentValue.toString() ,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  Text(' min' ,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.mainColor, width: 5),
                    right: BorderSide(color: AppColors.mainColor, width: 5),
                  )
                ),
                child: NumberPicker(
                  value: _currentValue,
                  minValue: 0,
                  maxValue: 500,

                  step: 1,
                  itemHeight: 50,

                  textStyle: const TextStyle(
                    color: Color(0xFF676C75),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Color(0xFF676C75),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() => _currentValue = value),
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(color: AppColors.mainColor, width: 5),
                      )
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.daily_workout_time = _currentValue;
                  Navigator.pushNamed(context, Assessment13Screen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

