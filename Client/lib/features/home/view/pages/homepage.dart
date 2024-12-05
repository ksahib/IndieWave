import 'dart:io';

import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/pages/artist_registration.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/Artist/view/pages/artist_profile_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/models/playlist_model.dart';
import 'package:client/features/home/models/queue_model.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/repositories/playlist_remote_repository.dart';
import 'package:client/features/home/view/widgets/main_feed.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:client/features/home/view/widgets/now_playing.dart';
import 'package:client/features/home/view/widgets/playlist_view_widget.dart';
import 'package:client/features/home/view/widgets/user_titlebar.dart';
import 'package:client/features/home/viewmodels/banner_viewmodel.dart';
import 'package:client/features/home/viewmodels/playlist_viewmodel.dart';
import 'package:client/features/home/viewmodels/queue_viewmodel.dart';
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
  List<dynamic> playlists = [];
  List<dynamic> Inplaylists = [];
  bool _default = true;
  dynamic banner;
  dynamic selectedPlaylist;
  final TextEditingController nameController = TextEditingController();
  File? selectedImage;

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
    if (userData != null) {
      loadPlaylists();
    }
  }

  Future<void> loadTrends() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final artistResponse = await ref.read(trendViewmodelProvider.notifier).getAllTrendData(type: 'artist');
  final trackResponse = await ref.read(trendViewmodelProvider.notifier).getAllTrendData(type: 'track');
  final bannerResponse = await ref.read(bannerViewmodelProvider.notifier).banner(userData.email);

  if (artistResponse is AsyncData<List<TrendModel>> && trackResponse is AsyncData<List<TrendModel>>) {
    setState(() {
      artistTrendList = artistResponse.value;
      trackTrendList = trackResponse.value;
      banner = bannerResponse;
      // print("Artists: ${artistTrendList}");
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

Future<void> loadPlaylists() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final response = await ref.read(playlistViewmodelProvider.notifier).getAllPlaylistData(email: userData.email);

  if (response is AsyncData<List<PlaylistModel>>) {
    setState(() {
      playlists = response.value;
      print("Tracks: ${playlists}");
    });
  } else if (response is AsyncError) {
    showSnackBar(context, 'Failed to load tracks: ${response?.error}', Pallete.errorColor);
  } else {
    showSnackBar(context, 'Unexpected response format.', Pallete.errorColor);
  }
}

  void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

Future<void> loadPlaylistsTracks(String playlistid) async {
  final response = await ref.read(queueViewmodelProvider.notifier).getInPlaylistkData(playlistid: playlistid);

  if (response is AsyncData<List<QueueModel>>) {
    setState(() {
      Inplaylists = response.value;
      print("Tracks: ${playlists}");
    });
  } else if (response is AsyncError) {
    setState(() {
      Inplaylists = [];
    });
    showSnackBar(context, 'Failed to load tracks: ${response?.error}', Pallete.errorColor);
  } else {
    setState(() {
      Inplaylists = [];
    });
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
                                                          Stack(
                                                            children: [
                                                              selectedImage != null
                                                                  ? Center(
                                                                      child: SizedBox(
                                                                        height: 150,
                                                                        width: 140,
                                                                        child: Image.file(
                                                                          selectedImage!,
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(
                                                                      height: 200, 
                                                                      width: 400,
                                                                    ),
                                                              Center(
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    selectImage();
                                                                    setState(() {
                                                                      
                                                                    });
                                                                  },
                                                                  child: Card(
                                                                    elevation: 10,
                                                                    shadowColor: const Color.fromARGB(255, 51, 51, 51),
                                                                    color: const Color.fromARGB(25, 255, 255, 255),
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                    ),
                                                                    child: const SizedBox(
                                                                      width: 150,
                                                                      height: 140,
                                                                      child: Icon(
                                                                        Icons.add,
                                                                        size: 50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                                          const SizedBox(height: 15),
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              // calling create playlist api
                                                              String? imageUrl = await uploadImage(selectedImage); 
                                                              await ref.read(playlistViewmodelProvider.notifier).addPlaylist(name: nameController.text, cover_pic: imageUrl!, email: userData.email);
                                                              setDialogState(() {},);
                                                              loadPlaylists();
                                                              Navigator.pop(context);
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
                                    const SizedBox(height: 20,),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.52,
                                      child: ListView.builder(
                                        itemCount: playlists.length,
                                        itemBuilder: (context, index) {
                                          final playlist =  playlists[index];
                                          return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                                              child: ListTile(
                                                title: Text(playlist.name),
                                                leading:Image(image: NetworkImage(playlist.cover_pic)),
                                                trailing: IconButton(
                                                  onPressed: () async {
                                                    //implement delete here
                                                    await ref.read(playlistViewmodelProvider.notifier).removePlaylist(playlist_id: playlist.playlist_id);
                                                    setState(() { playlists.removeAt(index);});
                                                    loadPlaylists();
                                                  }, 
                                                  icon: Icon(CupertinoIcons.delete, color: Colors.red,),
                                                ), 
                                                onTap: () async {
                                                  setState(() {
                                                    selectedPlaylist = playlist;
                                                    _default = !_default;
                                                  });
                                                  await loadPlaylistsTracks(playlist.playlist_id);
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          //Middle: Main feed
                          if(_default)
                          MainFeed(
                            artistTrendList: artistTrendList, 
                            userData: userData, 
                            trackTrendList: trackTrendList,
                            bannerData: banner,
                          ),
                          if(!_default)
                          PlaylistViewWidget(Inplaylists: Inplaylists, selectedPlaylist: selectedPlaylist, userData: userData,),
                          const SizedBox(width: 5),
                          //right: Now Playing
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                NowPlaying(playlists: playlists,),
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
                                                            "Choose a picture.",
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                color: Colors.white),
                                                          ),
                                                          Stack(
                                                            children: [
                                                              selectedImage != null
                                                                  ? Center(
                                                                      child: SizedBox(
                                                                        height: 150,
                                                                        width: 140,
                                                                        child: Image.file(
                                                                          selectedImage!,
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(
                                                                      height: 200, // Ensures tap area is properly defined
                                                                      width: 400,
                                                                    ),
                                                              Center(
                                                                child: GestureDetector(
                                                                  onTap: () {
                                                                    selectImage();
                                                                    setState(() {
                                                                      
                                                                    });
                                                                  },
                                                                  child: const Card(
                                                                    elevation: 10,
                                                                    shadowColor: Color.fromARGB(255, 51, 51, 51),
                                                                    color: Color.fromARGB(25, 255, 255, 255),
                                                                    shape: CircleBorder(),
                                                                    child: SizedBox(
                                                                      width: 150,
                                                                      height: 140,
                                                                      child: Icon(
                                                                        Icons.add,
                                                                        size: 50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 15),
                                                          ElevatedButton(
                                                            onPressed: () async {
                                                              // calling create playlist api
                                                              String? imageUrl = await uploadImage(selectedImage); 
                                                              await ref.read(authViewmodelProvider.notifier).changeDp(email: userData.email, image_url: imageUrl!);
                                                              Navigator.pop(context);
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
                                                              "Upload",
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
                                                  child: const Text(
                                                    "Change Profile Picture",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    ref.read(authViewmodelProvider.notifier).logoutUser();
                                                    ref.read(currentStreamNotifierProvider.notifier).stop();
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

