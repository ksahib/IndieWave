import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

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