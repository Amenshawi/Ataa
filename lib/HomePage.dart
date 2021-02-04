import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Ataa/charityStandsScreen.dart';
import 'package:Ataa/donorScreen.dart';
import 'package:Ataa/recieverScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in TabNavigationItem.items)
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

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: DonorPage(),
          icon: Icon(Icons.clean_hands),
          title: "Donate",
        ),
        TabNavigationItem(
          page: RecieverPage(),
          icon: Icon(Icons.clean_hands_outlined),
          title: "Recieve",
        ),
        TabNavigationItem(
          page: CharityStandsPage(),
          icon: Icon(Icons.store_mall_directory_rounded),
          title: "Charity Stands",
        ),
      ];
}
