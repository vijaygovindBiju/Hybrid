import 'package:flutter/material.dart';

class ShowSong extends StatelessWidget {
  /// Return song [id]
  int id;

  /// Return song [data]
  String data;

  /// Return song [uri]
  String? uri;

  /// Return song [displayName]
  String displayName;

  /// Return song [displayName] without Extension
  String displayNameWOExt;

  /// Return song [size]
  int size;

  /// Return song [album]
  String? album;

  /// Return song [albumId]
  int? albumId;

  /// Return song [artist]
  String? artist;

  /// Return song [artistId]
  int? artistId;

  ShowSong({
    super.key,
    required this.id,
    required this.uri,
    required this.data,
    required this.displayName,
    required this.displayNameWOExt,
    required this.size,
    required this.album,
    required this.albumId,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      children: [
        Text("Id $id"),
        Text("Data $data"),
        Text("Display name $displayName")
      ],
    ));
  }
}
