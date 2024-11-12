import 'package:flutter/material.dart';
import 'package:rev_me_app/core/models/avatar.dart';
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
                itemCount: getAvatar().length,
                itemBuilder: (context, index) {
                  var avatars = getAvatar();
                  var avatar = avatars[index];
                  return ItemAvatar(avatar: avatar);
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
  List<Avatar> getAvatar(){
    List<Avatar> avatar = [];
    avatar.add(Avatar(

      name: 'Clara Wong',
      image: 'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-xinh-xan.jpg?1704788263223',
    ));
    avatar.add(Avatar(

      name: 'Shiba Inu',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr4xVV2ZWFpV-aqm8s_i7M00wnWMOafx6RXw&s',
    ));
    avatar.add(Avatar(

      name: 'Clara Wong',
      image: 'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-doi-lot-soi.jpg?1704788224743',
    ));
    avatar.add(Avatar(

      name: 'Officer Jenny',
      image: 'https://otos.vn/wp-content/uploads/2024/09/anh-avatar-vo-tri-2.jpg',
    ));
    avatar.add(Avatar(

      name: 'Shiba Inu',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr4xVV2ZWFpV-aqm8s_i7M00wnWMOafx6RXw&s',
    ));
    avatar.add(Avatar(

      name: 'Clara Wong',
      image: 'https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-doi-lot-soi.jpg?1704788224743',
    ));
    avatar.add(Avatar(

      name: 'Officer Jenny',
      image: 'https://otos.vn/wp-content/uploads/2024/09/anh-avatar-vo-tri-2.jpg',
    ));


    return avatar;
  }
}

class ItemAvatar extends StatelessWidget {
  final Avatar avatar;

  const ItemAvatar({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:  DecorationImage(
                image: NetworkImage(avatar.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
           Text(avatar.name),
        ],
      ),
    );
  }
}
