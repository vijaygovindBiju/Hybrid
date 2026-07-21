class AudioModel {
  int id;
  String title;
  String artist;
  String album;
  int duration;
  String data; // File path
  int albumId;
  int artistId;
  AudioModel({
    required this.album,
    required this.albumId,
    required this.artist,
    required this.artistId,
    required this.data,
    required this.duration,
    required this.id,
    required this.title
});
}