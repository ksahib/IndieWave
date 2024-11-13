import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class Close extends StatelessWidget {
  const Close({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
           icon: const Icon(
             Icons.close,
             color: Colors.white,
             size: 15.0,
           ),
           onPressed: appWindow.close,
         );
  }
}