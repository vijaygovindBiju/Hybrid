import 'package:flutter/material.dart';
import 'package:hybrid/features/get_song/fetch_songs.dart';

class Home extends StatelessWidget {
   Home({super.key});
  final call = FetchSongs();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ElevatedButton(onPressed: call.getSong, child: Text("Get")),
      ),
    );
  }
}
