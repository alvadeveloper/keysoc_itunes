import 'package:flutter/material.dart';
import 'package:keysoc_project/model/apis/api_response.dart';
import 'package:keysoc_project/model/music.dart';
import '../network/network.dart';

class MusicViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty Data');

  Music? _music;

  ApiResponse get response {
    return _apiResponse;
  }

  void resetData() {
    _apiResponse = ApiResponse.initial('Empty Data');
    notifyListeners();
  }

  Future<void> fetchMusicList(String search) async {
    _apiResponse = ApiResponse.loading('Fetching Data');
    notifyListeners();

    try {
      List<Music> _musicList = await fetchMusic(search);
      _apiResponse = ApiResponse.completed(_musicList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print('app error $e');
    }
    notifyListeners();
  }
}
