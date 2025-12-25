import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return MaterialApp(
      title: 'Audio App',
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: currentUser == null ? const LoginPage() : const HomePage(),
    );
  }
}
