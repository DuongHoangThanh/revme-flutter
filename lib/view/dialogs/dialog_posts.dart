import 'package:flutter/material.dart';

import '../../themes/colors.dart';

class DialogPosts {
  void showPostSuccess(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 350,

            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),

                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Post Successful!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'You have successfully posted a post.\n Let\'s see now.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 69,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'See my post!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                )
              ],
            ),
          ),
        );
      },
    );
  }
}