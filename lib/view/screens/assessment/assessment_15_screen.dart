import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';

class Assessment15Screen extends StatefulWidget {
  static const String id = 'assessment_15_screen';

  const Assessment15Screen({super.key});

  @override
  State<Assessment15Screen> createState() => _Assessment15ScreenState();
}

class _Assessment15ScreenState extends State<Assessment15Screen> {
  final assessment = Assessment();

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
                  '15 of 15',
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
                      "Body Analysis",
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
                height: 20,
              ),
              Text(
                'We’ll now scan your body for better assessment result. Ensure the following:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image(image: AssetImage('assets/img_body.png')),
              SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Go it',
                icon: Icons.golf_course,
                onPressed: () {
                  Navigator.pushNamed(context, CustomBottomNavigationBar.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
