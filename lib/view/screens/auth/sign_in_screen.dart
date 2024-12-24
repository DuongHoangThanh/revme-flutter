import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/screens/auth/reset_password_screen.dart';
import 'package:rev_me_app/view/screens/auth/sign_up_screen.dart';
import 'package:rev_me_app/view/widgets/bottom_navigation.dart';
import 'package:rev_me_app/view/widgets/custom_textfield.dart';
import 'package:rev_me_app/viewmodels/user_viewmodel.dart';

class SignInScreen extends StatefulWidget {
  static const String id = 'sign_in_screen';

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _usernameController.text = 'chanh123';
    // _passwordController.text = '123123';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
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
                    child: Column(
                      children: [
                        const SizedBox(height: 55),
                        Hero(
                          tag: 'logo',
                          child: const Image(
                            image: AssetImage('assets/logo.png'),
                            height: 55,
                            width: 55,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Sign In To RevMe',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 16),
                        const Text("Let's personalize your fitness with AI",
                            style: TextStyle(
                              color: Color(0xFF393C43),
                              fontSize: 16,
                            )),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CustomTextField(
                            hintText: 'Username ',
                            controller: _usernameController,
                            prefixIcon: Icon(IconlyBold.message)),
                        SizedBox(height: 24),
                        CustomTextField(
                            hintText: 'Password',
                            controller: _passwordController,
                            prefixIcon: Icon(IconlyBold.lock),
                            obscureText: true),
                        SizedBox(height: 16),
                        if (viewModel.errorMessage != null)
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${viewModel.errorMessage!}",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        if (viewModel.isLoading == false)
                          TextButton(
                            onPressed: () {
                              final username = _usernameController.text.trim();
                              final password = _passwordController.text.trim();

                              if (username.isEmpty || password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please fill in all fields!'),
                                  ),
                                );
                              }

                              viewModel.login(username, password).then((_) {
                                if (viewModel.user != null) {
                                  Navigator.pushNamed(
                                      context, CustomBottomNavigationBar.id);
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
                            child: const Text('Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ),
                        SizedBox(height: 20),
                        if (viewModel.isLoading == true)
                          const CircularProgressIndicator(),
                        SizedBox(height: 20),
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
                              child: const Center(
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
                            const SizedBox(
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
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: TextStyle(
                                  color: Color(0xFF393C43),
                                  fontSize: 16,
                                )),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignUpScreen.id);
                              },
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 16,
                                  )),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ResetPasswordScreen.id);
                          },
                          child: const Text('Forgot Password?',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                              )),
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
