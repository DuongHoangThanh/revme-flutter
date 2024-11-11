import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';

import 'assessment_4_screen.dart';

class Assessment3Screen extends StatefulWidget {
  static const String id = 'assessment_3_screen';

  const Assessment3Screen({super.key});

  @override
  State<Assessment3Screen> createState() => _Assessment3ScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _Assessment3ScreenState extends State<Assessment3Screen> {
  int _currentValue = 20;

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
                  '3 of 15',
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
                      "What is your weight?",
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$_currentValue',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 96,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' kg',
                    style: TextStyle(
                      color: Color(0xFF676C75),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  // border: Border.all(color: AppColors.mainColor, width: 2),
                ),
                child: NumberPicker(
                  value: _currentValue,
                  minValue: 0,
                  maxValue: 500,
                  step: 1,
                  itemHeight: 40,

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
              const SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Countinue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.weight = _currentValue.toDouble();
                  Navigator.pushNamed(
                    context,
                    Assessment4Screen.id,
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