import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/models/audio_model.dart';
import 'package:client/core/widgets/buttons/custom_icon_button.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteAudioButton extends ConsumerStatefulWidget {
  final AudioModel? audio;

  const DeleteAudioButton({super.key, this.audio});

  @override
  ConsumerState<DeleteAudioButton> createState() => _DeleteAudioButtonState();
}

class _DeleteAudioButtonState extends ConsumerState<DeleteAudioButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 24;

    void handleDeleteAudio() async {
      if (widget.audio == null) return;
      setState(() {
        loading = true;
      });
      await ref.read(homeViewModelProvider.notifier).deleteAudio(widget.audio!);
      setState(() {
        loading = false;
      });
    }

    return loading
        ? const SizedBox(width: iconSize, height: iconSize, child: Loader())
        : CustomIconButton(
            onPressed: handleDeleteAudio,
            icon: Icons.delete,
            iconSize: iconSize,
            color: Pallete.errorColor,
          );
  }
}
