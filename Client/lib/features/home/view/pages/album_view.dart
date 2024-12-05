import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/features/album/model/genre_model.dart';
import 'package:client/features/album/model/track_model.dart';
import 'package:client/features/album/view_model/genre_viewmodel.dart';
import 'package:client/features/album/view_model/track_viewmodel.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/view/widgets/music_slab.dart';
import 'package:client/features/home/view/widgets/user_titlebar.dart';
import 'package:waveform_flutter/waveform_flutter.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/widgets/artist_title_bar.dart';
import 'package:client/features/album/view_model/album_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumView extends ConsumerStatefulWidget {
  final String albumName;
  final artist;
  AlbumView({super.key, required this.albumName, required this.artist});

  @override
  ConsumerState<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends ConsumerState<AlbumView> {
  dynamic userData;
  dynamic albumData;
  double dpBottom = 0;
  bool isReleased = false;
  bool isLoading = false;
  List<dynamic> tracks = [];
  late final AudioPlayer player;


  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadData() async {
    userData = await checkCreds();
    print("IN ALBUM: ${userData}");
    setState(() {});
    if (userData != null) {
      loadCurrentAlbum();
    }
  }

  Future<void> _checkReleaseStatus() async {
    setState(() {
      isLoading = true;
    });

    final result = await ref.read(albumViewmodelProvider.notifier).checkRelease(albumData.album_id);

    setState(() {
      isReleased = result;
      isLoading = false;
    });
  }

  Future<void> loadCurrentAlbum() async {
    final container = ProviderContainer();
    //print("artisName: ${artistData.artist_name} AND albumName : ${widget.albumName}");
    albumData = await container
        .read(albumViewmodelProvider.notifier)
        .getAlbum(widget.artist.artist_name, widget.albumName);
    print("Album Data: $albumData");
    loadTracks();
    _checkReleaseStatus();
    setState(() {}); 
  }

  Future<void> loadTracks() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final response = await ref.read(trackViewmodelProvider.notifier).getAllTrackData(albumid: albumData.album_id);

  if (response is AsyncData<List<TrackModel>>) {
    setState(() {
      tracks = response.value;
      print("Tracks: ${tracks}");
    });
  } else if (response is AsyncError) {
    showSnackBar(context, 'Failed to load tracks: ${response?.error}', Pallete.errorColor);
  } else {
    showSnackBar(context, 'Unexpected response format.', Pallete.errorColor);
  }
}


  @override
  Widget build(BuildContext context) {
    if (userData == null || albumData == null) {
    
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 1200),
          child: Stack(
            children: [
              Column(
                children: [
                  UserTitlebar(url: userData.image_url, name: userData.name, onTap: () {}),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double topContainerHeight = constraints.maxHeight * 0.4;
                        dpBottom = topContainerHeight - 180; 
              
                        return Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: topContainerHeight,
                                  color: Colors.amber,
                                  child: Image.network(
                                    albumData.cover_art,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.black,
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.52, // Set a fixed height or wrap in a Flexible
                                      child: ListView.builder(
                                        itemCount: tracks.length,
                                        itemBuilder: (context, index) {
                                          final track = tracks[index];
                                          
                                          //stream.copyWith(album_cover: albumData.cover_art, album_name: widget.albumName, artist_name: widget.artist.artist_name, track_id: track.track_id, track_name: track.track_name, track_url: track.track_url);
                                          // Map<String, dynamic> stream = {
                                          //   'album_cover': albumData.cover_art,
                                          //   'album_name': widget.albumName,
                                          //   'artist_name': widget.artist.artist_name,
                                          //   'track_name': track.track_name,
                                          //   'track_id': track.track_id,
                                          //   'track_url': track.track_url
                                          // };
                                          return Column(
                                            children: [
                                              if(index==0)
                                              SizedBox(
                                                height: dpBottom,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                                child: ListTile(
                                                  title: Text(track.track_name),
                                                  onTap: () {
                                                    TrendModel stream = TrendModel(
                                                      album_cover: albumData.cover_art, 
                                                      album_name: widget.albumName, 
                                                      artist_name: widget.artist.artist_name, 
                                                      track_id: track.track_id, 
                                                      track_name: track.track_name, 
                                                      track_url: track.track_url,
                                                      about: '',
                                                      likes: 0,
                                                      followers: 0,
                                                      streams: 0,
                                                      album_id: '',
                                                      profile_pic: ''
                                                    );
                                                    print('stream');
                                                    print(stream);
                                                    ref.read(currentStreamNotifierProvider.notifier).updateSong(stream);
                                                    ref.read(currentStreamNotifierProvider.notifier).countStreams(userData.email, stream!.track_id);
                                                  },
                                                  
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 30,
                              top: topContainerHeight - 75,
                              child: Row(
                                children: [
                                  Card(
                                    elevation: 10,
                                    child: SizedBox(
                                      width: 170,
                                      height: 170,
                                      child: ClipRect(
                                        child: Image.network(
                                          albumData.cover_art,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        albumData.name,
                                        style: const TextStyle(
                                            fontSize: 50, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 23,
                                      ),
                                      //uncomment if add to library button needs to be implemented
                                      // ElevatedButton(
                                      //   //call the delete function for release table with a ternary operator for on pressed.
                                      //   onPressed: isReleased
                                      //   ? () async {
                                      //     await ref.read(albumViewmodelProvider.notifier).Unrelease(album_id: albumData.album_id);
                                      //     _checkReleaseStatus();
                                      //   }
                                      //   : () async {
                                      //     await ref.read(albumViewmodelProvider.notifier).release(artist_name: artistData.artist_name, album_id: albumData.album_id);
                                      //     _checkReleaseStatus();
                                      //   },
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor: Pallete.greenColor,
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(25),
                                      //     ),
                                      //   ),
                                      //   child: Row(
                                      //     children: [
                                      //       if(isReleased)
                                      //         Icon(Icons.check, color: Colors.black),
                                      //       if(isReleased)
                                      //         const SizedBox(width: 5),
                                      //       Text(
                                      //         isReleased ? "Added to library" : "Add to Library",
                                      //         style: TextStyle(color: Colors.black),
                                      //       ),
                                      //       if(isReleased)
                                      //         const SizedBox(width: 10),
                                      //     ],
                                      //   ),
                                      // ),
                                      
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
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
