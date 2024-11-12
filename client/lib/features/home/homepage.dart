import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/providers/current_user_notifier.dart';

dynamic home() async{
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  final userData = await container.read(authViewmodelProvider.notifier).getData(); //returns userModel as object
  return userData;
}

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _Homepage();
}

class _Homepage extends ConsumerState<Homepage> {
  bool _showFields = false;
  dynamic userData;

  @override
  void initState() {
    super.initState();
    loadData(); // Load data only once
  }

  Future<void> loadData() async {
    userData = await home(); // Call home() and store the result in userData
    setState(() {}); // Trigger a rebuild to display the fetched data
  }

  @override
  Widget build(BuildContext context) {
    // Loading indicator while data is being fetched
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 2480, maxHeight: 1200),
          child: Column(
            children: [
              Stack(
                children: [
                  // Title bar
                  SizedBox(
                    height: 53,
                    child: WindowTitleBarBox(
                      child: Container(
                        color: Pallete.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                userData.name,
                                style: TextStyle(color: Pallete.whiteColor),
                              ),
                              const SizedBox(width: 8.0),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showFields = !_showFields;
                                  });
                                },
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 35.0,
                                    height: 35.0,
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      foregroundImage: NetworkImage(userData.image_url),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              const Minimize(),
                              const Maximize(),
                              const Close(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(child: MoveWindow()),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: double.infinity,
                            color: const Color.fromARGB(7, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            height: double.infinity,
                            color: const Color.fromARGB(7, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Visibility(
                              visible: _showFields,
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: SizedBox(
                                  height: 350.0,
                                  width: 350.0,
                                  child: Card(
                                    color: Color.fromARGB(6, 0, 0, 0),
                                    shape: RoundedRectangleBorder(),
                                    elevation: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height: double.infinity,
                                color: const Color.fromARGB(7, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
