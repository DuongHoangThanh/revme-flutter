import 'package:flutter/material.dart';
import 'package:rev_me_app/view/screens/feed/add_new_post_screen.dart';

import '../../../core/models/posts.dart';
import '../../../themes/colors.dart';
import '../../widgets/item_post.dart';

class YourFeedScreen extends StatefulWidget {
  const YourFeedScreen({super.key});

  @override
  State<YourFeedScreen> createState() => _YourFeedScreenState();
}

class _YourFeedScreenState extends State<YourFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 165,
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chanh',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.file_copy,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '25 posts',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '25 likes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Center(
                              child: Icon(
                                Icons.notifications_active_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text(
                        "Browse by",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ItemWorkoutCategory(
                        icon: 'assets/ic_cardio.png',
                        title: 'Workout',
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getPosts().length,
                  itemBuilder: (context, index) {
                    var posts = getPosts();

                    return ItemPost(posts: posts[index]);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child:GestureDetector(
                onTap: () {
                  // Navigate to the verify screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewPostScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add New Post",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(width: 12),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),

              ),
            ),

        ],
      ),

    );
  }

  List<Posts> getPosts() {
    List<Posts> posts = [];
    posts.add(Posts(
      id: 3,
      nameUser: 'Clara Wong',
      imageUser:
          'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-xinh-xan.jpg?1704788263223',
      time: '3 days ago',
      content: 'I tried a new recipe today! 🍲',
      imagePost:
          'https://media1.giphy.com/media/DNawUXi2yzD5SvbZdc/giphy.gif?cid=6c09b952dazgase0p93ltvzao8vw76e3ymnssqwyl6wfbd00&ep=v1_internal_gif_by_id&rid=giphy.gif&ct=g',
      like: 200,
      comment: 45,
      share: 12,
    ));

    posts.add(Posts(
      id: 3,
      nameUser: 'Shiba Inu',
      imageUser:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr4xVV2ZWFpV-aqm8s_i7M00wnWMOafx6RXw&s',
      time: '3 days ago',
      content: 'My new gym routine! 💪',
      imagePost:
          'https://file.hstatic.net/1000394081/article/phong-tap-gym_2a431b8cf4fb4e178830e93126979ce7.jpg',
      like: 2000000,
      comment: 4500,
      share: 12000,
    ));
    posts.add(Posts(
      id: 5,
      nameUser: 'Clara Wong',
      imageUser:
          'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-doi-lot-soi.jpg?1704788224743',
      time: '10 hours ago',
      content: 'Good morning! ☀️',
      imagePost:
          'https://cdn.shopify.com/s/files/1/0430/6533/files/OzQvwVeWEiOYq8VxemYHLNGyA2Sx3OJ91614347671.jpg?v=1614787195',
      like: 200,
      comment: 45,
      share: 12,
    ));
    posts.add(Posts(
      id: 3,
      nameUser: 'Officer Jenny',
      imageUser:
          'https://otos.vn/wp-content/uploads/2024/09/anh-avatar-vo-tri-2.jpg',
      time: '3 days ago',
      content: 'My new gym routine! 💪',
      imagePost:
          'https://file.hstatic.net/1000394081/article/phong-tap-gym_2a431b8cf4fb4e178830e93126979ce7.jpg',
      like: 100,
      comment: 4500,
      share: 60,
    ));
    return posts;
  }
}

class ItemWorkoutCategory extends StatelessWidget {
  String icon = '';
  String title = '';

  ItemWorkoutCategory({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 48,
      width: 150,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(12),

      ),
      child: Row(
        children: [
         ImageIcon(
            AssetImage(icon),
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
