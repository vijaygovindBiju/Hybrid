import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/player/data/model/play_data.dart';
import 'package:hybrid/features/player/function/player_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

final playerProvider =
    NotifierProvider<PlayerNotifier, PlayData>(PlayerNotifier.new);

class PlayerNotifier extends Notifier<PlayData> {
  late final PlayerFunction player;

  @override
  PlayData build() {
    player = PlayerFunction();

    ref.onDispose(() {
      player.player.dispose();
    });

    return PlayData(
      currentPosition: Duration.zero,
      isPlaying: false,
    );
  }

  Future<void> playSong(SongModel song) async {
    await player.playSong(song.data);

    state = PlayData(
      nowPlaying: song,
      currentPosition: Duration.zero,
      isPlaying: true,
    );
  }

  Future<void> pauseSong() async {
    await player.pauseSong();

    state = PlayData(
      nowPlaying: state.nowPlaying,
      currentPosition: state.currentPosition,
      isPlaying: false,
    );
  }

  Future<void> seek(double value) async {
    await player.seek(value);

    state = PlayData(
      nowPlaying: state.nowPlaying,
      currentPosition: Duration(seconds: value.toInt()),
      isPlaying: state.isPlaying,
    );
  }
}