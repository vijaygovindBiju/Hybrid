import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/data/provider/album_cover_prov.dart';
import 'package:hybrid/features/get_song/data/provider/get_color_prov.dart';
import 'package:hybrid/features/get_song/function/song_detailzation.dart';
import 'package:hybrid/features/get_song/function/wrap_song_title.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ShowSong extends ConsumerWidget {
  final SongModel song;
  const ShowSong({super.key, required this.song});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coverColor = ref.watch(getColorProvider(song.id));
    final textColor = Colors.white;

    return InkWell(
      onTap: () {
        debugPrint("it's pressed ${song.title}");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: switch (coverColor) {
            AsyncData(:final value) =>
              value?.dominantColor?.color ?? Colors.grey[600],

            _ => Colors.grey[600],
          },
        ),
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: switch (ref.watch(albumCoverProvider(song.id))) {
                        AsyncLoading() => Image.asset(
                          "assets/images/no_cover.png",
                        ),

                        AsyncError() => Image.asset(
                          "assets/images/no_cover.png",
                        ),

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
                      Text(
                        wrapSongTitle(song.title),
                        style: TextStyle(color: textColor, fontSize: 17),
                      ),
                      Text(
                        song.artist == null || song.artist == "<unknown>"
                            ? "Unknown Artist"
                            : song.artist!,
                        style: TextStyle(color: textColor, fontSize: 12),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          song.fileExtension.toUpperCase(),
                          style: TextStyle(color: textColor, fontSize: 13),
                        ),
                        Text(
                          formatDuration(song.duration),
                          style: TextStyle(color: textColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
