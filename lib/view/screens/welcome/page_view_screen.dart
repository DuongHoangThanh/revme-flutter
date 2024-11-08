import 'package:flutter/material.dart';
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
                      "https://scontent.fsgn2-3.fna.fbcdn.net/v/t1.15752-9/462574646_1069215811268634_693189479345637748_n.png?_nc_cat=107&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeEIQ5XypfcMivLPJouEcLkKowYXgHY9tyqjBheAdj23Kl3y1zviFxXmatPQ9MFb9HFcVR1TU1PqefX5xLab0y-M&_nc_ohc=cQQYVRWXJ1UQ7kNvgGrFMWP&_nc_zt=23&_nc_ht=scontent.fsgn2-3.fna&_nc_gid=ATB2ckaqFAWXD3TFj_jUj7W&oh=03_Q7cD1QGVsmZsFI7uubZLUTr1KTYD3UykRbBVqQYcu3xd3Ysktg&oe=6749D39C"),
              CustomPageView(
                  title: "Extensive Workout Libraries",
                  description: "Explore ~100K exercises made for you! 💪️",
                  image:
                      "https://scontent.fsgn2-10.fna.fbcdn.net/v/t1.15752-9/462554345_1088161285597870_2376033361799911236_n.png?_nc_cat=109&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeFyNidjTIk6S-Ju2hO6QPpE33tESoKnIsbfe0RKgqcixrgQx-_v7MDncEkbpbXYDahFVBkLHsRpGCtwKo6D3kYn&_nc_ohc=T0-AKHGfEnMQ7kNvgFRK6g5&_nc_zt=23&_nc_ht=scontent.fsgn2-10.fna&_nc_gid=AzUpIGJFNt9ImtZpaQmDApA&oh=03_Q7cD1QEermBikIvb_guyTnI9evpNHSAFH0Znv0C9fA9asAXklQ&oe=6749CB40"),
              CustomPageView(
                  title: "Health Metrics &  Fitness Analytics",
                  description: "Monitor your health profile with ease. 📈",
                  image:
                      "https://scontent.fsgn2-9.fna.fbcdn.net/v/t1.15752-9/462550618_3723225957895028_8644070429111490919_n.png?_nc_cat=103&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeFEtMgkBECQvcBaVicxwnqvY5CLxcY7UjZjkIvFxjtSNtPQhCLUpFWVn1MsOejOC9JB6_g-RVP7sv3-Hq-1TfVa&_nc_ohc=tz_2CA6kNbgQ7kNvgHqjEDY&_nc_zt=23&_nc_ht=scontent.fsgn2-9.fna&_nc_gid=AVSqZDyVEBCdBYvgFo2g3oQ&oh=03_Q7cD1QGl1PKE5VFaJlpJZbVsJjW-cRXCAQVKOWynzxAl_O3eKQ&oe=6749E229"),
              CustomPageView(
                  title: "Nutrition & Diet Guidance",
                  description: "Lose weight and get fit with revme! 🥒",
                  image:
                  "https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.15752-9/462553411_1878752439602709_4586472008345025249_n.png?_nc_cat=111&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeHx-TT84DK3_deFieTLm1NDoeBu_IKX1veh4G78gpfW9z6pEUfVwzYc2WW8vkqraqQcltAZCnuk8XfkJPPki768&_nc_ohc=sy1klT99c7wQ7kNvgEqEzGW&_nc_zt=23&_nc_ht=scontent.fsgn2-6.fna&_nc_gid=AAvBIuFVpzidZSFEjKwGK-c&oh=03_Q7cD1QHLh5C5wL26Hxludo53AtjFcKMo_Jm7H8SYBwFYIVxefg&oe=6749CE94"),
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
                      Navigator.pushNamed(context, WelcomeScreen.id);
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
