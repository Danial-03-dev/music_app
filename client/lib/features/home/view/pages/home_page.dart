import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/view/pages/audios_page.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/widgets/audio_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 0;
  final assetsPath = 'assets/images';

  final pages = const [AudiosPage(), LibraryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[currentIndex],
          const Positioned(bottom: 0, child: AudioSlab()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              currentIndex == 0
                  ? '$assetsPath/home_filled.png'
                  : '$assetsPath/home_unfilled.png',
              color: currentIndex == 0
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              '$assetsPath/library.png',
              color: currentIndex == 1
                  ? Pallete.whiteColor
                  : Pallete.inactiveBottomBarItemColor,
            ),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
