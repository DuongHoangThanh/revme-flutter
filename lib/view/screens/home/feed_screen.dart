import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/posts.dart';
import 'package:rev_me_app/view/widgets/item_post.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Friends',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [

                ImageIcon(
                  AssetImage('assets/ic_verify.png'),
                  color: Colors.black,
                  size: 30,
                ),
                const SizedBox(width: 4),
                ImageIcon(
                  AssetImage('assets/ic_notification.png'),
                  color: Colors.black,
                  size: 30,
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage('assets/img_chess_press.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Username')
                      ],
                    ),
                  );
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                var posts = Posts(
                  id: 3,
                  nameUser: 'Clara Wong',
                  imageUser: 'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-xinh-xan.jpg?1704788263223',
                  time: '3 days ago',
                  content: 'Just baked some delicious cookies! 🍪',
                  imagePost: 'https://medlatec.vn/media/12977/content/20201116_huong-dan-bai-tap-gym-chi-tiet-cho-nam-moi-tap.jpg',
                  like: 200,
                  comment: 45,
                  share: 12,
                );
                return ItemPost(posts: posts);
              },
            ),
          ],
        ),
      ),
    );
  }
}
