import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view_model/artist_auth_viewmodel.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/button.dart';
import 'package:client/features/auth/view/widgets/custom_text_field.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class ArtistRegistration extends ConsumerStatefulWidget {
  const ArtistRegistration({super.key});

  @override
  ConsumerState<ArtistRegistration> createState() => _ArtistRegistrationState();
}

class _ArtistRegistrationState extends ConsumerState<ArtistRegistration> {
  final nameController = TextEditingController();
  final aboutController = TextEditingController();
  File? selectedImage;
  dynamic userData;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    userData = await checkCreds();
    setState(() {});
  }

  void selectImage() async{
    final pickedImage = await pickImage();
    if(pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    super.dispose();
    //formKey.currentState!.validate();
  }

 @override
Widget build(BuildContext context) {
  final isLoading = ref.watch(authViewmodelProvider.select((val) => val?.isLoading == true));
  print(userData);
  
  ref.listen(
    authViewmodelProvider,
    (_, next) {
      next?.when(
        data: (data) {
          showSnackBar(context, 'Account created successfully.', Pallete.greenColor);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Homepage()),
            (_) => false,
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
    backgroundColor: Pallete.backgroundColor,
    body: Column(
      children: [
        // Custom Title Bar
        WindowTitleBarBox(
          child: Container(
            color: Pallete.backgroundColor,
            child: Stack(
              children: [
                const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Minimize(),
                        Maximize(),
                        Close(),
                      ],
                    ),
                    Positioned.fill(child: MoveWindow()),
              ],
            ),   
          ),
        ),
        
        Expanded(
          child: isLoading
              ? const Loader()
              : Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: selectImage,
                              child: selectedImage != null ? 
                              Center(
                                child: SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Image.file(selectedImage!, fit: BoxFit.cover,) 
                                  ),
                              ) 
                              : Container(
                                color: const Color.fromARGB(255, 51, 51, 51),
                              ),
                            ),
                            Center( // Centering the card inside the amber container
                              child: Card(
                                elevation: 10,
                                shadowColor: const Color.fromARGB(255, 51, 51, 51),
                                color: Color.fromARGB(25, 255, 255, 255),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                child: const SizedBox(
                                  width: 150, // You can adjust the width of the card here
                                  height: 140, // You can adjust the height of the card here
                                  child: Icon(Icons.add, size: 50,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 600,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: const TextSpan(
                                        text: 'Sign up to\n',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Pallete.whiteColor),
                                        children: [
                                          TextSpan(
                                            text: 'start your music journey.',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Pallete.whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      hintText: 'Name',
                                      controller: nameController,
                                    ),
                                    CustomTextField(
                                      labelText: 'About',
                                      hintText: "Tell us something about yourself.",
                                      controller: aboutController,
                                    ),
                                    Button(
                                      text: "Sign Up.",
                                      onPressed: () async {
                                        
                                          String? imageUrl;
                                          if (selectedImage != null) {
                                            imageUrl = await uploadImage(selectedImage); 
                                          }
                                          print(userData.email);
                                          print(imageUrl);
                                          await ref.read(artistAuthViewmodelProvider.notifier).signUpArtist(
                                            email: userData.email,
                                            name: nameController.text,
                                            about: aboutController.text,
                                            imageUrl: imageUrl ?? '',
                                          );
                                        
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    ),
  );
}

}
