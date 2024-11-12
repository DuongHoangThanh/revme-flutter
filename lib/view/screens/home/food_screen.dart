import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food Screen'),
        ),
        body: Stack(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ));
  }
}
