import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Ataa/charityStandsScreen.dart';
import 'package:Ataa/recieverScreen.dart';
import 'package:Ataa/donorScreen.dart';
import 'package:Ataa/appUser.dart';

class HomePage extends StatefulWidget {
  final AppUser user;
  HomePage(@required this.user);
  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final AppUser user;
  _HomePageState(@required this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items(user)) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items(user))
            BottomNavigationBarItem(
              icon: tabItem.icon,
              label: tabItem.title,
            )
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;
  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> items(user) => [
        TabNavigationItem(
          page: DonorScreen(user),
          icon: Icon(
            Icons.clean_hands,
            size: 40,
          ),
          title: "Donate",
        ),
        TabNavigationItem(
          page: RecieverPage(),
          icon: Icon(
            Icons.clean_hands_outlined,
            size: 40,
          ),
          title: "Recieve",
        ),
        TabNavigationItem(
          page: CharityStandsPage(),
          icon: Icon(
            Icons.store_mall_directory_rounded,
            size: 40,
          ),
          title: "Charity Stands",
        ),
      ];
}
