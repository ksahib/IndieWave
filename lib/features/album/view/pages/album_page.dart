import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:client/features/album/model/genre_model.dart';
import 'package:client/features/album/model/track_model.dart';
import 'package:client/features/album/view_model/genre_viewmodel.dart';
import 'package:client/features/album/view_model/track_viewmodel.dart';
import 'package:waveform_flutter/waveform_flutter.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/widgets/artist_title_bar.dart';
import 'package:client/features/album/view_model/album_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumPage extends ConsumerStatefulWidget {
  final String albumName;
  AlbumPage({super.key, required this.albumName});

  @override
  ConsumerState<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends ConsumerState<AlbumPage> {
  dynamic artistData;
  dynamic albumData;
  String? selectedGenre; // For dropdown selection
  File? selectedAudio;
  double dpBottom = 0;
  bool isReleased = false;
  bool isLoading = false;
  List<dynamic> tracks = [];
  late final AudioPlayer player;

  final TextEditingController nameController = TextEditingController();


  List<GenreModel> genres = [];

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadData() async {
    artistData = await checkArtistCreds();
    print("IN ALBUM: ${artistData}");
    setState(() {});
    if (artistData != null) {
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

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if(pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
    await Future.delayed(Duration(milliseconds: 200));
    if (selectedAudio != null) {
      await player.play(DeviceFileSource(selectedAudio!.path));
    }
  }

  Future<void> loadCurrentAlbum() async {
    final container = ProviderContainer();
    print("artisName: ${artistData.artist_name} AND albumName : ${widget.albumName}");
    albumData = await container
        .read(albumViewmodelProvider.notifier)
        .getAlbum(artistData.artist_name, widget.albumName);
    print("Album Data: $albumData");
    loadTracks();
    loadGenre();
    _checkReleaseStatus();
    setState(() {}); // Update UI after fetching album data
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

Future<void> loadGenre() async {
  final response = await ref.read(genreViewmodelProvider.notifier).getAllGenre();
  if (response is AsyncData<List<GenreModel>>) {
    setState(() {
      genres = response.value;
      print("Genres: ${tracks}");
    });
  } else if (response is AsyncError) {
    showSnackBar(context, 'Failed to load tracks: ${response?.error}', Pallete.errorColor);
  } else {
    showSnackBar(context, 'Unexpected response format.', Pallete.errorColor);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 1200),
          child: Column(
            children: [
              ArtistTitleBar(url: artistData.image_url),
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
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: dpBottom,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                            child: ListTile(
                                              title: Text(track.track_name),
                                              
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
                                  ElevatedButton(
                                    //call the delete function for release table with a ternary operator for on pressed.
                                    onPressed: isReleased
                                    ? () async {
                                      await ref.read(albumViewmodelProvider.notifier).Unrelease(album_id: albumData.album_id);
                                      _checkReleaseStatus();
                                    }
                                    : () async {
                                      await ref.read(albumViewmodelProvider.notifier).release(artist_name: artistData.artist_name, album_id: albumData.album_id);
                                      _checkReleaseStatus();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Pallete.greenColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        if(isReleased)
                                          Icon(Icons.check, color: Colors.black),
                                        if(isReleased)
                                          const SizedBox(width: 5),
                                        Text(
                                          isReleased ? "Published" : "Publish",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        if(isReleased)
                                          const SizedBox(width: 10),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
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
                                                    "Add Tracks",
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  
                                                  if(selectedAudio != null)
                                                    GestureDetector(
                                                      onTap: () {
                                                        player.pause();
                                                      },
                                                      child: Waveform(
                                                        amplitudeStream: createRandomAmplitudeStream(),
                                                      ),
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
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //Genre Field
                                                      const Text(
                                                        "Genre",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      DropdownButtonFormField<
                                                          String>(
                                                        value: selectedGenre,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Select Genre",
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .grey[400]),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey[700]!),
                                                          ),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Pallete
                                                                        .greenColor),
                                                          ),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedGenre =
                                                                value;
                                                          });
                                                        },
                                                        dropdownColor:
                                                            Colors.grey[900],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: genres
                                                            .map((genre) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: genre.tag,
                                                                  child: Text(
                                                                      genre.tag),
                                                                ))
                                                            .toList(),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Handle file picker logic here
                                                      selectAudio();
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
                                                  //Upload Track Button
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      // Handle track addition logic here
                                                      await ref.read(trackViewmodelProvider.notifier).uploadTrack(
                                                        name: nameController.text, 
                                                        tag: selectedGenre, 
                                                        track_url: await uploadTrack(selectedAudio), 
                                                        album_id: albumData.album_id);
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
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
                                                      "Upload Track",
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Pallete.greenColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: const Text("Add Tracks",
                                        style: TextStyle(color: Colors.black)),
                                  ),
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
        ),
      ),
    );
  }
}
