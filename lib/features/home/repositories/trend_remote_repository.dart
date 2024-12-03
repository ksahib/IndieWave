import 'dart:convert';
import 'package:client/features/home/models/trend_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';

part 'trend_remote_repository.g.dart';

@riverpod
TrendRemoteRepository trendRemoteRepository(Ref ref) {
  return TrendRemoteRepository();
}

class TrendRemoteRepository {
  final http.Client client = http.Client();
  final CookieJar cookieJar = CookieJar();

  Future<Either<AppFailure, List<TrendModel>>> getAllTrends(String? type) async {
  try {
    final uri = Uri.parse('${ServerConstant.serverUrl}/Trending');
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'type': type ?? "",
      },
    );

    final res = jsonDecode(response.body) as Map<String, dynamic>;
    //print('API Response Body: ${response.body}');
    if (response.statusCode != 200) {
      return Left(AppFailure(res['message']));
    } else {

      final List<dynamic> TrendList = res['data'];

      final List<TrendModel> trends = TrendList
          .map((trendData) => TrendModel.fromMap(trendData))
          .toList();

      return Right(trends);
    }
  } catch (e) {
    return Left(AppFailure(e.toString()));
  }
}


}