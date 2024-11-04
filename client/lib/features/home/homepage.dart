import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(color: Colors.red,)
              

            )
        );
    
  }
  
}