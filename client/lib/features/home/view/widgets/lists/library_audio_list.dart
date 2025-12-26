import 'package:client/core/widgets/custom_scroll_config.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/list_items/library_audio_list_item.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryAudioList extends ConsumerWidget {
  const LibraryAudioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getAudioListProvider)
        .when(
          data: (data) {
            return CustomScrollConfig(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final audio = data[index];

                  return LibraryAudioListItem(audio: audio);
                },
              ),
            );
          },
          error: (error, st) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Loader();
          },
        );
  }
}
