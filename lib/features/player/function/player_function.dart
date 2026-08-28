import 'package:just_audio/just_audio.dart';

class PlayerFunction {
  final player = AudioPlayer(); // Create a player
  String formateDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> seek(double value) {
    return player.seek(Duration(seconds: value.toInt()));
  }

  Future<void> playSong(String filePath) async {
    await player.setFilePath(filePath);
    await player.play();
  }

  Future<void> pauseSong() async {
    await player.pause();
  }
}
