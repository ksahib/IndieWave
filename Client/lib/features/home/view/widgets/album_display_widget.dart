import 'package:flutter/material.dart';

class AlbumDisplayWidget extends StatelessWidget{
  final String url;
  final String album;
  final String artist;
  final double height;

  const AlbumDisplayWidget({super.key, required this.url, required this.album,required this.artist, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: height * 0.3,
                height: height * 0.32,
                child: Container(
                  height: height * 0.15,
                  width: height * 0.09,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image(image: NetworkImage(url)),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    album,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    artist,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              )
            ],
          );
  }
}