import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/assessment/assessment_1_screen.dart';
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
      initialRoute: WelcomeScreen.id,
      routes: {
        SlashScreen.id: (context) => const SlashScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        SignInScreen.id: (context) => const SignInScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
        PageViewScreen.id: (context) => const PageViewScreen(),
        CustomBottomNavigationBar.id: (context) => CustomBottomNavigationBar(),
        Assessment1Screen.id: (context) => const Assessment1Screen(),
      },
    );
  }
}
