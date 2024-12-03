import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/pages/artist_registration.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/Artist/view/pages/artist_profile_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/repositories/playlist_remote_repository.dart';
import 'package:client/features/home/view/widgets/main_feed.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:client/features/home/view/widgets/now_playing.dart';
import 'package:client/features/home/view/widgets/user_titlebar.dart';
import 'package:client/features/home/viewmodels/banner_viewmodel.dart';
import 'package:client/features/home/viewmodels/playlist_viewmodel.dart';
import 'package:client/features/home/viewmodels/trend_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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
  final tracks = [];
  dynamic banner;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    loadData();
    loadTrends();
  }

  Future<void> loadData() async {
    userData = await checkCreds();
    print(userData);
    setState(() {});
  }

  Future<void> loadTrends() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final artistResponse = await ref.read(trendViewmodelProvider.notifier).getAllTrendData(type: 'artist');
  final trackResponse = await ref.read(trendViewmodelProvider.notifier).getAllTrendData(type: 'track');
  final bannerResponse = await ref.read(bannerViewmodelProvider.notifier).banner(userData.email);
  // File? selectedImage;

  // void selectImage() async {
    
  // }

  if (artistResponse is AsyncData<List<TrendModel>> && trackResponse is AsyncData<List<TrendModel>>) {
    setState(() {
      artistTrendList = artistResponse.value;
      trackTrendList = trackResponse.value;
      banner = bannerResponse;
      // print("Artists: ${artistTrendList}");
      // print("Tracks: ${trackTrendList}");
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
      return const LoginPage();
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
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: double.infinity,
                                    color: const Color.fromARGB(7, 255, 255, 255),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.music_albums,
                                        ),
                                        const SizedBox(width: 10,),
                                        const Text(
                                          "Your Library",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.06),
                                        Align(
                                          alignment: Alignment.topRight,
                                          //add playlist
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setDialogState) {
                                                      return AlertDialog(
                                                    contentPadding:
                                                        const EdgeInsets.all(20),
                                                    backgroundColor: Colors.grey[900],
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                    ),
                                                    content: SizedBox(
                                                      width: 300,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const Text(
                                                            "Add New Playlist",
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                color: Colors.white),
                                                          ),
                                                          const SizedBox(height: 20),
                                                          
                                                          
                                                          const SizedBox(height: 20),
                                                          TextField(
                                                            controller: nameController,
                                                            decoration: InputDecoration(
                                                              labelText: "Track Name",
                                                              labelStyle: TextStyle(
                                                                  color:
                                                                      Colors.grey[400]),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey[700]!),
                                                              ),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Pallete
                                                                        .greenColor),
                                                              ),
                                                            ),
                                                            style: const TextStyle(
                                                                color: Colors.white),
                                                          ),
                                                          const SizedBox(height: 15),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              // Handle file picker logic here
                                                              selectImage();
                                                              setDialogState(() {
                                                                
                                                              },);
                                                              
                                                              
                                                              
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Pallete.greenColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(20),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "Pick a File",
                                                              style: TextStyle(
                                                                  color: Colors.black),
                                                            ),
                                                          ),
                                                          const SizedBox(height: 15),
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              // call create playlist api
                                                              await ref.read(playlistViewmodelProvider.notifier).addPlaylist(name: nameController.text, cover_pic: 'default', email: userData.email);
                                                              setDialogState(() {
                                                                
                                                              },);
                                                              
                                                              
                                                              
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  Pallete.greenColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(20),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              "Create",
                                                              style: TextStyle(
                                                                  color: Colors.black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                    },
                                                  );
                                                },
                                              );
                                            }, 
                                            icon: const Icon(CupertinoIcons.add)
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          //Middle: Main feed
                          // MainFeed(
                          //   artistTrendList: artistTrendList, 
                          //   userData: userData, 
                          //   trackTrendList: trackTrendList,
                          //   bannerData: banner,
                          // ),
                          Expanded(
                            flex:4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.blue,
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Card(
                                                  elevation: 10,
                                                  child: SizedBox(
                                                    height: 170,
                                                    width: 170,
                                                    child: Container(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20,),
                                              Text(
                                                "Your Playlist",
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: SingleChildScrollView(
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(maxHeight: 1200),
                                        child: Container(
                                          color: Colors.amber,
                                          child: ListView.builder(
                                            itemCount: tracks.length,
                                            itemBuilder: (context, index) {
                                            final track = tracks[index];
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: ListTile(
                                                title: Text(track.name),
                                                
                                              ),
                                            );
                                          })
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                                  onPressed: () async {
                                                    ref.read(authViewmodelProvider.notifier).logoutUser();
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
  File? selectedImage;
  
  void selectImage() async {
    final pickedImage = await pickImage();
    if(pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
    await Future.delayed(Duration(milliseconds: 200));
    if (selectedImage != null) {
      //await player.play(DeviceFileSource(selectedAudio!.path));
    }
  }
}
