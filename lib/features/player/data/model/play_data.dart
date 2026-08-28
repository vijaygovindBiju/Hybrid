import 'package:on_audio_query/on_audio_query.dart';

class PlayData {
  final SongModel? nowPlaying;
  final Duration currentPosition;
  final bool isPlaying;

  PlayData({
    this.nowPlaying,
    required this.currentPosition,
    required this.isPlaying,
  });
}