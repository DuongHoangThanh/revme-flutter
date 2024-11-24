import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/auth/sign_in_screen.dart';
import '../../../themes/colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushNamed(context, SignInScreen.id);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            const Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Select what method you'd like to reset",
              style: TextStyle(
                color: Color(0xFF393C43),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 94,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F4),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Color(0xFFF97316),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Send via email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 220,
                            child: Text(
                              'Seamlessly reset your password via email address',
                              softWrap: true,
                              style: TextStyle(
                                color: Color(0xFF676C75),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF676C75),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 94,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F4),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Send via 2FA',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 220,
                            child: Text(
                              'Seamlessly reset your password via 2 Factors',
                              softWrap: true,
                              style: TextStyle(
                                color: Color(0xFF676C75),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF676C75),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 94,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F4),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Color(0xFF9333EA),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: const Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send via Google Auth',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          SizedBox(
                            width: 220,
                            child: Text(
                              'Seamlessly reset your password via Auth',
                              softWrap: true,
                              style: TextStyle(
                                color: Color(0xFF676C75),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF676C75),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {},
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
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
