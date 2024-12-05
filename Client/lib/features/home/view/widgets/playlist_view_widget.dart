import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistViewWidget extends StatelessWidget{

  List<dynamic> Inplaylists;
  dynamic selectedPlaylist;
  dynamic userData;
  PlaylistViewWidget({super.key,required this.userData, required this.Inplaylists, required this.selectedPlaylist});

  @override
  Widget build(BuildContext context) {
    return Expanded(
              flex:4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        color: Color.fromARGB(200, selectedPlaylist.R.round(), selectedPlaylist.G.round(), selectedPlaylist.B.round()),
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
                                      child: Image(image: NetworkImage(selectedPlaylist.cover_pic)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Text(
                                  selectedPlaylist.name,
                                  style: const TextStyle(
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
                            color: const Color.fromARGB(7, 255, 255, 255),
                            child: 
                              Inplaylists.isEmpty
                              ? const SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(180.0,30,0,0),
                                  child: Text(
                                    'Empty Playlist',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ) 
                              : ListView.builder(
                                itemCount: Inplaylists.length,
                                itemBuilder: (context, index) {
                                final track = Inplaylists[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Consumer(builder: (context, ref, child) { 
                                    return ListTile(
                                    title: Text(track.track_name),
                                    leading: Image(image: NetworkImage(track.cover_art)),
                                    onTap: () {
                                      TrendModel stream = TrendModel(
                                        album_cover: track.cover_art, 
                                        album_name: '', 
                                        artist_name: '', 
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
                                      ref.read(currentStreamNotifierProvider.notifier).updateSong(stream);
                                      ref.read(currentStreamNotifierProvider.notifier).countStreams(userData.email, stream!.track_id);  
                                    },
                                    
                                  ); },),
                                );
                              })
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}