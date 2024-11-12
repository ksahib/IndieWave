import 'dart:io';

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