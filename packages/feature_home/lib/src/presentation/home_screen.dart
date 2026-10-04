import 'dart:io';

import 'package:core_ui/core_ui.dart';
import 'package:feature_home/src/l10n/home_l10n.dart';
import 'package:feature_home/src/presentation/expanded_layout/home_screen_expanded_layout.dart';
import 'package:feature_home/src/presentation/medium_layout/home_screen_medium_layout.dart';
import 'package:feature_home/src/presentation/widgets/drawer_home.dart';
import 'package:feature_home/src/presentation/widgets/home_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.drawerItems = const []});

  /// Extra navigation entries shown in the drawer.
  final List<HomeDrawerItem> drawerItems;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: _appBarHome(context),
      drawer: DrawerHome(items: drawerItems),
      bottomNavigationBar: _BottomNavigationBar(),
      navigationRail: _MediumNavigationRailHome(),
      navigationDrawer: _ExpandedNavigationDrawerHome(),
      expandedLayout: HomeScreenExpandedLayout(),
      mediumLayout: HomeScreenMediumLayout(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FlutterLogo(
              size: context.dp(30),
            ),
          ),
          AppSpacing.md,
          Text(
            key: Key("home_title"),
            Platform.operatingSystem,
            style: context.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget? _appBarHome(BuildContext context) {
    return AppBar(
      title: Text(
        context.homeL10n.home,
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/settings'),
          icon: Icon(Icons.settings),
        )
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {},
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}

class _MediumNavigationRailHome extends StatelessWidget {
  const _MediumNavigationRailHome();

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      onDestinationSelected: (index) {},
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text("Home"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text("Profile"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text("Settings"),
        ),
      ],
    );
  }
}

class _ExpandedNavigationDrawerHome extends StatelessWidget {
  const _ExpandedNavigationDrawerHome();

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: 0,
      onDestinationSelected: (index) {},
      children: [
        CustomDrawerHeader(),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home),
          label: Text("Home"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.person),
          label: Text("Profile"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings),
          label: Text("Settings"),
        ),
      ],
    );
  }
}
