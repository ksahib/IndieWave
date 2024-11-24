import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/Artist/view/pages/artist_registration.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/Artist/view/pages/artist_profile_page.dart';
import 'package:client/features/home/view/widgets/album_display_widget.dart';
import 'package:client/features/home/view/widgets/artist_display_widget.dart';
import 'package:client/features/home/view/widgets/list_cards.dart';
import 'package:client/features/home/view/widgets/pointed_rectangle_clipper.dart';
import 'package:client/features/home/view/widgets/user_titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              // Title bar and window controls
              UserTitlebar(
                url: userData.image_url, 
                name: userData.name, 
                onTap: () {
                  setState(() {
                  _showFields = !_showFields;
                }); 
                }
              ),
              
              //content area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      //left: Playlists and Libraries
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
                      //Middle: Main feed
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 1200),
                              child: Column(
                                children: [
                                  Container(
                                    height: 1200,
                                    color: const Color.fromARGB(7, 255, 255, 255),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final bannerContainerHeight = constraints.maxHeight * 0.5;
                                        return Column(
                                          children: [
                                            Container(
                                              height: bannerContainerHeight,
                                              width: constraints.maxWidth,
                                              color: Colors.red,
                                              child: Column(
                                                children: [
                                                  //BANNER
                                                  SizedBox(
                                                    height: bannerContainerHeight * 0.5,
                                                    width: constraints.maxWidth,
                                                    child: ClipPath(
                                                      clipper: PointedRectangleClipper(),
                                                      child: Card(
                                                        elevation: 10,
                                                        color: Color.fromARGB(200, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            ClipRect(
                                                              child: Container(
                                                                width: 200,
                                                                height: 200,
                                                                child: Image(image: NetworkImage(userData.image_url)),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                "Check Out The Latest Release.",
                                                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white)
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      //left side list tiles
                                                      SizedBox(
                                                        height: bannerContainerHeight * 0.5,
                                                        width: constraints.maxWidth * 0.5,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: bannerContainerHeight * 0.005,
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 1", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 2", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 3", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 4", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            
                                                          ],
                                                        ),
                                                      ),
                                                      //right side list tiles
                                                      SizedBox(
                                                        height: bannerContainerHeight * 0.5,
                                                        width: constraints.maxWidth * 0.5,
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: bannerContainerHeight * 0.005,
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 5", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 6", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 7", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                            ListCards(
                                                              url: userData.image_url, 
                                                              title: "album 8", 
                                                              height: bannerContainerHeight, 
                                                              width: constraints.maxWidth
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            //Rising artists section
                                            SizedBox(
                                              height: bannerContainerHeight * 0.5,
                                              width: constraints.maxWidth,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10,),
                                                      const Text(
                                                        "Rising Artists.",
                                                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10,),
                                                     ArtistDisplayWidget(url: userData.image_url, name: "Artist", height: bannerContainerHeight),
                                                      const SizedBox(width: 10,),
                                                      ArtistDisplayWidget(url: userData.image_url, name: "Artist", height: bannerContainerHeight),
                                                      const SizedBox(width: 10,),
                                                      ArtistDisplayWidget(url: userData.image_url, name: "Artist", height: bannerContainerHeight),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            //TOp albums section
                                            SizedBox(
                                              height: bannerContainerHeight * 0.5,
                                              width: constraints.maxWidth,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10,),
                                                      const Text(
                                                        "Top Albums.",
                                                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const SizedBox(width: 10,),
                                                      AlbumDisplayWidget(url: userData.image_url, album: "album", artist: "artist", height: bannerContainerHeight),
                                                      const SizedBox(width: 10,),
                                                      AlbumDisplayWidget(url: userData.image_url, album: "album", artist: "artist", height: bannerContainerHeight),
                                                      const SizedBox(width: 10,),
                                                      AlbumDisplayWidget(url: userData.image_url, album: "album", artist: "artist", height: bannerContainerHeight),
                                                      const SizedBox(width: 10,),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      //right: Now Playing
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
