import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

 @override
Widget build(BuildContext context, WidgetRef ref) {
  final userState = ref.watch(authViewmodelProvider);

  return MaterialApp(
    title: 'Indiewave',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.darktheme,
    home: userState != null ?userState.when(
      data: (user) => const Homepage(),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        // Redirect to LoginPage if session is not found or any other error occurs
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('An error occurred: $error'),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text('Login Again'),
                )
              ],
            ),
          ),
        );
      },
    ):
    const LoginPage(),
  );
}

}
