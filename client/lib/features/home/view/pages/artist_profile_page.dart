import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/view/widgets/Button_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ArtistProfilePage extends ConsumerStatefulWidget{
  const ArtistProfilePage({super.key});

  @override
  ConsumerState<ArtistProfilePage> createState() => _ArtistProfilePageState();
}
class _ArtistProfilePageState extends ConsumerState<ArtistProfilePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints( maxHeight: 1200),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        
                        //title bar.
                        SizedBox(
                          height: 70,
                          child: WindowTitleBarBox(
                            child: Container(
                              color: Pallete.backgroundColor,
                              child: Row(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(500, 0, 380, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              //await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                                            },
                                            child: const Text('Home',
                                                style: TextStyle(
                                                  color: Pallete.whiteColor)),
                                          ),
                                                              
                                          TextButton(
                                            onPressed: () async {
                                              //await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                                            },
                                            child: const Text('Music',
                                                style: TextStyle(
                                                  color: Pallete.whiteColor)),
                                          ),
                                                              
                                          TextButton(
                                            onPressed: () async {
                                              //await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage()));
                                            },
                                            child: const Text('Profile',
                                                style: TextStyle(
                                                  color: Pallete.whiteColor)),
                                          ),
                                                              
                                        ],
                                      ),
                                    ),
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
                        Positioned.fill(child: MoveWindow()),
                      ],
                    ),
                    Expanded(
                        child: Row(
                              children: [
                                //left side of the page.(display songs)
                                Expanded(
                                  flex: 2,                              
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: const Color.fromARGB(7, 255, 255, 255),
                                  ), 
                                ),
                                //right side of the page.(upload song)
                                    Expanded(
                                      flex: 1,                              
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: const Color.fromARGB(7, 255, 255, 255),
                                          ),
                                          ButtonIcon(iconData: Icons.add, onPressed: () {}),
                                        ],
                                      ), 
                                    ),
                                  
                              ],
                          ),
                            
                    ),
                  ],
                ),
              ),
            ),
      );
    }
}
