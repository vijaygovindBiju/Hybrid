import 'dart:typed_data';
import 'package:palette_generator_master/palette_generator_master.dart';

import 'package:flutter/material.dart';

String formatDuration(int? duration) {
  // to convert to mill second to min adn sec
  if (duration == null) return "00:00";

  final minutes = duration ~/ 60000;
  final seconds = (duration % 60000) ~/ 1000;

  return "$minutes:${seconds.toString().padLeft(2, '0')}";
}

Future<PaletteGeneratorMaster?> getColorCover(Uint8List? artwork) async {
  if (artwork != null) {
    return await PaletteGeneratorMaster.fromImageProvider(MemoryImage(artwork));
  }
  return null;
}
