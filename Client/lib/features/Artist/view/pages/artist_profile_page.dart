import 'dart:io';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/album/view/pages/album_page.dart';
import 'package:client/features/Artist/view/widgets/artist_title_bar.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/album/view_model/album_viewmodel.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:client/features/Artist/view/widgets/textfield.dart';

class ArtistProfilePage extends ConsumerStatefulWidget {
  const ArtistProfilePage({super.key});

  @override
  ConsumerState<ArtistProfilePage> createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends ConsumerState<ArtistProfilePage> {
  dynamic artistData;
  List<dynamic> albums = []; 
  File? selectedImage;
  bool _showFields = true;
  dynamic albumName;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    artistData = await checkArtistCreds();
    setState(() {});
    if (artistData != null && artistData.artist_name != null) {
      loadAlbums();
    }
    
  }

  

Future<void> loadAlbums() async {
  //print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final response = await ref.read(albumViewmodelProvider.notifier).getAllAlbumData(artistName: artistData.artist_name);

  if (response is AsyncData<List<AlbumModel>>) {
    setState(() {
      albums = response.value;
      //print("Albums: ${albums}");
    });
  } else if (response is AsyncError) {
    showSnackBar(context, 'Failed to load albums: ${response?.error}', Pallete.errorColor);
  } else {
    showSnackBar(context, 'Unexpected response format.', Pallete.errorColor);
  }
}




  void _toggleVisibility() {
    setState(() {
      _showFields = !_showFields;
    });
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      albumViewmodelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(context, 'Album created.', Pallete.greenColor);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlbumPage(albumName: albumName,)),
            );
          },
          error: (error, st) {
            showSnackBar(context, error.toString(), Pallete.errorColor);
          },
          loading: () {},
        );
      },
    );

    if (artistData == null) {
      print("ArtisData is now null");
    
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
          child: Column(
            children: [
              ArtistTitleBar(url: artistData.image_url),
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
                                    artistData.image_url,
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
                                        top: containerHeight * 0.7,
                                        child: Text(artistData.artist_name, style: TextStyle(fontSize: 50, color: Colors.white),))
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                // Left side of the page (display albums)
                                Expanded(
                                  flex: 2,
                                  
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
                                                : SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.52, // Set a fixed height or wrap in a Flexible
                                                    child: ListView.builder(
                                                      itemCount: albums.length,
                                                      itemBuilder: (context, index) {
                                                        final album = albums[index];
                                                        return ListTile(
                                                          title: Text(album.name),
                                                          subtitle: Text('Price: \$${album.price}'),
                                                          leading: Image.network(album.cover_art),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  
                                ),


                                // Right side of the page (upload album)
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible: _showFields,
                                    replacement: Column(
                                      children: [
                                        const SizedBox(height: 15,),
                                        GestureDetector(
                                                onTap: () {
                                                  selectImage();
                                                },
                                                child: Card(
                                                    elevation: 0,
                                                    color: Colors.white, 
                                                    child: SizedBox(
                                                      width: 100,   
                                                      height: 100,  
                                                      child:  ClipRect(
                                                          child: Center(
                                                            child: selectedImage != null
                                                                ? Image.file(
                                                                    selectedImage!,
                                                                    fit: BoxFit.cover,
                                                                  )
                                                                : const Icon(
                                                                    Icons.add,
                                                                    color: Color.fromARGB(255, 97, 96, 96),
                                                                  ),
                                                          ),
                                                        ),
                                                    ),
                                                  ),
                                              ),
                                        
                                         
                                        Textfield(controller: nameController, labelText: "Album Name"),
                                        const SizedBox(height: 15,),
                                        Textfield(controller: priceController, labelText: "Set Price"),
                                        const SizedBox(height: 15,),
                                        ElevatedButton(
                                          onPressed: () async {
                                            String? cover_art;
                                            if (selectedImage != null) {
                                              cover_art = await uploadImage(selectedImage);
                                            }
                                            await ref.read(albumViewmodelProvider.notifier).addAlbum(
                                              name: nameController.text,
                                              price: priceController.text,
                                              cover_art: cover_art ?? '',
                                              artist_name: artistData.artist_name,
                                            );
                                            setState(() {
                                              albumName = nameController.text;
                                              loadAlbums();
                                            });
                                          },
                                          child: const Text("Upload"),
                                        ),
                                        const SizedBox(height: 15,),
                                        ElevatedButton(
                                          onPressed: _toggleVisibility,
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 15,),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  _toggleVisibility();
                                                },
                                                child: Card(
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                        color: Color.fromARGB(255, 97, 96, 96),  
                                                        width: 2,             
                                                      ),
                                                      borderRadius: BorderRadius.circular(8), 
                                                    ),
                                                    color: Colors.transparent, 
                                                    child: const SizedBox(
                                                      width: 100,   
                                                      height: 100,  
                                                      child: Center(
                                                        child: Icon(Icons.add), 
                                                      ),
                                                    ),
                                                  ),
                                              ),
                                                  
                                              
                                              const SizedBox(width: 25,),
                                              const Text("Add an album", style: TextStyle(fontSize: 20,color: Colors.white)),
                                            ],
                                          ),
                                        
                                        
                                      ],
                                    ),
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
    );
  }
}
