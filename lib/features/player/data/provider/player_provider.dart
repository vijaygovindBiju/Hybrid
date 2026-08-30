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
      if (state.isPlaying) {
        state = PlayData(
          nowPlaying: state.nowPlaying,
          currentPosition: position,
          isPlaying: state.isPlaying,
        );
      }
    });

    _playerStateSub = player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        state = PlayData(
          nowPlaying: state.nowPlaying,
          currentPosition: state.currentPosition,
          isPlaying: false,
        );
      }
    });

    ref.onDispose(() async {
      await _positionSub?.cancel();
      await _playerStateSub?.cancel();
      await player.dispose();
    });

    return PlayData(currentPosition: Duration.zero, isPlaying: true);
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

  Future<void> resume() async {
    final wasCompleted = player.isCompleted;
    await player.resumeSong();
    state = PlayData(
      nowPlaying: state.nowPlaying,
      currentPosition: wasCompleted ? Duration.zero : state.currentPosition,
      isPlaying: true,
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
