

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';
import 'package:flutter/material.dart';

class UserTitlebar extends StatelessWidget{
  final String url;
  final String name;
  final VoidCallback onTap;
  const UserTitlebar({super.key, required this.url, required this.name, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 53,
          child: WindowTitleBarBox(
            child: Container(
              color: Pallete.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            icon: const Icon(Icons.arrow_back_ios),
                            ),
                          IconButton(
                            onPressed: () {
                              //Navigator.pop(context);
                            }, 
                            icon: const Icon(Icons.arrow_forward_ios),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: onTap,
                          child: ClipOval(
                            child: SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: CircleAvatar(
                                radius: 20.0,
                                foregroundImage: NetworkImage(url),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        const Minimize(),
                        const Maximize(),
                        const Close(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(child: MoveWindow()), 
      ],
    );
  }

}