
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/player/data/model/play_data.dart';
import 'package:hybrid/features/player/function/player_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

final playerProvider =
    NotifierProvider<PlayerNotifier, PlayData>(
  PlayerNotifier.new,
);

class PlayerNotifier extends Notifier<PlayData> {
  late final PlayerFunction player;

  @override
  PlayData build() {
    player = PlayerFunction();
    ref.onDispose(() async {
      await player.dispose();
    });

    return  PlayData(
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
  }

  Future<void> resume() async {
    await player.resumeSong();
  }

  Future<void> seek(double value) async {
    await player.seek(value);
  }
}