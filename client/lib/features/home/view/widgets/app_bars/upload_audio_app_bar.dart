import 'package:client/core/widgets/loader.dart';
import 'package:client/features/home/view/widgets/buttons/custom_icon_button.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadAudioAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onUpload;
  const UploadAudioAppBar({super.key, this.onUpload});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(
      homeViewModelProvider.select((value) => value?.isLoading == true),
    );

    return AppBar(
      title: const Text('Upload Song'),
      actions: [
        isLoading
            ? const Loader()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomIconButton(
                  onPressed: onUpload,
                  icon: Icons.check,
                  iconSize: 24,
                ),
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
