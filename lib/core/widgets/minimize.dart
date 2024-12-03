import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class Minimize extends StatelessWidget{
  const Minimize({super.key});
  @override
   Widget build(BuildContext context) {
  return IconButton(
           icon: const Icon(
             Icons.minimize_outlined,
             color: Colors.white,
             size: 15.0,
           ),
           onPressed: appWindow.minimize,
         );
   } 
}