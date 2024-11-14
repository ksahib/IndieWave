import 'dart:io';
import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/pages/album_page.dart';
import 'package:client/features/Artist/view/widgets/Button_icon.dart';
import 'package:client/features/auth/model/album_model.dart';
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
    print(artistData);
    setState(() {});
    if (artistData != null && artistData.artist_name != null) {
    loadAlbums();
  }
  }

 Future<void> loadAlbums() async {
   print("Calling loadAlbums with artistName: ${artistData?.artist_name}");
  final response = await ref.read(authViewmodelProvider.notifier).getAllAlbumData(artistName: artistData.artist_name);
  print("response: ${response}");

  if (response == null) {
    showSnackBar(context, 'Failed to load albums.', Pallete.errorColor);
  } else if (response is List) {
    setState(() {
      albums = response as List<AlbumModel>;
      print("albums: ${albums}");
    });
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
      authViewmodelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showSnackBar(context, 'Account created successfully.', Pallete.greenColor);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AlbumPage()),
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
              Stack(
                children: [
                  // Title bar.
                  SizedBox(
                    height: 70,
                    child: WindowTitleBarBox(
                      child: Container(
                        color: Pallete.backgroundColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  ClipOval(
                                    child: SizedBox(
                                      width: 35.0,
                                      height: 35.0,
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        foregroundImage: NetworkImage(artistData.image_url),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(artistData.artist_name),
                                ],
                              ),
                            ),
                            Expanded(
                              
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        
                                      },
                                      child: const Text(
                                        'Home',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        
                                      },
                                      child: const Text(
                                        'Music',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        
                                      },
                                      child: const Text(
                                        'Profile',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Minimize(),
                                  Maximize(),
                                  Close(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(child: MoveWindow()),
                ],
              ),
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
                                            child: Column(
                                              children: albums.isEmpty
                                                  ? const [Center(child: Text('No Albums Available'))]
                                                  : albums.map((album) {
                                                      return ListTile(
                                                        title: Text(album.name),
                                                        subtitle: Text('Price: \$${album.price}'),
                                                        leading: Image.network(album.cover_art),
                                                      );
                                                    }).toList(),
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
                                        if (selectedImage != null)
                                         
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
                                            await ref.read(authViewmodelProvider.notifier).addAlbum(
                                              name: nameController.text,
                                              price: priceController.text,
                                              cover_art: cover_art ?? '',
                                              artist_name: artistData.artist_name,
                                            );
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
