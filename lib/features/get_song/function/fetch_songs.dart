import 'package:flutter/widgets.dart';
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
      debugPrint(audio.toString());
      return audio;
    }
  }

  Future filterSong() async {
    List<SongModel> songs =await getSong();
    List<SongModel> filteredSong= songs.where(
      (song) =>
          song.isMusic == true &&
          song.isAlarm != true &&
          song.isNotification != true &&
          song.isRingtone != true &&
          song.isPodcast != true &&
          song.isAudioBook != true,
    ).toList();
    return filteredSong;
  }
}
