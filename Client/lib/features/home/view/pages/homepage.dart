import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/Artist/view/pages/artist_registration.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/Artist/view/pages/artist_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/providers/current_user_notifier.dart';



class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _Homepage();
}

class _Homepage extends ConsumerState<Homepage> {
  bool _showFields = false;
  dynamic userData;

  @override
  void initState() {
    super.initState();
    
    loadData();
  }

  Future<void> loadData() async {
    userData = await checkCreds();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('An error occurred.'),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to login page
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  child: const Text('Login Again'),
                )
              ],
            ),
          ),
        );
    }

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 2480, maxHeight: 1200),
          child: Column(
            children: [
              // Title bar and window controls inside a Stack
              Stack(
                children: [
                  SizedBox(
                    height: 53,
                    child: WindowTitleBarBox(
                      child: Container(
                        color: Pallete.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                userData.name,
                                style: const TextStyle(color: Pallete.whiteColor),
                              ),
                              const SizedBox(width: 8.0),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showFields = !_showFields;
                                  });
                                },
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 35.0,
                                    height: 35.0,
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      foregroundImage: NetworkImage(userData.image_url),
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
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(child: MoveWindow()), 
                ],
              ),
              
              //content area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
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
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: double.infinity,
                            color: const Color.fromARGB(7, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            IgnorePointer(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: double.infinity,
                                  color: const Color.fromARGB(7, 255, 255, 255),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: _showFields ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 150), 
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: SizedBox(
                                    height: 350.0,
                                    width: 350.0,
                                    child: Card(
                                      color: const Color.fromARGB(6, 0, 0, 0),
                                      shape: const RoundedRectangleBorder(),
                                      elevation: 5.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Options",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Pallete.whiteColor,
                                              ),
                                            ),
                                            const Divider(color: Pallete.borderColor),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtistRegistration()));
                                              },
                                              child: const Text(
                                                "Register as an Artist",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistProfilePage()));
                                              },
                                              child: const Text(
                                                "Artist Profile",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Handle logout
                                              },
                                              child: const Text(
                                                "Logout",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
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
