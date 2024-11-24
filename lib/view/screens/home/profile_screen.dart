import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/screens/auth/sign_in_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 122,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Account Settings',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'General',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Edit Profile',
                  icon: Icons.notifications_none,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Personal Information',
                  icon: Icons.person,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Coach Contact',
                  icon: Icons.phone,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Language',
                  icon: Icons.language,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Security & Privacy',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Main Security',
                  icon: Icons.lock,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Privacy',
                  icon: Icons.privacy_tip_outlined,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Support',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'About Us',
                  icon: Icons.info,
                  onTap: () {},
                ),

                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Help Center',
                  icon: Icons.help_outline,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                  title: 'Submit Feedback',
                  icon: Icons.feedback,
                  onTap: () {},
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Danger Zone',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 41,
                              height: 41,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF58383),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Icon(
                                Icons.delete_outlined,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Delete Account',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Log Out',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomLineSetting(
                    title: 'Log Out', icon: Icons.logout, onTap: () {
                      Navigator.pushNamed(context, SignInScreen.id);
                    }),
                // Add more content here to ensure scrolling
                SizedBox(height: 150), // Example additional content
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomLineSetting extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const CustomLineSetting(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(0xFFEAE8E8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 41,
                    height: 41,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(icon)),
                SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
