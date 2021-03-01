import 'package:Ataa/screens/donor/donor_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Ataa/screens/charity/charity_stands_screen.dart';
import 'package:Ataa/screens/receiver/reciever_screen.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
          page: DonorPage(user),
          icon: Icon(FontAwesome5.handshake),
          title: "Donate",
        ),
        TabNavigationItem(
          page: RecieverPage(),
          icon: Icon(
            Icons.shopping_bag_outlined,
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
        )
      ];

  static getNavBar(_currentIndex, user, update) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) => update(index),
      items: [
        for (final tabItem in TabNavigationItem.items(user))
          BottomNavigationBarItem(
            icon: tabItem.icon,
            label: tabItem.title,
          )
      ],
    );
  }
}
