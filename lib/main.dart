import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keysoc_project/view/screens/music_seach.dart';
import 'package:keysoc_project/view_model/music_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MusicViewModel()),
      ],
      child: MaterialApp(
        title: 'Keysoc_Song_Search',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Keysoc Music Searcher'),
        initialRoute: '/',
        routes: {'/music_search': (context) => MusicSearch()},
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/music_search');
              },
              onDoubleTap: () {},
              child: Column(
                children: [
                  Image.asset('assets/images/keysoc_app_logo.jpeg'),
                  Text(
                    '進入音樂搜尋',
                    style: TextStyle(fontSize: 26),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
