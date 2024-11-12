import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';
import '../../../core/models/assessment.dart';
import '../../../viewmodels/assessment_viewmodel.dart';
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
    return ChangeNotifierProvider(
      // create: (context) => AssessmentViewModel(),
      create: (context) =>
          AssessmentViewModel()..generateAndSavePlan(assessment),
      child: Consumer<AssessmentViewModel>(
        builder: (context, assViewmodel, child) {
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
                      'We have successfully completed your assessment. Now we will analyze your data and create a personalized plan for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image(
                      image: AssetImage('assets/img_body.png'),
                      height: 200,
                    ),
                    Text(
                      assViewmodel.isLoading.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    if (assViewmodel.isLoading == true)
                      CircularProgressIndicator(),
                    if (assViewmodel.isLoading == true)
                      Text(
                        'Please wait...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    if (assViewmodel.successMessage != null)
                      Image(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/music-sound-cloud.appspot.com/o/Animation%20-%201731426288836.gif?alt=media&token=a8003d7e-e32c-40b2-8312-0be755065a32'),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(
                      height: 60,
                    ),
                    CustomButtonBlack(
                      label: 'Go it',
                      icon: Icons.golf_course,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CustomBottomNavigationBar.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
