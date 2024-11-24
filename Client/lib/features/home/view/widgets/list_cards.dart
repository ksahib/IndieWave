import 'package:flutter/material.dart';

class ListCards extends StatelessWidget{
  final String url;
  final String title;
  final double height;
  final double width;
  const ListCards({super.key, required this.url, required this.title, required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.1,
      width: width,
      child: Card(
        elevation: 10,
        color: Color.fromARGB(97, 180, 178, 178),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            ClipRect(
              child:Image(image: NetworkImage(url)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)
              )
            ),
          ],
        ),
        
      ),
    );
  }
}