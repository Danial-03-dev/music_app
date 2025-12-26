import 'package:client/core/utils/utils.dart';
import 'package:client/features/home/view/widgets/app_bars/library_app_bar.dart';
import 'package:client/features/home/view/widgets/lists/library_audio_list.dart';
import 'package:client/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(homeViewModelProvider, (_, next) {
      next?.when(
        data: (_) {},
        error: (error, st) {
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(appBar: LibraryAppBar(), body: LibraryAudioList());
  }
}
