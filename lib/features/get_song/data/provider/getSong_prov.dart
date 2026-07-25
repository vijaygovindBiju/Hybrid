import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/function/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

final getSongProvider = FutureProvider<List<SongModel>>((ref) async {
  List<SongModel> songs = await FetchSongs().filterSong();
  return songs;
});