import 'package:flutter/material.dart';
import 'package:hybrid/features/get_song/function/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ShowSong extends StatelessWidget {
final SongModel song; 

  ShowSong({
    super.key,
    required this.song
  });

  final fetchSong = FetchSongs();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        // Text("Id $id", style: TextStyle(fontSize: 5)),
        Text("Data ${song.data}", style: TextStyle(fontSize: 7)),
        Text("Display name ${song.displayName}", style: TextStyle(fontSize: 7)),
      ],
    );
  }
}
