import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/view/screens/auth/sign_in_screen.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';

import '../../../themes/colors.dart';
import '../../../viewmodels/user_viewmodel.dart';
import '../../widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'sign_up_screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: Consumer<UserViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img_chess_press.png'),
                        fit: BoxFit.cover,
                        opacity: 0.75,
                      ),
                    ),
                    child: const Column(
                      children: [
                        SizedBox(height: 55),
                        Hero(
                          tag: 'logo',
                          child: Image(
                            image: AssetImage('assets/logo.png'),
                            height: 55,
                            width: 55,
                            fit: BoxFit.fill,

                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Sign Up For Free',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 16),
                        Text("Quickly make your account in 1 minute",
                            style: TextStyle(
                              color: Color(0xFF393C43),
                              fontSize: 16,
                            )),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CustomTextField(
                            hintText: 'User name',
                            controller: _usernameController,
                            prefixIcon: Icon(IconlyBold.user2)),
                        SizedBox(height: 24),
                        CustomTextField(
                            hintText: 'Email',
                            controller: _emailController,
                            prefixIcon: Icon(IconlyBold.message)),
                        SizedBox(height: 24),
                        CustomTextField(
                            hintText: 'Password',
                            controller: _passwordController,
                            prefixIcon: Icon(IconlyBold.lock),
                            obscureText: true),
                        SizedBox(height: 24),
                        CustomTextField(
                            hintText: 'Confirm Password',
                            controller: _confirmPasswordController,
                            prefixIcon: Icon(IconlyBold.lock),
                            obscureText: true),
                        SizedBox(height: 10),
                        if (viewModel.errorMessage != null)
                          Row(
                            children: [
                              Text(
                                viewModel.errorMessage!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                        SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            final username = _usernameController.text.trim();
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            final confirmPassword =
                                _confirmPasswordController.text.trim();

                            if (username.isEmpty ||
                                email.isEmpty ||
                                password.isEmpty ||
                                confirmPassword.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill in all fields'),
                                ),
                              );
                              return; // Return early if any field is empty
                            }
                            if (password != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match'),
                                ),
                              );
                              return; // Return early if passwords do not match
                            }
                            viewModel
                                .register(username, email, password)
                                .then((result) {
                              if (result == "User registered successfully!") {
                                Navigator.pushNamed(
                                    context, SignInScreen.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Registration successful'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result),
                                  ),
                                );
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.mainColor,
                            minimumSize: const Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )),
                              SizedBox(width: 10),
                              const Icon(Icons.arrow_forward,
                                  color: Colors.white),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: const Center(
                                child: Image(
                                  image: NetworkImage(
                                      'https://static.vecteezy.com/system/resources/previews/018/930/415/non_2x/instagram-logo-instagram-icon-transparent-free-png.png'),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Center(
                                child: Image(
                                  image: NetworkImage(
                                    'https://img.icons8.com/?size=512&id=118497&format=png',
                                  ),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Center(
                                child: Image(
                                  image: NetworkImage(
                                    'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                                  ),
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: TextStyle(
                                  color: Color(0xFF393C43),
                                  fontSize: 16,
                                )),
                            TextButton(
                              onPressed: () {
                                // return to sign in screen
                                Navigator.pushNamed(context, SignInScreen.id);
                              },
                              child: const Text('Sign In',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
