import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final IconData? iconData;
  final VoidCallback onPressed;
  const ButtonIcon({super.key, required this.iconData, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.whiteColor, 
        minimumSize: Size(screenWidth * 0.8, 50), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child:
          Icon(iconData, color: Pallete.greyColor),
    );
  }
}
