import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/data/provider/album_cover_prov.dart';
import 'package:hybrid/features/get_song/function/song_detailzation.dart';
import 'package:hybrid/features/player/data/provider/player_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends ConsumerStatefulWidget {
  final SongModel song;

  const NowPlaying({
    super.key,
    required this.song,
  });

  @override
  ConsumerState<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends ConsumerState<NowPlaying> {
  @override
  void initState() {
    super.initState();

    final playerState = ref.read(playerProvider);

    if (playerState.nowPlaying?.id != widget.song.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        ref.read(playerProvider.notifier).playSong(widget.song);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final playerState = ref.watch(playerProvider);

    final durationMs = widget.song.duration ?? 0;
    final durationSeconds = durationMs > 0 ? durationMs / 1000 : 1.0;

    final currentSeconds = playerState.currentPosition.inMilliseconds / 1000;

    final sliderValue = currentSeconds.clamp(
      0.0,
      durationSeconds,
    );

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                              ),
                            ),

                            const Expanded(
                              child: Center(
                                child: Text(
                                  'Now Playing',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      LayoutBuilder(
                        builder: (context, constraints) {
                          final coverSize =
                              (constraints.maxWidth * 0.85).clamp(
                            180.0,
                            360.0,
                          );

                          return SizedBox(
                            width: coverSize,
                            height: coverSize,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: _buildAlbumCover(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 35),

                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.song.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              _artistName(widget.song.artist),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      Column(
                        children: [
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                              overlayShape:
                                  const RoundSliderOverlayShape(
                                overlayRadius: 14,
                              ),
                            ),
                            child: Slider(
                              min: 0,
                              max: durationSeconds,
                              value: sliderValue,
                              onChanged: durationMs <= 0
                                  ? null
                                  : (value) {
                                      ref
                                          .read(playerProvider.notifier)
                                          .seek(value);
                                    },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDuration(
                                    playerState.currentPosition
                                        .inMilliseconds,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  formatDuration(widget.song.duration),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          _PlayerButton(
                            icon: Icons.skip_previous_rounded,
                            onPressed: () {
                            },
                          ),

                          _PlayerButton(
                            size: 72,
                            iconSize: 36,
                            icon: playerState.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            onPressed: () {
                              final notifier =
                                  ref.read(playerProvider.notifier);

                              if (playerState.isPlaying) {
                                notifier.pauseSong();
                              } else {
                                notifier.resume();
                              }
                            },
                          ),

                          _PlayerButton(
                            icon: Icons.skip_next_rounded,
                            onPressed: () {
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.song.album ?? 'Unknown Album',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAlbumCover() {
    return ref.watch(albumCoverProvider(widget.song.id)).when(
          loading: () {
            return Image.asset(
              'assets/images/no_cover.png',
              fit: BoxFit.cover,
            );
          },
          error: (_, __) {
            return Image.asset(
              'assets/images/no_cover.png',
              fit: BoxFit.cover,
            );
          },
          data: (value) {
            if (value == null || value.isEmpty) {
              return Image.asset(
                'assets/images/no_cover.png',
                fit: BoxFit.cover,
              );
            }

            return Image.memory(
              value,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            );
          },
        );
  }

  String _artistName(String? artist) {
    if (artist == null ||
        artist.trim().isEmpty ||
        artist == '<unknown>') {
      return 'Unknown Artist';
    }

    return artist;
  }
}
class _PlayerButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;

  const _PlayerButton({
    required this.icon,
    required this.onPressed,
    this.size = 58,
    this.iconSize = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.black12,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}