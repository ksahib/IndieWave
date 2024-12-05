import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/core/providers/rgb_provider.dart';
import 'package:client/features/home/view/pages/album_view.dart';
import 'package:client/features/home/view/pages/artist_page.dart';
import 'package:client/features/home/view/widgets/album_display_widget.dart';
import 'package:client/features/home/view/widgets/artist_display_widget.dart';
import 'package:client/features/home/view/widgets/list_cards.dart';
import 'package:client/features/home/view/widgets/pointed_rectangle_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


class MainFeed extends ConsumerWidget{
  final dynamic artistTrendList;
  final dynamic userData;
  final dynamic trackTrendList;
  final dynamic bannerData;
  dynamic url;
  double r = 99.0, g = 102.0, b = 106.0;
  MainFeed({super.key, required this.artistTrendList, required this.userData, required this.trackTrendList, required this.bannerData});

  Future<void> getRGB(WidgetRef ref, String image_url) async {
  try {
    final uri = Uri.parse('${ServerConstant.serverUrl}/getAvgRGB');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'image-url': image_url,
      },
    );
    final res = jsonDecode(response.body) as Map<String, dynamic>;
    final newColor = Color.fromARGB(
      100,
      res['data']['R'].toInt(),
      res['data']['G'].toInt(),
      res['data']['B'].toInt(),
    );
    ref.read(rgbProvider.notifier).state = newColor; // Update the provider
  } catch (e) {
    print(e);
  }
}


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = ref.watch(rgbProvider);
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
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  backgroundColor, 
                                  Colors.black,
                                ],
                              ),
                            ),
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
                                              child: Image(image: NetworkImage(bannerData.cover_art)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 70,),
                                              const Text(
                                                "Check Out \nThe Latest Release.",
                                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white),
                                              ),
                                              Text(
                                                bannerData.name,
                                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white)
                                              ),
                                              Text(
                                                bannerData.artist_name,
                                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: Colors.white)
                                              ),
                                            ],
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
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[1].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[1].album_name, artist: trackTrendList[1])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[1].album_cover,
                                                title: trackTrendList[1].album_name,
                                                height: bannerContainerHeight,
                                                width: constraints.maxWidth,
                                              ),
                                            ),
                                          ),

                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[9].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[9].album_name, artist: trackTrendList[9])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[9].album_cover, 
                                                title: trackTrendList[9].album_name, 
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
                                          ),
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[10].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[10].album_name, artist: trackTrendList[10])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[10].album_cover, 
                                                title: trackTrendList[10].album_name,
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
                                          ),
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[4].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[4].album_name, artist: trackTrendList[4])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[4].album_cover, 
                                                title: trackTrendList[4].album_name,
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
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
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[5].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[5].album_name, artist: trackTrendList[5])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[5].album_cover, 
                                                title: trackTrendList[5].album_name, 
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
                                          ),
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[6].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[6].album_name, artist: trackTrendList[6])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[6].album_cover, 
                                                title: trackTrendList[6].album_name, 
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
                                          ),
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[7].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[7].album_name, artist: trackTrendList[7])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[7].album_cover, 
                                                title: trackTrendList[7].album_name, 
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
                                          ),
                                          MouseRegion(
                                            onEnter: (event) async {
                                              await getRGB(ref, trackTrendList[8].album_cover); // Pass ref to update the provider
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: trackTrendList[8].album_name, artist: trackTrendList[8])));
                                              },
                                              child: ListCards(
                                                url: trackTrendList[8].album_cover, 
                                                title: trackTrendList[8].album_name, 
                                                height: bannerContainerHeight, 
                                                width: constraints.maxWidth
                                              ),
                                            ),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ArtistPage(artistData: artist)));
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
                                          try{
                                            ref.read(currentStreamNotifierProvider.notifier).stop();
                                          } catch($e) {
                                            print($e);
                                          }
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