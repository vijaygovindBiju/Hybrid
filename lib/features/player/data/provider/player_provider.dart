import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/player/data/model/play_data.dart';
import 'package:hybrid/features/player/function/player_function.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final playerProvider = NotifierProvider<PlayerNotifier, PlayData>(
  PlayerNotifier.new,
);

class PlayerNotifier extends Notifier<PlayData> {
  late final PlayerFunction player;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  @override
  PlayData build() {
    player = PlayerFunction();

    _positionSub = player.positionStream.listen((position) {
      state = PlayData(
        nowPlaying: state.nowPlaying,
        currentPosition: position,
        isPlaying: state.isPlaying,
      );
    });

    _playerStateSub = player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing &&
          playerState.processingState != ProcessingState.completed;
      state = PlayData(
        nowPlaying: state.nowPlaying,
        currentPosition: state.currentPosition,
        isPlaying: isPlaying,
      );
    });

    ref.onDispose(() async {
      await _positionSub?.cancel();
      await _playerStateSub?.cancel();
      await player.dispose();
    });

    return PlayData(currentPosition: Duration.zero, isPlaying: false);
  }

  Future<void> playSong(SongModel song) async {
    state = PlayData(
      nowPlaying: song,
      currentPosition: Duration.zero,
      isPlaying: true,
    );
    await player.playSong(song.data);
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
