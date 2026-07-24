import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/Presentation/widget/show_song.dart';
import 'package:hybrid/features/get_song/data/provider/getSong_prov.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          switch (ref.watch(getSongProvider)) {
            AsyncError() => const Text("Sorry can't fetch song"),
            AsyncData(:final value) => Expanded(
              child: ListView.builder(
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
                  );
                },
              ),
            ),
            _ => CircularProgressIndicator(),
          },
        ],
      ),
    );
  }
}
