import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.tabsRouter,
  });

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: tabsRouter.activeIndex,
      onDestinationSelected: tabsRouter.setActiveIndex,
      // indicatorColor: Colors.transparent,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        // NavigationDestination(
        //   icon: Icon(Icons.search_outlined),
        //   selectedIcon: Icon(Icons.search),
        //   label: 'Search',
        // ),
        // NavigationDestination(
        //   icon: Icon(Icons.person_outline),
        //   selectedIcon: Icon(Icons.person),
        //   label: 'Profile',
        // ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
