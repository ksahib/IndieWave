import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';
import 'package:flutter/material.dart';

class ArtistTitleBar extends StatelessWidget{
  final String url;
  const ArtistTitleBar({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    return Stack(
                children: [
                  // Title bar.
                  SizedBox(
                    height: 70,
                    child: WindowTitleBarBox(
                      child: Container(
                        color: Pallete.backgroundColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  ClipOval(
                                    child: SizedBox(
                                      width: 35.0,
                                      height: 35.0,
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        foregroundImage: NetworkImage(url),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, 
                                    icon: const Icon(Icons.arrow_back_ios),
                                    ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, 
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        
                                      },
                                      child: const Text(
                                        'Home',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        
                                      },
                                      child: const Text(
                                        'Music',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        
                                      },
                                      child: const Text(
                                        'Profile',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Minimize(),
                                  Maximize(),
                                  Close(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(child: MoveWindow()),
                ],
              );
    
  }
}