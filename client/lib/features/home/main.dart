import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/homepage.dart';
import 'package:client/features/home/view/pages/artist_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  await container.read(authViewmodelProvider.notifier).getData();
   // Configure the window manager
  await windowManager.waitUntilReadyToShow();
  await windowManager.setAsFrameless();

  // Configure window settings once the window is ready
  doWhenWindowReady(() {
    final initialSize = Size(1200, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Music App";
    appWindow.show();
  });
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ));

  
  
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Indiewave',
      debugShowCheckedModeBanner: true,
      theme: AppTheme.darktheme,
      home: user == null ? const SignupPage() : const ArtistProfilePage(),
    );
  }
}