import 'dart:async';
import 'dart:convert';
import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/album/model/album_model.dart';
import 'package:client/features/home/models/trend_model.dart';
import 'package:client/features/home/view/pages/album_view.dart';
import 'package:client/features/home/view/pages/artist_page.dart';
import 'package:client/features/home/view/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/close.dart';
import 'package:client/core/widgets/maximize.dart';
import 'package:client/core/widgets/minimize.dart';

class UserTitlebar extends ConsumerStatefulWidget {
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

class NavigationHistory {
  static final List<String> _historyStack = [];

  static void pushRoute(String route) {
    _historyStack.add(route);
  }

  static String? popRoute() {
    if (_historyStack.isNotEmpty) {
      return _historyStack.removeLast();
    }
    return null;
  }

  static bool hasForwardRoute() => _historyStack.isNotEmpty;
}

class _UserTitlebarState extends ConsumerState<UserTitlebar> {
  final TextEditingController searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String type = 'all';
  Timer? _debounceTimer;
  List<TrendModel> trackSearchResults = [];
  List<AlbumModel> albumSearchResults = [];
  List<TrendModel> artistSearchResults = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchTextChanged);
    searchController.dispose();
    _debounceTimer?.cancel();
    _overlayEntry?.remove();
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text;
      if (query.isNotEmpty) {
        if (_overlayEntry == null) {
          _showOverlay();
        }
        _search(query, type);
      } else {
        _hideOverlay();
      }
    });
  }

  void _showOverlay() {
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

Future<List<TrendModel>> parseArtistsFromResponse(String responseBody, String type) async {
  final Map<String, dynamic> jsonData = json.decode(responseBody);
  if (type== 'artists' && jsonData['data'] != null && jsonData['data']['artists'] != null) {
    final List<dynamic> artistList = jsonData['data']['artists'];
    try{
      return artistList.map((artistMap) => TrendModel.fromMap(artistMap)).toList();
    } catch(e) {
      //print('Error during parsing: $e');
      return [];
    }
  } else if(type== 'tracks' && jsonData['data'] != null && jsonData['data']['tracks'] != null) {
      final List<dynamic> trackList = jsonData['data']['tracks'];
      try{
        return trackList.map((artistMap) => TrendModel.fromMap(artistMap)).toList();
      } catch(e) {
        print('Error during parsing: $e');
        return [];
      }
  } else {
      return [];
  }
}

Future<List<AlbumModel>> parseAlbumsFromResponse(String responseBody) async {
  final Map<String, dynamic> jsonData = json.decode(responseBody);
  if (jsonData['data'] != null && jsonData['data']['albums'] != null) {
      final List<dynamic> albumList = jsonData['data']['albums'];
      try{
        return albumList.map((artistMap) => AlbumModel.fromMap(artistMap)).toList();
      } catch(e) {
        //print('Error during parsing: $e');
        return [];
      }
  } else {
      return [];
  }
}




  Future<void> _search(String query, String type) async {
    try {
      final url = Uri.parse('${ServerConstant.serverUrl}/Search');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'hint': query,
          'type': type,
        },
      );

      if (response.statusCode == 200) {
        final List<TrendModel> artists = await parseArtistsFromResponse(response.body, 'artists');
        final List<AlbumModel> albums = await parseAlbumsFromResponse(response.body);
        final List<TrendModel> tracks = await parseArtistsFromResponse(response.body, 'tracks');
        final data = jsonDecode(response.body);
        setState(() {
          trackSearchResults = tracks;
          albumSearchResults = albums;
          artistSearchResults = artists;
        });
      } else {
        _clearResults();
      }
    } catch (e) {
      _clearResults();
    }

    _overlayEntry?.markNeedsBuild();
  }

  void _clearResults() {
    setState(() {
      trackSearchResults.clear();
      albumSearchResults.clear();
      artistSearchResults.clear();
    });
  }

Widget _buildPillButton(String text, {required VoidCallback onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Pallete.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}


  OverlayEntry _buildOverlayEntry() {
  final RenderBox renderBox = context.findRenderObject() as RenderBox;
  final size = renderBox.size;

  return OverlayEntry(
    builder: (context) {
      return Positioned(
        width: MediaQuery.of(context).size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            color: const Color.fromARGB(141, 0, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Pallete.transparentColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildPillButton('All', onPressed: () {
                          setState(() {
                            type = 'all';
                          });
                          _search(searchController.text, type);
                        }),
                        const SizedBox(width: 5,),
                        _buildPillButton('Artists', onPressed: () {
                          setState(() {
                            type = 'artists';
                          });
                          _search(searchController.text, type);
                        }),
                        const SizedBox(width: 5,),
                        _buildPillButton('Albums', onPressed: () {
                          setState(() {
                            type = 'albums';
                          });
                          _search(searchController.text, type);
                        }),
                        const SizedBox(width: 5,),
                        _buildPillButton('Tracks', onPressed: () {
                          setState(() {
                            type = 'tracks';
                          });
                          _search(searchController.text, type);
                        }),
                      ],
                    ),
                  ),
                  _buildSection('Tracks', trackSearchResults),
                  _buildSection('Albums', albumSearchResults),
                  _buildSection('Artists', artistSearchResults),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}



Widget _buildSection(String title, List<dynamic> items) {
  if (items.isEmpty) return const SizedBox.shrink();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(color: Pallete.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          
          String titleText;
          VoidCallback? onTapCallback;

          if (item is AlbumModel) {
            titleText = item.name;
            onTapCallback = () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(albumName: item.name, artist: item,)));
            };
          } else if(item.track_id != '') {
            titleText = item.track_name;
            onTapCallback = () async {
              final userData = await checkCreds();
              ref.read(currentStreamNotifierProvider.notifier).updateSong(item);
              ref.read(currentStreamNotifierProvider.notifier).countStreams(userData.email, item.track_id);
            };
          } else if (item is TrendModel) {
            titleText = item.artist_name;
            onTapCallback = () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistPage(artistData: item)));
            };
          } else {
            titleText = 'Unknown';
          }

          return ListTile( 
            title: Text(
              titleText,
              style: const TextStyle(color: Pallete.whiteColor),
            ),
            onTap: onTapCallback,
          );
        },
      ),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        height: 53,
        child: WindowTitleBarBox(
          child: Stack(
            children: [
              Container(
                color: Pallete.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                  child: Row(
                    children: [
                      //back and forward buttons
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              if(context.widget.runtimeType != Homepage)
                                Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          IconButton(
                            onPressed: () {
                              final forwardRoute = NavigationHistory.popRoute();
                                if (forwardRoute != null) {
                                  Navigator.pushNamed(context, forwardRoute);
                                } else {
                                  //print("No forward route available");
                                }
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          height: 33,
                          width: 500,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle:
                                  TextStyle(color: Pallete.whiteColor.withOpacity(0.6)),
                              filled: true,
                              fillColor: Pallete.backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                            ),
                            style: const TextStyle(color: Pallete.whiteColor),
                          ),
                        ),
                      ),
                      const Spacer(),
                      //user profile and window control buttons
                      Row(
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(color: Pallete.whiteColor),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: ClipOval(
                              child: CircleAvatar(
                                radius: 20.0,
                                foregroundImage: NetworkImage(widget.url),
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
              Positioned.fill(child: MoveWindow()),
            ],
          ),
        ),
      ),
    );
  }
}
