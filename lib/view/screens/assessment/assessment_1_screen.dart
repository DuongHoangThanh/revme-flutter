import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_2_screen.dart';

class Assessment1Screen extends StatefulWidget {
  static const String id = 'assessment_1_screen';

  const Assessment1Screen({super.key});

  @override
  State<Assessment1Screen> createState() => _Assessment1ScreenState();
}

class _Assessment1ScreenState extends State<Assessment1Screen> {
  int _value = 1;
  String gender = 'Male';
  final data = Assessment();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
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
                  '1 of 15',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "What is your gender?",
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
              value: 0,
              icon: Icons.male,
              groupValue: _value,
              text: "Male",
              image: 'assets/img_man_running.png',
              onChanged: (value) {
                setState(() {
                  _value = value!;
                  gender = "Male";
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            CustomRadio(
              value: 1,
              icon: Icons.female,
              groupValue: _value,
              text: "Female",
              image: 'assets/img_woman_running.png',
              onChanged: (value) {
                setState(() {
                  _value = value!;
                  gender = "Female";
                });
              },
            ),
            SizedBox(
              height: 60,
            ),
            CustomButtonBlack(
              label: 'Continue',
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                data.gender = gender;
                print("AAA ${data.gender}");

                Navigator.pushNamed(context, Assessment2Screen.id,
                    arguments: gender);
              },
            ),
          ],
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
  final String image;
  final Function(int?)? onChanged;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.text,
    required this.icon,
    required this.groupValue,
    this.onChanged,
    required this.image,
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
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          color: value == groupValue ? AppColors.mainColor : Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: value == groupValue
                ? AppColors.mainColor.withOpacity(0.8)
                : Colors.transparent,
            width: 5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 26,
                  ),
                  SizedBox(width: 6),
                  Text(
                    text.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    value == groupValue
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    color: Colors.black,
                    size: 24,
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
