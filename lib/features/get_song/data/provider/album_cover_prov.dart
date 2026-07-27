import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/function/fetch_songs.dart';

final albumCoverProvider = FutureProvider.family<Uint8List?, int>(
  (ref, id) async {
    return FetchSongs().artWork(id);
  },
);