import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_3_screen.dart';

class Assessment2Screen extends StatefulWidget {

  static const String id = 'assessment_2_screen';

  const Assessment2Screen({super.key});

  @override
  State<Assessment2Screen> createState() => _Assessment2ScreenState();
}


class _Assessment2ScreenState extends State<Assessment2Screen> {
  int _currentValue = 20;
  final data = Assessment();
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
                  '2 of 15',
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
                      "What is your age? ",
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
              NumberPicker(
                itemHeight: 140,
                itemWidth: 280,
                value: _currentValue,
                minValue: 0,
                maxValue: 100,
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
                step: 1,
                haptics: true,
                onChanged: (value) => setState(() => _currentValue = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(color: AppColors.mainColor, width: 10),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Countinue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  data.age = _currentValue;
                  Navigator.pushNamed(
                    context,
                    Assessment3Screen.id,
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
