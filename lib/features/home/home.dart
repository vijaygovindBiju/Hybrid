import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/Presentation/widget/show_song.dart';
import 'package:hybrid/features/get_song/data/provider/getSong_prov.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          switch (ref.watch(getSongProvider)) {
            AsyncError() => const Text("Sorry can't fetch song"),
            AsyncData(:final value) => Expanded(
              child: value.isEmpty
                  ? Text("Sorry no song")
                  : ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ShowSong(
                          id: value[index].id,
                          uri: value[index].uri,
                          data: value[index].data,
                          displayName: value[index].displayName,
                          displayNameWOExt: value[index].displayNameWOExt,
                          size: value[index].size,
                          album: value[index].album,
                          albumId: value[index].albumId,
                          artist: value[index].artist,
                          artistId: value[index].artistId,
                          isAlarm: value[index].isAlarm,
                          bookmark: value[index].bookmark,
                          composer:value[index].composer,
                          dateAdded: value[index].dateAdded,
                          dateModified: value[index].dateModified,
                          duration: value[index].duration,
                          fileExtension: value[index].fileExtension,
                          genre: value[index].genre,
                          genreId: value[index].genreId,
                          getMap: value[index].getMap,
                          isAudioBook: value[index].isAudioBook,
                          isMusic: value[index].isMusic,
                          isNotification: value[index].isNotification,
                          isPodcast: value[index].isPodcast,
                          isRingtone: value[index].isRingtone,
                          title: value[index].title,
                          track: value[index].track
                        );
                      },
                    ),
            ),

            _ => Center(child: CircularProgressIndicator()),
          },
        ],
      ),
    );
  }
}
