import 'dart:convert';
import 'dart:io';
import 'package:client/features/Artist/view_model/artist_auth_viewmodel.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void showSnackBar(BuildContext context, String content, backgroundcolor) {
  ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: backgroundcolor,
              content: Text(
                content,
                style: const TextStyle(color: Pallete.whiteColor),
              ))
          );
}

Future<File?> pickImage() async{
  try{
    final filePicker = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if(filePicker != null) {
      return File(filePicker.files.first.xFile.path);
    }
    return null;
  } catch(e) {
    return null;
  }
}

String generateSignature(String apiSecret, String timestamp) {
  final data = "timestamp=$timestamp$apiSecret";
  final bytes = utf8.encode(data);
  return sha1.convert(bytes).toString();
}

  Future<String?> uploadImage(File? imagefile) async{
    if(imagefile == null) {
      return null;
    }
    final cloudinaryUrl = "https://api.cloudinary.com/v1_1/doonwj6hd/image/upload";
    final api = "831262682327616";
    final apiSecret = "s-Q-z3jVInXRlazQ3VYcxOAaKS0";
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final signature = generateSignature(apiSecret, timestamp);

    final req = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
      ..fields['api_key'] = api
      ..fields['timestamp'] = timestamp
      ..fields['signature'] = signature
      ..files.add(await http.MultipartFile.fromPath('file', imagefile.path));

      final response = await req.send();
      if(response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        return data['secure_url'];
      } else {
        print("Failed to upload image to Cloudinary");
        return null;
      }
  }

  dynamic checkCreds() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  final userData = await container.read(authViewmodelProvider.notifier).getData(); //returns userModel as object
  return userData;
}

dynamic checkArtistCreds() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  final artistData = await container.read(artistAuthViewmodelProvider.notifier).getArtistData(); //returns artistModel as object
  return artistData;
}

String resizeImage(String imageUrl, {required double width, required double height}) {
  Uri uri = Uri.parse(imageUrl);

  String BaseUrl = uri.origin + '/' + uri.pathSegments.take(1).join('/') + '/';

  String publicId = uri.pathSegments.last.split('.').first;
  String transformation = 'w_${width.toInt()},h_${height.toInt()},c_fill';
  String resizedImageUrl = '$BaseUrl$transformation/$publicId.${uri.pathSegments.last.split('.').last}';
  
  return resizedImageUrl;
}





