import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';
import '../../../core/models/assessment.dart';
import '../../../data/local/UserPreferences.dart';
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

  var _token = '';

  @override
  void initState() {
    super.initState();
    UserPreferences().getToken().then((value) {
      setState(() {
        _token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AssessmentViewModel(),
      child: Consumer<AssessmentViewModel>(
        builder: (context, assViewmodel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 1,
                  ),
                  const Text(
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
                    child: const Center(
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
                    const SizedBox(
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'We have successfully completed your assessment. Now we will analyze your data and create a personalized plan for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Image(
                      image: AssetImage('assets/img_body.png'),
                      height: 200,
                    ),
                    if (assViewmodel.isLoading == true)
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 50,
                              width: 50,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.mainColor),
                                strokeWidth: 5.0,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'We are analyzing your data, please wait...',
                            style: TextStyle(
                              color: Color(0xff9c9c9c),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    if (assViewmodel.successMessage != null)
                      const Image(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/music-sound-cloud.appspot.com/o/Animation%20-%201731426288836.gif?alt=media&token=a8003d7e-e32c-40b2-8312-0be755065a32'),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    if (assViewmodel.errorMessage != null)
                      const Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'An error occurred, please try again later !',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (assViewmodel.successMessage == null)
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtonBlack(
                            label: 'Go it',
                            icon: Icons.generating_tokens,
                            onPressed: () {
                              assViewmodel
                                  .generateAndSavePlan(assessment, _token)
                                  .then((value) {
                              });
                            },
                          ),
                        ],
                      ),
                    if (assViewmodel.successMessage != null)
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, CustomBottomNavigationBar.id);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          minimumSize: const Size(double.infinity, 64),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Back to Home',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),

                          ],
                        ),
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
