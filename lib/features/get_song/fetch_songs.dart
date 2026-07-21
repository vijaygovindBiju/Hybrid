import 'package:hybrid/features/get_song/data/model/audio_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future getSong() async {
    bool _isPermission = await _audioQuery.permissionsStatus();
    if (_isPermission == false) {
      _isPermission = await _audioQuery.permissionsRequest();
    } else {
      // todo: logic for geting the song
      List<AudioModel>  audio= await _audioQuery.queryAlbums();
    }
  }
}
