import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/pages/upload_audio_page.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(currentUserProvider)?.token ?? '';

    void handleAddNewAudio() {
      Navigator.of(context).push(UploadAudioPage.route());
    }

    return ref
        .watch(getFavoriteAudioListProvider)
        .when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return ListTile(
                    onTap: handleAddNewAudio,
                    leading: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Pallete.backgroundColor,
                      child: Icon(CupertinoIcons.plus),
                    ),
                    title: const Text(
                      'Upload new audio',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }

                final audio = data[index];
                final imageURL = audio.imageURL;
                final audioName = audio.name;
                final artist = audio.artist;

                return ListTile(
                  onTap: () {
                    ref.read(currentAudioProvider.notifier).updateAudio(audio);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      imageURL,
                      headers: {'Authorization': 'Bearer $token'},
                    ),
                    radius: 32,
                    backgroundColor: Pallete.backgroundColor,
                  ),
                  title: Text(
                    audioName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    artist,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                );
              },
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
