import 'dart:io';
import 'package:client/core/providers/current_artistview_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/album/view/pages/album_page.dart';
import 'package:client/features/Artist/view/widgets/artist_title_bar.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/album/view_model/album_viewmodel.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/album_view.dart';
import 'package:client/features/home/view/widgets/user_titlebar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:client/features/Artist/view/widgets/textfield.dart';

class ArtistPage extends ConsumerStatefulWidget {
  dynamic artistData;
  ArtistPage({super.key, required this.artistData});

  @override
  ConsumerState<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends ConsumerState<ArtistPage> {
  dynamic userData;
  List<dynamic> albums = []; 
  File? selectedImage;
  dynamic albumName;

  @override
  void initState() {
    super.initState();
    loadData();
    loadAlbums();
  }

  Future<void> loadData() async {
    userData = await checkCreds();
    setState(() {});
  }


Future<void> loadAlbums() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final response = await ref.read(currentArtistViewNotifierProvider.notifier).getAllReleasedAlbum(widget.artistData.artist_name);
  setState(() {
      albums = response;
      //print("Albums: ${albums}");
    });
  
}

 
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider.select((val) => val?.isLoading == true));
  //   if (artistData. == null) {
  //     print("ArtisData is now null");
    
  //   return const Scaffold(
  //     body: Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 1200),
          child: Column(
            children: [
              UserTitlebar(url: userData.image_url, name: userData.name, onTap: () {}),
              Expanded(
                child: isLoading
                    ? const Loader()
                    : Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double containerWidth = constraints.maxWidth;
                                double containerHeight = constraints.maxHeight;

                                String resizedUrl = resizeImage(
                                    widget.artistData.profile_pic,
                                    width: containerWidth,
                                    height: containerHeight);

                                return SizedBox(
                                  height: containerHeight,
                                  width: containerWidth,
                                  child: Stack(
                                    children: [
                                      
                                      Image.network(
                                        resizedUrl,
                                        fit: BoxFit.cover,
                                        width: containerWidth,
                                        height: containerHeight,
                                      ),
                                     
                                      Container(
                                        width: containerWidth,
                                        height: containerHeight,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.05),  
                                              Colors.black,
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned( 
                                        left: containerWidth * 0.02,
                                        top: containerHeight * 0.5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(widget.artistData.artist_name, style: TextStyle(fontSize: 50, color: Colors.white),),
                                            Text("${widget.artistData.followers} followers", style: TextStyle(fontSize: 20, color: Pallete.subtitleText),),
                                          ],
                                        ))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight:400, maxHeight: 1600),
                                child: Column(
                                  children: [
                                    // Left side of the page (display albums)
                                    Expanded(
                                      flex: 1,
                                      
                                        child: Container(
                                          width: double.infinity,
                                          color: const Color.fromARGB(7, 255, 255, 255),
                                          child: Column(
                                            
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Releases:',
                                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                child: albums.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                          'No Albums Available',
                                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                                        ),
                                                      )
                                                    : Column(
                                                      children: [
                                                        SizedBox(
                                                            height: MediaQuery.of(context).size.height * 0.3, // Set a fixed height or wrap in a Flexible
                                                            child: ListView.builder(
                                                              itemCount: albums.length,
                                                              itemBuilder: (context, index) {
                                                                final album = albums[index];
                                                                return ListTile(
                                                                  title: Text(album.name),
                                                                  leading: Image.network(album.cover_art),
                                                                  onTap: () {
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: album.name, artist: widget.artistData,)));
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(height: 50,),
                                                                Padding(
                                                                  padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      const Text(
                                                                      "About",
                                                                      style: const TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Pallete.subtitleText,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(height: 10,),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "${widget.artistData.followers} followers",
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Pallete.subtitleText,
                                                                              ),
                                                                          ),
                                                                          // if(!followStatus)
                                                                          // ElevatedButton(onPressed: () {
                                                                          //   follow(ref, currentUser.email, currentStream.artist_name);
                                                                          // },
                                                                          //   style: ElevatedButton.styleFrom(
                                                                          //     backgroundColor: const Color.fromARGB(7, 255, 255, 255),
                                                                          //     shape: RoundedRectangleBorder(
                                                                          //       borderRadius: BorderRadius.circular(25),
                                                                          //       side: BorderSide(color: Colors.white, width: 0.5),
                                                                          //     ),
                                                                          //   ),
                                                                          //   child: const Text(
                                                                          //     "Follow",
                                                                          //     style: const TextStyle(
                                                                          //       fontSize: 14,
                                                                          //       fontWeight: FontWeight.w400,
                                                                          //       color: Pallete.subtitleText,
                                                                          //       ),
                                                                          //     ), 
                                                                          // ),
                                                                          // if(followStatus)
                                                                          // ElevatedButton(onPressed: () {
                                                                          //   unfollow(ref, currentUser.email, currentStream.artist_name);
                                                                          // },
                                                                          //   style: ElevatedButton.styleFrom(
                                                                          //     backgroundColor: Pallete.whiteColor,
                                                                          //     shape: RoundedRectangleBorder(
                                                                          //       borderRadius: BorderRadius.circular(25),
                                                                                
                                                                          //     ),
                                                                          //   ),
                                                                          //   child: const Text(
                                                                          //     "Following",
                                                                          //     style: const TextStyle(
                                                                          //       fontSize: 14,
                                                                          //       fontWeight: FontWeight.w400,
                                                                          //       color: Pallete.subtitleText,
                                                                          //       ),
                                                                          //     ), 
                                                                          // ),
                                                                        ],
                                                                        
                                                                      ),
                                                                      Text(
                                                                        widget.artistData.about,
                                                                        style: const TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Pallete.subtitleText,
                                                                          ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                      ],
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
                        ],
                      ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
