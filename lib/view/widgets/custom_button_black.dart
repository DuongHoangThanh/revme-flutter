import 'package:flutter/material.dart';

class CustomButtonBlack extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final IconData? icon;

  const CustomButtonBlack(
      {super.key, required this.label, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            if (icon != null) const SizedBox(width: 10),
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: 24 ,
              ),
          ],
        ),
      ),
    );
  }
}
