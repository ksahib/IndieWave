import 'package:client/core/widgets/utils.dart';
import 'package:client/features/Artist/view/widgets/artist_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumPage extends ConsumerStatefulWidget {
  const AlbumPage({super.key});

  @override
  ConsumerState<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends ConsumerState<AlbumPage> {
  dynamic artistData;
  dynamic albumData;

  Future<void> loadData() async {
    artistData = await checkArtistCreds();
    print(artistData);
    setState(() {});
    if (artistData != null && artistData.artist_name != null) {
    //loadAlbums();
  }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 1200),
          child: Column(
            children: [
              ArtistTitleBar(url: 'https://res.cloudinary.com/doonwj6hd/image/upload/v1731464523/a1avsd23btp9ug8hrhva.png'),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double topContainerHeight = constraints.maxHeight * 0.4;
                    
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: topContainerHeight,
                              color: Colors.amber,
                            ),
                            Expanded(
                              child: Container(color: Colors.cyanAccent),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 20,
                          top: topContainerHeight - 75,
                          child: Card(
                            elevation: 10,
                            child: SizedBox(
                              width: 170,
                              height: 170,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
