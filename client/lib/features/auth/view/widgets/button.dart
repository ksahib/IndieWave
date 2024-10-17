import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  const Button({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
              backgroundColor: Pallete.greenColor,  // Similar to the reference
              minimumSize: Size(screenWidth * 0.8, 50),  // Make button responsive
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
      
    ), 
    child: Text(text, style: TextStyle(fontSize: 18, color: Pallete.whiteColor)),
    );
  }
}