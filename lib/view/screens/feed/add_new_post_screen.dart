import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:rev_me_app/viewmodels/post_viewmodel.dart';

import '../../../themes/colors.dart';
import '../../dialogs/dialog_posts.dart';

class AddNewPostScreen extends StatefulWidget {
  const AddNewPostScreen({super.key});

  @override
  State<AddNewPostScreen> createState() => _AddNewPostScreenState();
}

class _AddNewPostScreenState extends State<AddNewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PostViewModel(),
        child: Consumer<PostViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.arrow_back_sharp,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Post Community',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Post Content",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 300,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xffF3F3F4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://thegioidotap.vn/wp-content/uploads/2020/12/195.jpg',
                                      height: 55,
                                      width: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Chanh',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(8),
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    TextField(
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'What are you thinking?',
                                      ),

                                    ),
                                    viewModel.selectedImage != null
                                        ? Image.file(
                                      viewModel.selectedImage!,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                        : Text("No image selected"),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 120,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 8),
                                            GestureDetector(
                                              onTap: () {
                                                viewModel.pickImageFromCamera();
                                              },
                                              child: Icon(
                                                IconlyLight.camera,
                                                color: Colors.black,
                                                size: 24,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              IconlyLight.voice,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            GestureDetector(
                                              onTap: () {
                                                viewModel.pickImageFromGallery();
                                                print("AAA");
                                              },
                                              child: Icon(
                                                IconlyLight.image,
                                                color: Colors.black,
                                                size: 24,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Post Type",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
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
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hide from community?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("This post will be private",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.mainColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      DialogPosts().showPostSuccess(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(
                            IconlyLight.send,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
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
