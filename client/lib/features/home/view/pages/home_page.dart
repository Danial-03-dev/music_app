import 'package:client/features/home/view/pages/audios_page.dart';
import 'package:client/features/home/view/pages/library_page.dart';
import 'package:client/features/home/view/widgets/audio_slab/audio_slab.dart';
import 'package:client/features/home/view/widgets/nav/home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final pages = const [AudiosPage(), LibraryPage()];

  void handleNavigation(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            pages[currentIndex],
            const Positioned(bottom: 0, child: AudioSlab()),
          ],
        ),

        bottomNavigationBar: HomeBottomNavBar(
          currentIndex: currentIndex,
          onTap: handleNavigation,
        ),
      ),
    );
  }
}
