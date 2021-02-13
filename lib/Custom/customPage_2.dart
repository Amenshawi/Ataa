import 'package:Ataa/Charity/charityStandsScreen.dart';
import 'package:Ataa/Donor/donorPage_2.dart';
import 'package:Ataa/Receiver/recieverScreen.dart';
import 'package:Ataa/appUser.dart';
import 'package:flutter/material.dart';
import '../NavigationPage.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);
var _currentIndex = 0;

// ignore: must_be_immutable
class CustomPage extends StatefulWidget {
  final AppUser user;
  bool isCharityStand = false;

  @override
  CustomPage(@required this.user);

  @override
  _CustomPageState createState() => _CustomPageState(user);
}

class _CustomPageState extends State<CustomPage>
    with SingleTickerProviderStateMixin {
  void _update(int index) {
    print('from: ' + _currentIndex.toString());
    print('to: ' + index.toString());
    setState(() => _currentIndex = index);
  }

  double hieghtSize, widthSize;
  final AppUser user;
  // _DonorScreenState(this.user);
  bool isCollapsed = true;
  // double hieghtSize, widthSize;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  // int _currentIndex = 0;

  // ignore: invalid_required_positional_param
  _CustomPageState(@required this.user);

  // _CustomPageState(this.user);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     onTap: (int index) => setState(() => _currentIndex = index),
      //     items: [
      //       for (final tabItem in TabNavigationItem.items(user))
      //         BottomNavigationBarItem(
      //             icon: tabItem.icon,
      //             label: tabItem.title,
      //             backgroundColor: Colors.green)
      //     ]),
      backgroundColor: ataaGreen,
      body: customBody(context),
      /* bottomNavigationBar: BottomNavyBar(
                           curve: Curves.easeIn,
                           containerHeight: 65,
                           selectedIndex: _currentIndex,
                           onItemSelected: (int index) {
                             setState(() {
                               _currentIndex = index;
                             });
                           },
                           items: [
                             BottomNavyBarItem(
                                 icon: Icon(Icons.clean_hands),
                                title: Text('Donate'),
                                 activeColor: ataaGreen,
                                 inactiveColor: ataaGreenField),
                            BottomNavyBarItem(
                                 icon: Icon(Icons.clean_hands),
                                title: Text('Donate'),
                               activeColor: ataaGreen,
                                 inactiveColor: ataaGreenField),
                            BottomNavyBarItem(
                                icon: Icon(Icons.local_post_office),
                                title: Text('Charity Stands'),
                                activeColor: ataaGreen,
                                inactiveColor: ataaGreenField,
                            ),
                          ],
                          ),*/
    );
  }

  Widget customBody(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Stack(children: [
        menu(context),
        AnimatedPositioned(
          duration: duration,
          top: 0,
          bottom: 0,
          left: isCollapsed ? 0 : 0.6 * widthSize,
          right: isCollapsed ? 0 : -0.4 * widthSize,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: isCollapsed ? Radius.zero : Radius.circular(40),
                  bottomLeft: isCollapsed ? Radius.zero : Radius.circular(40)),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.only(top: hieghtSize * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(widthSize * 0.05),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: ataaGreen,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isCollapsed)
                                      _controller.forward();
                                    else
                                      _controller.reverse();
                                    isCollapsed = !isCollapsed;
                                  });
                                },
                              ),
                            ),
                            widget.isCharityStand
                                ? SizedBox(width: widthSize * 0.1)
                                : SizedBox(width: widthSize * 0.2),
                            // Padding(
                            //     padding:
                            //         EdgeInsets.only(right: widthSize * 0.32),
                            // child:
                            Text('test',
                                style: TextStyle(
                                    color: ataaGreen,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: hieghtSize * 0.004),
                      message('Hi Abadi', 30),
                      message('Welcome Back', 22),
                      SizedBox(height: hieghtSize * 0.02),

                      // Container(
                      //   child: Center(
                      //     child: Text('Hi'),
                      //   ),
                      // ),

                      // Container(
                      //   // height: hieghtSize * 0.15,
                      //   // width: widthSize * 0.9,
                      //   padding: EdgeInsets.all(15),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(80)),
                      //   child: BottomNavigationBar(
                      //     backgroundColor: ataaWhite,
                      //       currentIndex: _currentIndex,
                      //       onTap: (int index) =>
                      //           setState(() => _currentIndex = index),
                      //       items: [
                      //         for (final tabItem in TabNavigationItem.items(user))
                      //           BottomNavigationBarItem(
                      //               icon: tabItem.icon,
                      //               label: tabItem.title,
                      //               backgroundColor: Colors.green)
                      //       ]),
                      // )
                      /*BottomNavyBar(
                           curve: Curves.easeIn,
                           containerHeight: 50,
                           selectedIndex: _currentIndex,
                           onItemSelected: (int index) {
                             setState(() {
                               _currentIndex = index;
                             });
                           },
                           items: [
                             BottomNavyBarItem(
                                 icon: Icon(Icons.clean_hands),
                                title: Text('Donate'),
                                 activeColor: ataaGreen,
                                 inactiveColor: ataaGreenField),
                            BottomNavyBarItem(
                                 icon: Icon(Icons.clean_hands),
                                title: Text('Donate'),
                               activeColor: ataaGreen,
                                 inactiveColor: ataaGreenField),
                            BottomNavyBarItem(
                                icon: Icon(Icons.local_post_office),
                                title: Text('Charity Stands'),
                                activeColor: ataaGreen,
                                inactiveColor: ataaGreenField,
                            ),
                          ],
                          ),*/

                      //),
                      // ),

                      // BottomNavigationBar(
                      //   currentIndex: _currentIndex,
                      //   onTap: (int index) =>
                      //       setState(() => _currentIndex = index),
                      //   items: [
                      //     for (final tabItem in TabNavigationItem.items(user))
                      //       BottomNavigationBarItem(
                      //           icon: tabItem.icon,
                      //           label: tabItem.title,
                      //           backgroundColor: Colors.green)
                      //   ],
                      // ),
                      IndexedStack(index: _currentIndex, children: [
                        for (final tabItem in TabNavigationItem.items(user))
                          tabItem.page,
                      ]),
                      SizedBox(height: hieghtSize * 0.06),
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: TabNavigationItem.getNavBar(
                              _currentIndex, user, this._update),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget message(String msg, double size) {
    return Padding(
      padding: EdgeInsets.only(left: widthSize * 0.08),
      child: Text(
        msg,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size, color: ataaGreen),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding:
              EdgeInsets.only(left: widthSize * 0.05, top: hieghtSize * 0.15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: hieghtSize * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        // we can put a condition here if the user doesn't have a pic in the database, we will use his/her initails.
                        backgroundColor: ataaGold,
                        child: Text(
                          'AA',
                          // user.fname[0] + user.lname[0],
                          style: TextStyle(color: ataaGreen),
                        ), // just the user initials.
                      ),
                      SizedBox(height: hieghtSize * 0.02),
                      Text(
                        'Hi',
                        // user.fname +
                        // ' ' +
                        // user.lname, // User name (sorry i didn't do it :) )
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ataaGold),
                      ),
                    ],
                  ),
                ),
                category('Profile', Icons.person, () {
                  // navigate to the profile page
                }),
                SizedBox(height: hieghtSize * 0.02),
                category('History', Icons.history, () {
                  // navigate to the profile page
                }),
                SizedBox(height: hieghtSize * 0.02),
                category('About us', Icons.people, () {
                  // navigate to the profile page
                }),
                SizedBox(height: hieghtSize * 0.02),
                // category('Profile', Icons.person, () {
                //   // navigate to the profile page
                // }),
                SizedBox(height: hieghtSize * 0.3),
                category('Log Out', Icons.logout, () {
                  // navigate to the profile page
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget category(String name, IconData icon, Function function) {
    return InkWell(
      child: Row(children: [
        Icon(
          icon,
          color: ataaGold,
          size: 30,
        ),
        SizedBox(width: hieghtSize * 0.02),
        Text(name, style: TextStyle(color: ataaGold, fontSize: 22)),
      ]),
      onTap: () {
        function();
      },
    );
  }

  // Widget customNavBar() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: hieghtSize * 0.03),
  //     child: Card(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       elevation: 8,
  //       // child: Expanded(
  //       // child: Padding(
  //       //   padding:
  //       //       EdgeInsets.only(left: widthSize * 0.04, top: hieghtSize * 0.02),
  //       child: Padding(
  //         padding: EdgeInsets.only(top: hieghtSize * 0.01),
  //         child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //           SizedBox(width: 1),
  //           customTabBar(Icons.clean_hands, 'Donate'),
  //           SizedBox(width: 50),
  //           customTabBar(Icons.clean_hands_outlined, 'Recieve'),
  //           SizedBox(width: 25),
  //           customTabBar(Icons.store_mall_directory_rounded, 'Charity Stands')
  //         ]),
  //       ),
  //       // ),
  //       // ),
  //     ),
  //   );
  // }

  // Widget customTabBar(IconData icon, String name) {
  //   return Column(
  //     children: [
  //       IconButton(
  //         icon: Icon(icon, size: 35, color: ataaGreen),
  //         onPressed: () {},
  //       ),
  //       Text(
  //         name,
  //         style: TextStyle(
  //             color: ataaGreen, fontSize: 15, fontWeight: FontWeight.bold),
  //       )
  //     ],
  //   );
  // }

}
