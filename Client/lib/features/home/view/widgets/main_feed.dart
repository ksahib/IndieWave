import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/features/home/view/widgets/album_display_widget.dart';
import 'package:client/features/home/view/widgets/artist_display_widget.dart';
import 'package:client/features/home/view/widgets/list_cards.dart';
import 'package:client/features/home/view/widgets/pointed_rectangle_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MainFeed extends ConsumerWidget{
  final dynamic artistTrendList;
  final dynamic userData;
  final dynamic trackTrendList;
  MainFeed({super.key, required this.artistTrendList, required this.userData, required this.trackTrendList});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return 
    Expanded(
      flex: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 1400),
            child: Column(
              children: [
                Container(
                  height: 1400,
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
                                const Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text(
                                      "Rising Artists.",
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: artistTrendList.length,
                                    itemBuilder: (context, index) {
                                      final artist = artistTrendList[index];
                                      return GestureDetector(
                                        onTap: () {
                                        },
                                        child: Row(
                                          children: [
                                            ArtistDisplayWidget(url: artist.profile_pic, name: artist.artist_name, height: bannerContainerHeight),
                                            const SizedBox(width: 15,)
                                          ],
                                        ),
                                      );
                                    }
                                  ),
                                ),    
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
                                const Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text(
                                      "Top Songs.",
                                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30, color: Colors.white),
                                    ),
                                  ],
                                ),   
                                Flexible(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: trackTrendList.length,
                                    itemBuilder: (context, index) {
                                      final track = trackTrendList[index];
                                      return GestureDetector(
                                        onTap: () {
                                          ref.read(currentStreamNotifierProvider.notifier).updateSong(track);
                                          ref.read(currentStreamNotifierProvider.notifier).countStreams(userData.email, track.track_id);
                                        },
                                        child: Row(
                                          children: [
                                            AlbumDisplayWidget(url: track.album_cover, album: track.track_name, artist: track.artist_name, height: bannerContainerHeight),
                                            const SizedBox(width: 15,)
                                          ],
                                        ));
                                    }
                                  ),
                                ),
                                    
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
    );
  }
  
}