import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hybrid/features/get_song/Presentation/widget/show_song.dart';
import 'package:hybrid/features/get_song/data/provider/getSong_prov.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(),
      body: Column(
        children: [
          switch (ref.watch(getSongProvider)) {
            AsyncError() => const Text("Sorry can't fetch song"),
            AsyncData(:final value) =>
              value.isEmpty
                  ? Text("Sorry no song")
                  : Expanded(
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ShowSong(song: value[index]);
                        },
                      ),
                    ),

            _ => Center(child: CircularProgressIndicator()),
          },
        ],
      ),
    );
  }
}
