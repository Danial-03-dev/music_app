import 'package:client/core/providers/current_audio/current_audio_notifier.dart';
import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/features/home/view/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryAudioListItem extends ConsumerWidget {
  final AudioModel audio;

  const LibraryAudioListItem({super.key, required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.read(currentUserProvider)?.token ?? '';

    final imageURL = audio.imageURL;
    final audioName = audio.name;
    final artist = audio.artist;

    void handlePlayAudio() {
      ref.read(currentAudioProvider.notifier).updateAudio(audio);
    }

    return ListTile(
      onTap: handlePlayAudio,
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
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
      subtitle: Text(
        artist,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      ),
      trailing: CustomIconButton(
        onPressed: () {},
        icon: Icons.delete_rounded,
        iconSize: 24,
        color: Pallete.errorColor,
      ),
    );
  }
}
