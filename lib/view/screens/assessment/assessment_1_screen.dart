import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';

class Assessment1Screen extends StatefulWidget {
  static const String id = 'assessment_1_screen';

  const Assessment1Screen({super.key});

  @override
  State<Assessment1Screen> createState() => _Assessment1ScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _Assessment1ScreenState extends State<Assessment1Screen> {
  int _selectedValue = 1;
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFE9E9E9),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                ),
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
                    '1 of 15',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "What's your fitness goal/target?",
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
          RadioListTile<SingingCharacter>(
            title: const Text('Lafayette'),
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            title: const Text('Thomas Jefferson'),
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          CustomRadioListTile(
            title: 'Lafayette',
            icon: Icons.access_alarm,
            isSelected: _selectedValue == 1,
            onTap: () {
              setState(() {
                _selectedValue = 1;
              });
            },
          ),

          CustomRadioListTile(
            title: 'Lafayette',
            icon: Icons.ac_unit_sharp,
            isSelected: _selectedValue == 0,
            onTap: () {
              setState(() {
                _selectedValue = 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomRadioListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final Function() onTap;

  const CustomRadioListTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainColor : Color(0xFFF3F3F4),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 24,
            ),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
