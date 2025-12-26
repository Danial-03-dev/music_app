import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;

  const HomeBottomNavBar({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    final assetsPath = 'assets/images';

    Color getNavItemColor(int order) {
      return currentIndex == order
          ? Pallete.whiteColor
          : Pallete.inactiveBottomBarItemColor;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            currentIndex == 0
                ? '$assetsPath/home_filled.png'
                : '$assetsPath/home_unfilled.png',
            color: getNavItemColor(0),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            '$assetsPath/library.png',
            color: getNavItemColor(1),
          ),
          label: 'Library',
        ),
      ],
    );
  }
}
