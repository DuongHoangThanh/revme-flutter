import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const CustomPageView(
      {super.key,
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              image
             ),
              fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 8),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 16),
              Text(description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
              const SizedBox(height: 140),

            ],
          ),
        ),
      ),
    );
  }
}
