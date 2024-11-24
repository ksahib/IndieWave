import 'package:flutter/material.dart';

class ArtistDisplayWidget extends StatelessWidget{
  final String url;
  final String name;
  final double height;

  const ArtistDisplayWidget({super.key, required this.url, required this.name, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: height * 0.3,
                height: height * 0.35,
                child: CircleAvatar(
                  radius: height * 0.15,
                  backgroundImage: NetworkImage(url),
                ),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          );
  }
}