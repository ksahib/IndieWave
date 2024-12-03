import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the likeStatusProvider
final followStatusProvider = StateProvider<bool>((ref) => false); // Initial value is false (not liked)
