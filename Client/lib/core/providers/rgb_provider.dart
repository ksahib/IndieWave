import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final rgbProvider = StateProvider<Color>((ref) {
  return const Color.fromARGB(100, 99, 102, 106); // Default color
});
