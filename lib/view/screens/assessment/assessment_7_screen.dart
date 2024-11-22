import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_8_screen.dart';

class Assessment7Screen extends StatefulWidget {
  static const String id = 'assessment_7_screen';

  const Assessment7Screen({super.key});

  @override
  State<Assessment7Screen> createState() => _Assessment7ScreenState();
}

class _Assessment7ScreenState extends State<Assessment7Screen> {
  final controller = TextEditingController();
  String currentDiet = 'Vegetarian';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "Vegetarian";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Text(
              'Assessment',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '7 of 15',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      "Current diet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM_0-Eqr-LovsiA9-DN57m_O0tde2CjsTrlw&s',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor, width: 2),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      maxLines: 5, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your current diet"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomButtonBlack(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  currentDiet = controller.text;
                  final assessment = Assessment();
                  assessment.currentDiet = currentDiet;
                  Navigator.pushNamed(context, Assessment8Screen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
