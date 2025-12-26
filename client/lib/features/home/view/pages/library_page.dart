import 'package:client/features/home/view/widgets/app_bars/library_app_bar.dart';
import 'package:client/features/home/view/widgets/lists/library_audio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(appBar: LibraryAppBar(), body: LibraryAudioList());
  }
}
