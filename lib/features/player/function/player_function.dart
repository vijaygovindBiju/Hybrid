import 'package:just_audio/just_audio.dart';

class PlayerFunction {
  final player = AudioPlayer(); // Create a player
  String formateDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}";
  }

  void seek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }
}
