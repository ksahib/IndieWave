import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePicUpload extends ConsumerStatefulWidget{
  const ProfilePicUpload({super.key});
  @override
  ConsumerState<ProfilePicUpload> createState() => _ProfilePicUploadState();
}

class _ProfilePicUploadState extends ConsumerState<ProfilePicUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}