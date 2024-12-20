import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/providers/follow_status_provider.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/viewmodels/queue_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class NowPlaying extends ConsumerWidget{
  List<dynamic> playlists;
  NowPlaying({super.key, required this.playlists});

Future<void> fetchFollowStatus(WidgetRef ref, String email, String artist) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/FollowStatus');
      print("Sending request to $uri with email=$email and artist-name=$artist");
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'email': email,
          'artist-name': artist,
        },
      );

      print("Response: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 200) {
        ref.read(followStatusProvider.notifier).state = true; 
      } else if (response.statusCode == 404) {
        ref.read(followStatusProvider.notifier).state = false; 
      } else {
        print("Unexpected error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Request failed: $e");
      ref.read(followStatusProvider.notifier).state = false; 
    }

}

Future<void> unfollow(WidgetRef ref, String email, String artist) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Unfollow');
      print("Sending request to $uri with email=$email and artist-name=$artist");
      
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'email': email,
          'artist-name': artist,
        },
      );
      ref.read(followStatusProvider.notifier).state =
          !ref.read(followStatusProvider); 
      print("Response: ${response.statusCode}, Body: ${response.body}");

      
    } catch (e) {
      print("Request failed: $e");
    }

}

Future<void> follow(WidgetRef ref, String email, String artist) async {
  try {
      await http.post(
        Uri.parse('${ServerConstant.serverUrl}/Follow'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "artist_name": artist}),
      );
      ref.read(followStatusProvider.notifier).state =
          !ref.read(followStatusProvider); 
    } catch (e) {
      print("Failed to follow: $e");
    }
}


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStream = ref.watch(currentStreamNotifierProvider);
    final currentUser = ref.read(currentUserNotifierProvider);
    final followStatus = ref.watch(followStatusProvider);
     
    if(currentStream == null || currentUser == null) {
      return const SizedBox();
    } 

     WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchFollowStatus(ref, currentUser.email, currentStream.artist_name);
    });

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 2400),
        child: SizedBox(
          height: 1400,
          child: Column(
                  children: [
                    Expanded(
                      flex:2,
                      child: SizedBox( 
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10,20,0,0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text(
                                currentStream.album_name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(image: NetworkImage(currentStream.album_cover)),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    currentStream.track_name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                       showDialog(
                                        context: context,
                                         builder: (BuildContext context){
                                           return AlertDialog(
                                            title: Text('Add to Playlist'),
                                            content: Column(
                                              children: [
                                                SizedBox(
                                                  height: 300,
                                                  width: 300,
                                                  child: ListView.builder(
                                                    itemCount: playlists.length,
                                                    itemBuilder: (context, index) {
                                                      final playlist = playlists[index];
                                                      return ListTile(
                                                        title: Text(playlist.name),
                                                        onTap: () async {
                                                          //add to playlist logic
                                                          await ref.read(queueViewmodelProvider.notifier).addToQueue(track_id: currentStream.track_id, playlist_id: playlist.playlist_id);
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context); // Close dialog
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                       );
                                    }, 
                                    icon: Icon(CupertinoIcons.add_circled)
                                  ),
                                ],
                              ),
                              //const SizedBox(height: 10,),
                              Text(
                                currentStream.artist_name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Pallete.subtitleText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), 
                    ),
                    Expanded(
                      flex:1,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 500, maxHeight: 1000),
                          child: SizedBox(
                            child: Column(
                              children: [
                                
                                  Card(
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                          "About",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Pallete.subtitleText,
                                            ),
                                          ),
                                          const SizedBox(height: 10,),
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(currentStream.profile_pic),
                                          ),
                                          const SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${currentStream.followers} followers",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Pallete.subtitleText,
                                                  ),
                                              ),
                                              if(!followStatus)
                                              ElevatedButton(onPressed: () {
                                                follow(ref, currentUser.email, currentStream.artist_name);
                                              },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color.fromARGB(7, 255, 255, 255),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(25),
                                                    side: const BorderSide(color: Colors.white, width: 0.5),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Follow",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Pallete.subtitleText,
                                                    ),
                                                  ), 
                                              ),
                                              if(followStatus)
                                              ElevatedButton(onPressed: () {
                                                unfollow(ref, currentUser.email, currentStream.artist_name);
                                              },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Pallete.whiteColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(25),
                                                    
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Following",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Pallete.subtitleText,
                                                    ),
                                                  ), 
                                              ),
                                            ],
                                            
                                          ),
                                          Text(
                                            currentStream.about,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Pallete.subtitleText,
                                              ),
                                          ),
                                        ],
                                      ),
                                    ),
                          
                                  ),  
                              ],
                            ),
                          ),
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