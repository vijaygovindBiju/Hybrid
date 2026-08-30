import 'package:just_audio/just_audio.dart';

class PlayerFunction {
  final AudioPlayer player = AudioPlayer();

  Stream<Duration> get positionStream => player.positionStream;
  Stream<PlayerState> get playerStateStream => player.playerStateStream;
  bool get isCompleted => player.processingState == ProcessingState.completed;
  

  Future<void> playSong(String filePath) async {
    await player.setFilePath(filePath);
    await player.play();
  }

  Future<void> pauseSong() async {
    await player.pause();
  }

  Future<void> resumeSong() async {
    if (player.processingState == ProcessingState.completed) {
      await player.seek(Duration.zero);
    }
    await player.play();
  }

  Future<void> seek(double value) async {
    await player.seek(
      Duration(seconds: value.toInt()),
    );
  }

  Future<void> dispose() async {
    await player.dispose();
  }

}