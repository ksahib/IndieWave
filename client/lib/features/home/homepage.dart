import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
          return Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 2480, maxHeight: 1200),
                child: Column(
                  children: [
                    SizedBox(
                      height: 53,
                      child: WindowTitleBarBox(
                        child: Container(
                          color: Pallete.backgroundColor,
                          child: Row(
                            children: [
                              Expanded(
                                child: MoveWindow(),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.minimize_outlined,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                onPressed: appWindow.minimize,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.crop_square,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                onPressed: appWindow.isMaximized ? appWindow.restore : appWindow.maximize,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                onPressed: appWindow.close,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 5,),
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: double.infinity,
                                  color: const Color.fromARGB(7, 255, 255, 255),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: double.infinity,
                                  color:  Color.fromARGB(7, 255, 255, 255),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: double.infinity,
                                  color: const Color.fromARGB(7, 255, 255, 255),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            

          );
    
  }
  
}