import 'package:flutter/material.dart';

import '../../core/models/posts.dart';
import '../../themes/colors.dart';

class ItemPost extends StatelessWidget {
  Posts posts = Posts();

  ItemPost({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  posts.imageUser,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts.nameUser,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    posts.time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                posts.content.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Image.network(posts.imagePost),
          const SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 5),
                  Text(posts.like.toString()),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Icon(Icons.comment, color: Colors.black),
                  const SizedBox(width: 5),
                  Text(posts.comment.toString()),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Icon(Icons.share, color: Colors.black),
                  const SizedBox(width: 5),
                  Text(posts.share.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 1,
            child: Container(
              color: AppColors.mainColor,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle,
                            color: Colors.lightGreen, size: 10),
                        const SizedBox(width: 5),
                        Text('26 ONLINE', style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Text('See all ', style: const TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        posts.imageUser,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Share your thoughts...',

                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13.0)),
                              borderSide: BorderSide(
                                  color: Color(0x00000000), width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13.0),
                                borderSide: BorderSide(
                                    color: Color(0x00000000), width: 3.0)),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),

                        ),
                      ),
                    ),
                    // textfield
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
