import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_10_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_11_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_12_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_13_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_14_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_15_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_1_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_2_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_3_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_4_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_5_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_6_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_7_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_8_screen.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_9_screen.dart';
import 'package:rev_me_app/view/screens/auth/reset_password_screen.dart';
import 'package:rev_me_app/view/screens/auth/sign_in_screen.dart';
import 'package:rev_me_app/view/screens/auth/sign_up_screen.dart';
import 'package:rev_me_app/view/screens/welcome/page_view_screen.dart';
import 'package:rev_me_app/view/screens/welcome/slash_screen.dart';
import 'package:rev_me_app/view/screens/welcome/welcome_screen.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';

void main() {
  runApp(const RevMeApp());
}

class RevMeApp extends StatelessWidget {
  const RevMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignInScreen.id,
      routes: {
        SlashScreen.id: (context) => const SlashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SignInScreen.id: (context) => const SignInScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
        PageViewScreen.id: (context) => const PageViewScreen(),
        CustomBottomNavigationBar.id: (context) => CustomBottomNavigationBar(),


        Assessment1Screen.id: (context) => const Assessment1Screen(),
        Assessment2Screen.id: (context) => const Assessment2Screen(),
        Assessment3Screen.id: (context) => const Assessment3Screen(),
        Assessment4Screen.id: (context) => const Assessment4Screen(),
        Assessment5Screen.id: (context) => const Assessment5Screen(),
        Assessment6Screen.id: (context) => const Assessment6Screen(),
        Assessment7Screen.id: (context) => const Assessment7Screen(),
        Assessment8Screen.id: (context) => const Assessment8Screen(),
        Assessment9Screen.id: (context) => const Assessment9Screen(),
        Assessment10Screen.id: (context) => const Assessment10Screen(),
        Assessment11Screen.id: (context) => const Assessment11Screen(),
        Assessment12Screen.id: (context) => const Assessment12Screen(),
        Assessment13Screen.id: (context) => const Assessment13Screen(),
        Assessment14Screen.id: (context) => const Assessment14Screen(),
        Assessment15Screen.id: (context) => const Assessment15Screen(),
      },
    );
  }
}
