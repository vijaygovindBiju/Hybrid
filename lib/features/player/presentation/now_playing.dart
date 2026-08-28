import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/data/provider/album_cover_prov.dart';
import 'package:hybrid/features/get_song/function/song_detailzation.dart';
import 'package:hybrid/features/player/function/player_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends ConsumerStatefulWidget {
  final SongModel song;
  const NowPlaying({super.key, required this.song});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NowPlayingState();
}

class _NowPlayingState extends ConsumerState<NowPlaying> {
  final PlayerFunction player = PlayerFunction();
  int isplay = 0;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        height: deviceSize.height,
        padding: EdgeInsets.only(
          top: deviceSize.height * 0.04,
          bottom: deviceSize.height * 0.02,
          left: deviceSize.width * 0.03,
          right: deviceSize.width * 0.03,
        ),
        decoration: BoxDecoration(color: Colors.grey),
        child: Column(
          children: [
            SizedBox(height: deviceSize.height * 0.11),
            Container(
              decoration: BoxDecoration(color: Colors.amber),
              width: deviceSize.width * 0.65,
              height: deviceSize.height * 0.4,
              child: switch (ref.watch(albumCoverProvider(widget.song.id))) {
                AsyncLoading() => Image.asset(
                  "assets/images/no_cover.png",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),

                AsyncError() => Image.asset(
                  "assets/images/no_cover.png",
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),

                AsyncData(:final value) =>
                  value != null
                      ? Image.memory(
                          value,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        )
                      : Image.asset(
                          "assets/images/no_cover.png",
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
              },
            ),

            SizedBox(height: deviceSize.height * 0.1),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(color: Colors.blue),
              width: deviceSize.width * 0.9,
              height: deviceSize.height * 0.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(formatDuration(0)),
                      Expanded(
                        child: Slider(
                          value: 0,
                          onChanged: (value) {
                            player.seek(value);
                          },
                        ),
                      ),
                      Text(formatDuration(widget.song.duration)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.skip_previous_outlined),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                           isplay= player.playSong(widget.song.data, isplay);
                              
                            });
                          },
                          icon: Icon(
                            isplay == 1
                                ? Icons.play_arrow_outlined
                                : Icons.pause,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),

                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.skip_next_outlined),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
