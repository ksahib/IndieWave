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
  File? selectedImage;
  bool _showFields = true;
  void _toggleVisibility() {
  setState(() {
    _showFields = !_showFields;
  });
}

void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

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
    //formKey.currentState!.validate();
  }

  Future<void> loadData() async {
    artistData = await checkArtistCreds();
    print(artistData);
    setState(() {});
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
                                  const SizedBox(width: 5,),
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
                                const SizedBox(width: 10,),
                                Text(artistData.artist_name),
                                ],
                              ),
                            ),
                            // Center the buttons
                            Expanded(
                              child: Positioned(
                                left: MediaQuery.of(context).size.width/2,
                                child: Row(
                                  
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        // Your action here
                                      },
                                      child: const Text(
                                        'Home',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // Your action here
                                      },
                                      child: const Text(
                                        'Music',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // Your action here
                                      },
                                      child: const Text(
                                        'Profile',
                                        style: TextStyle(color: Pallete.whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Right-aligned icon buttons
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0,0,5,0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Minimize(),
                                  Maximize(),
                                  Close()
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
                            height: containerHeight
                            );

                            return SizedBox(
                              height: containerHeight,
                              width: containerWidth,
                              child: Image(image: NetworkImage(resizedUrl)),
                            );
                        }
                        ),
                      ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          // Left side of the page (display songs)
                            Expanded(
                              flex: 2,
                              child: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: MediaQuery.of(context).size.height, // Ensure it takes the full available height
                                  ),
                                  child: Container(
                                    width: double.infinity, // Take the maximum available width
                                    color: const Color.fromARGB(7, 255, 255, 255),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0,0,0),
                                      child: Column(
                                        children: [
                                          //dummy content:
                                          for (int i = 0; i < 50; i++) 
                                            ListTile(
                                              title: Text('Song ${i + 1}'),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          
                          // Right side of the page (upload song)
                          Expanded(
                            flex: 1,
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: const Color.fromARGB(7, 255, 255, 255),
                                      
                                    ),

                                      Visibility(
                                        visible: _showFields,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: MediaQuery.of(context).size.height/5,
                                              left: 40,
                                              child: Row(
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
                                            
                                                  const Text("Add an album", style: TextStyle(fontSize: 20,color: Colors.white),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Visibility(
                                        visible: !_showFields,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: MediaQuery.of(context).size.height / 5,
                                              left: 40,
                                              child: Column(
                                                children: [
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
                                                        child: ClipRect(
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
                                                  const SizedBox(height: 15,),
                                                  Container(width: 330,child: Textfield(controller: nameController, labelText: 'Album Name')),
                                                  const SizedBox(height: 15,),
                                                  Container(width: 330,child: Textfield(controller: priceController, labelText: 'Set Price')),
                                                  const SizedBox(height: 15,),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      String? cover_art;
                                                      if (selectedImage != null) {
                                                        cover_art = await uploadImage(selectedImage);
                                                      }
                                                      print("cover art: ${cover_art}");
                                                      await ref.read(authViewmodelProvider.notifier).addAlbum(
                                                        name: nameController.text, 
                                                        price: priceController.text, 
                                                        cover_art: cover_art ?? '', 
                                                        artist_name: artistData.artist_name,
                                                        );
                                                    }, 
                                                    child: Text("Upload", style: TextStyle(color: Color.fromARGB(255, 97, 96, 96),),))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}