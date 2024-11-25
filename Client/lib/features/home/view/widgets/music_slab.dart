import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicSlab extends ConsumerWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStream = ref.watch(currentStreamNotifierProvider);

    if(currentStream == null) {
      return const SizedBox();
    }
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(currentStream.album_cover), fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentStream.track_name, 
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Pallete.whiteColor),),
                    Text(
                    currentStream.artist_name, 
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Pallete.subtitleText),),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.heart, color: Pallete.whiteColor,),
              ),
              IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.play_fill, color: Pallete.whiteColor)),
            ],
          ),
        ],
      ),
    );
    
  }
}