import 'package:client/features/home/view/pages/upload_audio_page.dart';
import 'package:client/features/home/view/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LibraryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibraryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    void handleAddNewAudio() {
      Navigator.of(context).push(UploadAudioPage.route());
    }

    return AppBar(
      title: Text('Library'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomIconButton(
            onPressed: handleAddNewAudio,
            icon: CupertinoIcons.plus,
            iconSize: 24,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
