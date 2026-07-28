import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/data/provider/album_cover_prov.dart';
import 'package:hybrid/features/get_song/function/convert_to_time.dart';
import 'package:hybrid/features/get_song/function/wrap_song_title.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ShowSong extends ConsumerWidget {
  final SongModel song;
  const ShowSong({super.key, required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: switch (ref.watch(albumCoverProvider(song.id))) {
                    AsyncLoading() => Image.asset("assets/images/no_cover.png"),

                    AsyncError() => Image.asset("assets/images/no_cover.png"),

                    AsyncData(:final value) =>
                      value != null
                          ? Image.memory(
                              value,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/no_cover.png",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wrapSongTitle(song.title)),
                  Text(
                    song.artist == null || song.artist == "<unknown>"
                        ? "Unknown Artist"
                        : song.artist!,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(song.fileExtension),
                    Text(formatDuration(song.duration)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
