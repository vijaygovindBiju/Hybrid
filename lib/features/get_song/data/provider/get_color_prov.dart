import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/function/song_detailzation.dart';
import 'package:palette_generator_master/palette_generator_master.dart';
import 'album_cover_prov.dart';

final getColorProvider =
    FutureProvider.family<PaletteGeneratorMaster?, int>((ref, songId) async {

  final artwork = await ref.watch(albumCoverProvider(songId).future);

  if (artwork == null) {
    return null;
  }

  return await getColorCover(artwork);
});