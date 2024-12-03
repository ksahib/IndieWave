import 'dart:ui';

import 'package:flutter/material.dart';

class PointedRectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from the top-left corner
    path.moveTo(10, 10);

    // Draw line to the top-right corner
    path.lineTo(size.width-10, 10);

    // Draw line to the bottom-right corner
    path.lineTo(size.width-10, size.height-10); // Adjust for the pointed edge

    // Draw line to the bottom-left corner
    path.lineTo(10, size.height-10); // Adjust for the pointed edge

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}