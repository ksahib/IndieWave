import 'dart:async';  // For Timer
import 'dart:convert';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // For making HTTP requests
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';

class UserTitlebar extends StatefulWidget {
  final String url;
  final String name;
  final VoidCallback onTap;

  UserTitlebar({
    super.key,
    required this.url,
    required this.name,
    required this.onTap,
  });

  @override
  _UserTitlebarState createState() => _UserTitlebarState();
}

class _UserTitlebarState extends State<UserTitlebar> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();

    // Listen for text changes in the search bar
    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchTextChanged);
    _debounceTimer?.cancel();  // Cancel any ongoing timer
    super.dispose();
  }

  // This is called when the search text changes
  void _onSearchTextChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();  // Cancel the previous timer
    }

    // Start a new debounce timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text;
      if (query.isNotEmpty) {
        _search(query);
      }
    });
  }

  // Method to call your API and perform the search
  Future<void> _search(String query) async {
    // Make your API request here
    try {
      final url = Uri.parse('${ServerConstant.serverUrl}/Search');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'hint': query,
        }
      );

      if (response.statusCode == 200) {
        // Handle the successful response
        print('Search results: ${response.body}');
        // You can parse the results and update the UI as needed
      } else {
        // Handle error
        print('Failed to load search results');
      }
    } catch (e) {
      print('Error occurred during search: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 53,
          child: WindowTitleBarBox(
            child: Container(
              color: Pallete.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left section with back and forward buttons
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          IconButton(
                            onPressed: () {
                              //Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                    // Search Bar
                    Expanded(
                      flex: 2, // Adjust this flex value to control the width of the search bar
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 500,  // Fixed width for the search bar
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(
                                      color: Pallete.whiteColor.withOpacity(0.6),
                                    ),
                                    filled: true,
                                    fillColor: Pallete.backgroundColor,  // Ensure it has a solid fill color
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),  // Fully rounded corners
                                      borderSide: BorderSide.none,  // No border outline
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                  ),
                                  style: const TextStyle(color: Pallete.whiteColor),
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Right section with the name, avatar, and window controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(color: Pallete.whiteColor),
                        ),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: ClipOval(
                            child: SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: CircleAvatar(
                                radius: 20.0,
                                foregroundImage: NetworkImage(widget.url),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(child: MoveWindow()),
      ],
    );
  }
}
