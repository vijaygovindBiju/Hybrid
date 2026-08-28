import 'package:go_router/go_router.dart';
import 'package:hybrid/features/home/home.dart';
import 'package:hybrid/features/player/presentation/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) => const Home()),
    GoRoute(
      path: '/now-playing',
      name: 'now-playing',
      builder: (context, state) {
        final song = state.extra as SongModel;

        return NowPlaying(song: song);
      },
    ),
  ],
);
