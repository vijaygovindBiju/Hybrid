import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FetchSongs {
  final OnAudioQuery _audioQuery = OnAudioQuery();


  Future<List<SongModel>> getSong() async {
    bool isPermission = await _audioQuery.permissionsStatus();
    if (!isPermission) {
      isPermission = await _audioQuery.permissionsRequest();
    }
    if (isPermission) {
      // todo: logic for geting the song
      List<SongModel> audio = await _audioQuery.querySongs();
      debugPrint(audio.toString());
      return audio;
    }
    return [];
  }

  Future<List<SongModel>> filterSong() async {
    List<SongModel> songs = await getSong();
    List<SongModel> filteredSong = songs
        .where(
          (song) =>
              song.isMusic == true &&
              song.isAlarm != true &&
              song.isNotification != true &&
              song.isRingtone != true &&
              song.isPodcast != true &&
              song.isAudioBook != true &&
              !song.data.contains("WhatsApp"),
        )
        .toList();
    debugPrint(filteredSong.toString());
    return filteredSong;
  }

  Future<Uint8List?> artWork(int id) async {
    try {
      return await _audioQuery.queryArtwork(id, ArtworkType.AUDIO);
    } catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
