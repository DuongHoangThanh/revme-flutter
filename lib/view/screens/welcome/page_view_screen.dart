import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/auth/sign_in_screen.dart';
import 'package:rev_me_app/view/screens/welcome/welcome_screen.dart';
import 'package:rev_me_app/view/widgets/custom_page_view.dart';

class PageViewScreen extends StatefulWidget {
  static const String id = 'page_view_screen';

  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> with TickerProviderStateMixin{

  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 5, vsync: this);
  }
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: const [
              CustomPageView(
                  title: "Personalized Fitness Plans",
                  description: "Choose your own fitness journey with AI. 🏋️‍♀️",
                  image:
                      "https://static.vecteezy.com/system/resources/previews/029/640/313/large_2x/a-gym-girl-doing-workout-in-gym-generative-ai-photo.jpg"),
              CustomPageView(
                  title: "Extensive Workout Libraries",
                  description: "Explore ~100K exercises made for you! 💪️",
                  image:
                      "https://cdn.muscleandstrength.com/sites/default/files/styles/800x500/public/lean-man-doing-lateral-raises.jpg?itok=ug5NBdtX"),
              CustomPageView(
                  title: "Health Metrics &  Fitness Analytics",
                  description: "Monitor your health profile with ease. 📈",
                  image:
                      "https://vinbrain.net/public/uploads/1blog/big-data-healthcare-min.jpg"),
              CustomPageView(
                  title: "Nutrition & Diet Guidance",
                  description: "Lose weight and get fit with revme! 🥒",
                  image:
                  "https://s30386.pcdn.co/wp-content/uploads/2020/02/p1bm5844cb6oacnd1std183s12gt6.jpg.optimal.jpg"),
              CustomPageView(
                  title: "Virtual AI Coach Mentoring",
                  description: "Say goodbye to manual coaching! 👋",
                  image:
                      "https://img.freepik.com/premium-photo/human-robot-with-metallic-silver-body_1057389-41183.jpg?w=740"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_currentPage > 0) {
                      _updateCurrentPageIndex(_currentPage - 1);
                    }
                  },
                  child: Container(
                    width: 160,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (_currentPage < 4) {
                      _updateCurrentPageIndex(_currentPage + 1);
                    } else {
                      Navigator.pushNamed(context, SignInScreen.id);
                    }
                  },
                  child: Container(

                    width: 160,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_sharp,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPage = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    if(index == 5){
      Navigator.pushNamed(context, WelcomeScreen.id);
    }
  }
}
