String formatDuration(int? duration) {// to convert to mill second to min adn sec
  if (duration == null) return "00:00";

  final minutes = duration ~/ 60000;
  final seconds = (duration % 60000) ~/ 1000;

  return "$minutes:${seconds.toString().padLeft(2, '0')}";
}