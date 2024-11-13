
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class Maximize extends StatelessWidget{
  const Maximize({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
           icon: const Icon(
             Icons.crop_square,
             color: Colors.white,
             size: 15.0,
           ),
           onPressed: appWindow.isMaximized
               ? appWindow.restore
               : appWindow.maximize,
         );
  }
}