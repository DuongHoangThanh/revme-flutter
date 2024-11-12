import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import 'package:rev_me_app/view/screens/home/feed_screen.dart';
import 'package:rev_me_app/view/screens/home/food_screen.dart';
import 'package:rev_me_app/view/screens/home/home_screen.dart';
import 'package:rev_me_app/view/screens/home/profile_screen.dart';
import 'package:rev_me_app/view/screens/home/workout_sreen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  static const String id = 'bottom_navigation_bar';
  final int indexScreen;

  const CustomBottomNavigationBar({
    Key? key,
    this.indexScreen = 0,
  }) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.indexScreen;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      WorkoutSreen(),
      FeedScreen(),
      FoodScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF3F3F4),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                offset: Offset(1, 4),
                blurRadius: 14,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: _currentIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Color(0xFFA3A3A3),
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                _buildBottomNavigationBarItem(
                  icon: 'assets/ic_home.png',
                  label: 'Home',
                  isSelected: _currentIndex == 0,
                ),
                _buildBottomNavigationBarItem(
                  icon: 'assets/ic_barbell.png',
                  label: 'Workouts',
                  isSelected: _currentIndex == 1,
                ),
                _buildBottomNavigationBarItem(
                  icon: 'assets/ic_group.png',
                  label: 'Feed',
                  isSelected: _currentIndex == 2,
                ),
                _buildBottomNavigationBarItem(
                  icon: 'assets/ic_dinner.png',
                  label: 'Food',
                  isSelected: _currentIndex == 3,
                ),
                _buildBottomNavigationBarItem(
                  icon: 'assets/ic_user.png',
                  label: 'Profile',
                  isSelected: _currentIndex == 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: ImageIcon(
          AssetImage(icon),
          size: 24,
        ),
      ),
      label: label,
    );
  }
}
