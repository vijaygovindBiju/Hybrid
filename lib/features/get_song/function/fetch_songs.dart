import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future getSong() async {
    bool isPermission = await _audioQuery.permissionsStatus();
    if (isPermission == false) {
      isPermission = await _audioQuery.permissionsRequest();
    } else {
      // todo: logic for geting the song
      List<SongModel> audio = await _audioQuery.querySongs();
      return audio;
    }
  }
}
