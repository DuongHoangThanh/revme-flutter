import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';
import '../../../core/models/assessment.dart';
import '../../widgets/custom_button_black.dart';
import 'assessment_14_screen.dart';

class Assessment13Screen extends StatefulWidget {
  static const String id = 'assessment_13_screen';

  const Assessment13Screen({super.key});

  @override
  State<Assessment13Screen> createState() => _Assessment13ScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _Assessment13ScreenState extends State<Assessment13Screen> {
  int _currentValue = 3;
  String sleepQuality = 'Good';
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
                  '13 of 15',
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
                      "What’s your sleep quality like?",
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
              CustomRadio(
                value: 1,
                text: 'Poor',
                icon: 'https://static.thenounproject.com/png/1740167-200.png',
                groupValue: _currentValue,
                subText: '3-4 hours',
                onChanged: (value) {
                  setState(() {
                    _currentValue = value!;
                    sleepQuality = 'Poor';
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 2,
                text: 'Average',
                icon: 'https://cdn.icon-icons.com/icons2/3395/PNG/512/none_smile_icon_214074.png',
                groupValue: _currentValue,
                subText: '5-6 hours',
                onChanged: (value) {
                  setState(() {
                    _currentValue = value!;
                    sleepQuality = 'Average';
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              CustomRadio(
                value: 3,
                text: 'Good',
                icon: 'https://cdn-icons-png.flaticon.com/512/747/747402.png',
                groupValue: _currentValue,
                subText: '7-8 hours',
                onChanged: (value) {
                  setState(() {
                    _currentValue = value!;
                    sleepQuality = 'Good';
                  });
                },
              ),
              SizedBox(
                height: 60,
              ),
              CustomButtonBlack(
                label: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: () {
                  final assessment = Assessment();
                  assessment.sleepQuality = sleepQuality;
                  Navigator.pushNamed(context, Assessment14Screen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final int value;
  final String text;
  final int groupValue;
  final String icon;
  final String subText;

  final Function(int?)? onChanged;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.text,
    required this.icon,
    required this.groupValue,
    required this.subText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null && value != groupValue) {
          onChanged!(value); // Trigger onChanged with the selected value
        }
      },
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: value == groupValue ? AppColors.mainColor : Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: value == groupValue
                ? AppColors.mainColor.withOpacity(0.8)
                : Colors.transparent,
            width: 5,

          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    ImageIcon(
                      NetworkImage(icon,),
                      color: value == groupValue ? Colors.white : Color(0xFF393C43),
                      size: 40,

                    ),
                    SizedBox(width: 12),
                    Text(
                      text.toString(),
                      style: TextStyle(
                        color:
                        value == groupValue ? Colors.white : Color(0xFF393C43),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                     Icons.timer_outlined,
                      color: value == groupValue ? Colors.white : Color(0xFF393C43),
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      subText.toString(),
                      style: TextStyle(
                        color:
                        value == groupValue ? Colors.white : Color(0xFF393C43),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
