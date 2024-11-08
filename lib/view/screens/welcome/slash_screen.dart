import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/welcome/welcome_screen.dart';

import '../../../themes/colors.dart';

class SlashScreen extends StatefulWidget {
  static const String id = 'slash_screen';
  const SlashScreen({super.key});

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/logo.png') , height: 160, fit:  BoxFit.cover,),
          Center(child: Image(image: AssetImage('assets/text_logo.png') , width:226 , fit:  BoxFit.cover,)),
        ],
      )
    );
  }
}
