import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final bool isObscure;
  const CustomTextField({super.key, required this.hintText, this.labelText, required this.controller, this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  SizedBox(
      width: 0.7 * screenWidth,
      height: 0.09* screenHeight,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
        obscureText: isObscure,
        validator: (val) {
          if (val == null || val.trim().isEmpty) {
            return 'Please enter your $hintText';
          }
          else {
            return null;
          }
        },
      ),
    );
  }
}