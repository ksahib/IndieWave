import 'dart:convert';
import 'package:client/features/album/model/album_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';

part 'banner_remote_repository.g.dart';

@riverpod
BannerRemoteRepository bannerRemoteRepository(Ref ref) {
  return BannerRemoteRepository();
}

class BannerRemoteRepository {
  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();

  Future<Either<AppFailure, AlbumModel>> getBanner(String? email) async {
    try{
      final uri = Uri.parse('${ServerConstant.serverUrl}/Banner');
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'email': email ?? "",
        },
      );

      final res = jsonDecode(response.body) as Map<String, dynamic>;
      print(res);
      if (response.statusCode != 200) {
        return Left(AppFailure(res['message']));
      } else {

        final Map<String, dynamic> banner = res['data'];
        return Right(AlbumModel.fromMap(banner));
      }
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }


}