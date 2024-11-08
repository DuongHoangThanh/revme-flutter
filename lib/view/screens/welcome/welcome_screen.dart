import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/auth/sign_in_screen.dart';
import 'package:rev_me_app/view/screens/welcome/page_view_screen.dart';

import '../../../themes/colors.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image_girl_2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your widgets here
              const Text('Welcome to RevMe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  )),
              const Text('Transform Yourself, Conquer Life 💪' ,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
              const SizedBox(height: 40),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  fixedSize: const Size(200, 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
               onPressed: () {

               },
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageViewScreen.id);
                    },
                    child: Text('Get Started', style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    ),
                  ),
                  SizedBox(width: 8), // Add some space between the text and the icon
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
              )),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.id);
                    },
                    child: const Text('Sign in',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                        )),
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
