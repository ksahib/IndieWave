import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/pages/artist_registration.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/Artist/view/pages/artist_profile_page.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/view/widgets/main_feed.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:client/features/home/view/widgets/now_playing.dart';
import 'package:client/features/home/view/widgets/user_titlebar.dart';
import 'package:client/features/home/viewmodels/trend_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _Homepage();
}

class _Homepage extends ConsumerState<Homepage> {
  bool _showFields = false;
  dynamic userData;
  List<dynamic> artistTrendList = [];
  List<dynamic> trackTrendList = [];


  @override
  void initState() {
    super.initState();
    
    loadData();
    loadTrends();
  }

  Future<void> loadData() async {
    userData = await checkCreds();
    setState(() {});
  }

  Future<void> loadTrends() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final artistResponse = await ref.read(trendViewmodelProvider.notifier).getAllTrendData(type: 'artist');
  final trackResponse = await ref.read(trendViewmodelProvider.notifier).getAllTrendData(type: 'track');
  

  if (artistResponse is AsyncData<List<TrendModel>> && trackResponse is AsyncData<List<TrendModel>>) {
    setState(() {
      artistTrendList = artistResponse.value;
      trackTrendList = trackResponse.value;
      print("Artists: ${artistTrendList}");
      print("Tracks: ${trackTrendList}");
    });
  } else if (artistResponse is AsyncError) {
    showSnackBar(context, 'Failed to load tracks: ${artistResponse?.error}', Pallete.errorColor);
  } else if (trackResponse is AsyncError) {
    showSnackBar(context, 'Failed to load tracks: ${trackResponse?.error}', Pallete.errorColor);
  } else {
    showSnackBar(context, 'Unexpected response format.', Pallete.errorColor);
  }
}

  @override
  Widget build(BuildContext context) {
    if (userData == null) {
      return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('An error occurred.'),
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
          constraints: const BoxConstraints(minWidth: 2480, maxHeight: 1400),
          child: Stack(
            children: [
              Column(
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
                          //Middle: Main feed
                          MainFeed(
                            artistTrendList: artistTrendList, 
                            userData: userData, 
                            trackTrendList: trackTrendList
                          ),
                          const SizedBox(width: 5),
                          //right: Now Playing
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                
                                NowPlaying(),
                                IgnorePointer(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      height: double.infinity,
                                      color: const Color.fromARGB(7, 255, 255, 255),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _showFields,
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
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtistProfilePage()));
                                                  },
                                                  child: const Text(
                                                    "Artist Profile",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Handle logout
                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
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
              Positioned(
                bottom: 0,
                child: MusicSlab()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
