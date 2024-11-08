import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:rev_me_app/themes/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF3F3F4),
        labelText: hintText,
        labelStyle: TextStyle(color: Colors.grey[900]),
        contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        hintStyle: const TextStyle(
          color: Color(0xFF393C43),
        ),
        prefixIcon:prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(19.0)),
          borderSide: BorderSide(color: Color(0x00000000), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(19.0),
            borderSide: BorderSide(color: AppColors.mainColor.withOpacity(0.6), width:3.0)),
      ),
    );
  }
}
