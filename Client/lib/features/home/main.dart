import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/homepage.dart';
import 'package:client/features/Artist/view/pages/artist_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'dart:io';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  await container.read(authViewmodelProvider.notifier).getData();
  HttpOverrides.global = new MyHttpOverrides();
  //print(ud);
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true; // Ignore bad certificates
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

 @override
Widget build(BuildContext context, WidgetRef ref) {
  final userState = ref.watch(authViewmodelProvider);
    print(userState);
 



  return MaterialApp(
    title: 'Indiewave',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.darktheme,
    navigatorKey: navigatorKey,
    home: userState != null ? userState.when(
      data: (user) => const Homepage(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        print(error);
        // Redirect to LoginPage if session is not found or any other error occurs
        return const LoginPage();
        // return Scaffold(
        //   body: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text('An error occurred: $error'),
        //         ElevatedButton(
        //           onPressed: () {
        //             // Navigate to login page
        //             navigatorKey.currentState?.pushReplacement(
        //             MaterialPageRoute(builder: (context) => const LoginPage()),
        //           );
        //           },
        //           child: const Text('Login Again'),
        //         )
        //       ],
        //     ),
        //   ),
        // );
      },
    ):
    const LoginPage(),
  );
}

}
