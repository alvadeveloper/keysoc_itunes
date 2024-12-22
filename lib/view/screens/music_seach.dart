import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:keysoc_project/model/apis/api_response.dart';
import 'package:keysoc_project/view/widgets/album_view.dart';
import 'package:keysoc_project/view_model/music_view_model.dart';
import 'package:provider/provider.dart';

class MusicSearch extends StatefulWidget {
  const MusicSearch({Key? key}) : super(key: key);
  @override
  State<MusicSearch> createState() => _MusicSearchState();
}

class _MusicSearchState extends State<MusicSearch> {
  final _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  var itemPerPage = 20;
  int currentPage = 1;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MusicViewModel>(context, listen: false).resetData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<MusicViewModel>(context).response;
    int totalPages = apiResponse.status == Status.COMPLETED
        ? (apiResponse.data.length / itemPerPage).ceil()
        : 0;

    return Scaffold(
      appBar: AppBar(title: Text('Keysoc音樂搜尋')),
      body: Column(
        children: [
          TextField(
            controller: _inputController,
            onChanged: (text) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                if (text.isNotEmpty) {
                  Provider.of<MusicViewModel>(context, listen: false)
                      .fetchMusicList(text.replaceAll(' ', '&'));
                  setState(() {
                    currentPage = 1;
                  });
                  _scrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                } else {
                  Provider.of<MusicViewModel>(context, listen: false)
                      .fetchMusicList("");
                }
              });
            },
            onSubmitted: (text) {},
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: '輸入歌手或專輯名稱'),
          ),
          if (apiResponse.status == Status.COMPLETED) ...[
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(
                        totalPages,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: currentPage == index + 1
                                  ? Colors.blueAccent
                                  : Colors.white,
                              foregroundColor: currentPage == index + 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                currentPage = index + 1;
                              });
                              _scrollController.animateTo(
                                0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                            child: Text(
                              'Page ${index + 1}',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: min(
                      itemPerPage,
                      apiResponse.data.length -
                          ((currentPage - 1) * itemPerPage)),
                  itemBuilder: (context, index) {
                    final actualIndex =
                        ((currentPage - 1) * itemPerPage) + index;
                    return AlbumView(data: apiResponse.data[actualIndex]);
                  },
                ),
              ),
            ),
          ] else if (apiResponse.status == Status.LOADING) ...[
            CircularProgressIndicator()
          ] else ...[
            Center(
                child: Text(
              '開始搜尋',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ))
          ]
        ],
      ),
    );
  }
}
