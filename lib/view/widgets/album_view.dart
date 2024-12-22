import 'package:flutter/material.dart';
import 'package:keysoc_project/model/music.dart';

class AlbumView extends StatefulWidget {
  final Music data;

  const AlbumView({required this.data});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                fit: BoxFit.fill,
                widget.data.artworkUrl100 ?? '',
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CircularProgressIndicator();
                },
                errorBuilder: (context, child, loadingProgress) {
                  return Icon(Icons.error);
                },
              ),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              "🎼 ${widget.data.trackName ?? ''}",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              "🎤 ${widget.data.artistName ?? ''}",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              '💽 ${widget.data.collectionName ?? ''}',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Text(
                  (widget.data.currency ?? ''),
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  widget.data.trackPrice?.toString() ?? '',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
