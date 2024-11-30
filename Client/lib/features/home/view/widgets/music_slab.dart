import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/providers/current_stream_notifier.dart';
import 'package:client/core/providers/current_track_notifier.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/providers/like_status_provider.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MusicSlab extends ConsumerWidget {
  MusicSlab({super.key});

  Future<void> fetchLikeStatus(WidgetRef ref, String email, String trackId) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/LikeStatus');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'email': email,
          'track-id': trackId,
        },
      );
      if (response.statusCode == 200) {
        ref.read(likeStatusProvider.notifier).state = true; 
      } else {
        ref.read(likeStatusProvider.notifier).state = false; 
      }
    } catch (e) {
      print(e.toString());
      ref.read(likeStatusProvider.notifier).state = false; 
    }
  }

  Future<void> handleLike(WidgetRef ref, String email, String trackId) async {
    try {
      await http.post(
        Uri.parse('${ServerConstant.serverUrl}/Like'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "track_id": trackId}),
      );
      ref.read(likeStatusProvider.notifier).state =
          !ref.read(likeStatusProvider); 
    } catch (e) {
      print("Failed to like: $e");
    }
  }

  Future<void> unlike(WidgetRef ref, String email, String trackId) async {
    try {
      final uri = Uri.parse('${ServerConstant.serverUrl}/Unlike');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'email': email,
          'track-id': trackId,
        },
      );
      ref.read(likeStatusProvider.notifier).state =
          !ref.read(likeStatusProvider);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStream = ref.watch(currentStreamNotifierProvider);
    final currentUser = ref.read(currentUserNotifierProvider);
    final likeStatus = ref.watch(likeStatusProvider);

    if (currentStream == null || currentUser == null) {
      return const SizedBox();
    }

    // Fetch like status only once per build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLikeStatus(ref, currentUser.email, currentStream.track_id);
    });

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
                    image: NetworkImage(currentStream.album_cover),
                    fit: BoxFit.cover,
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
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Pallete.whiteColor,
                    ),
                  ),
                  Text(
                    currentStream.artist_name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Pallete.subtitleText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if(likeStatus == false) {
                  handleLike(ref, currentUser.email, currentStream.track_id);
                  } else {
                    unlike(ref, currentUser.email, currentStream.track_id);
                  }
                },
                icon: Icon(
                  likeStatus ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: Pallete.whiteColor,
                ),
              ),
              IconButton(
                onPressed: ref
                    .read(currentStreamNotifierProvider.notifier)
                    .playPause,
                icon: Icon(
                  ref.read(currentStreamNotifierProvider.notifier).isPlaying
                      ? CupertinoIcons.pause_fill
                      : CupertinoIcons.play_fill,
                  color: Pallete.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
