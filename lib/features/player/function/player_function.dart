import 'package:just_audio/just_audio.dart';

class PlayerFunction {
  final AudioPlayer player = AudioPlayer();

  Future<void> playSong(String filePath) async {
    await player.setFilePath(filePath);
    await player.play();
  }

  Future<void> pauseSong() async {
    await player.pause();
  }

  Future<void> resumeSong() async {
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