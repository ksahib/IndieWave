import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Textfield extends StatelessWidget{
final TextEditingController controller;
final Text labelText;

const Textfield({super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
      return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "${labelText}",
        filled: false,
        border: OutlineInputBorder(),
      ),
    );
  }
}