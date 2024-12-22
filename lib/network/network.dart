import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keysoc_project/model/music.dart';

final dio = Dio();

Future<List<Music>> fetchMusic(String searchKeywords) async {
  final response = await dio.get(
      'https://itunes.apple.com/search?term=$searchKeywords&limit=200&media=music&sort=trackName');

  if (response.statusCode == 200) {
    List<dynamic> results = jsonDecode(response.data)['results'];
    List<Music> musicList =
        results.map((json) => Music.fromJson(json)).toList();

    musicList.sort((a, b) {
      String collectionNameA = (a.collectionName ?? '').toLowerCase();
      String collectionNameB = (b.collectionName ?? '').toLowerCase();
      int collectionComparison = collectionNameA.compareTo(collectionNameB);
      if (collectionComparison == 0) {
        String trackNameA = (a.trackName ?? '').toLowerCase();
        String trackNameB = (b.trackName ?? '').toLowerCase();
        return trackNameA.compareTo(trackNameB);
      }
      return collectionComparison;
    });

    return musicList;
  } else {
    return [];
  }
}
