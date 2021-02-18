import 'package:Ataa/Donor/donorPage_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Ataa/Charity/charityStandsScreen.dart';
import 'package:Ataa/Receiver/recieverScreen.dart';
import 'package:Ataa/appUser.dart';
import 'custom/customPage_2.dart';
import 'package:flutter_icons/flutter_icons.dart';

// class HomePage extends StatefulWidget {
//   final AppUser user;
//   HomePage(this.user);
//   @override
//   _HomePageState createState() => _HomePageState(user);
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final AppUser user;
//   _HomePageState(this.user);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: [
//           for (final tabItem in TabNavigationItem.items(user)) tabItem.page,
//         ],
//       ),
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: _currentIndex,
//       //   onTap: (int index) => setState(() => _currentIndex = index),
//       //   items: [
//       //     for (final tabItem in TabNavigationItem.items(user))
//       //       BottomNavigationBarItem(
//       //           icon: tabItem.icon,
//       //           label: tabItem.title,
//       //           backgroundColor: Colors.green)
//       //   ],
//       // ),
//     );
//   }
// }
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
          page: DonorPage_2(user),
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
