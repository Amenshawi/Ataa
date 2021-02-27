import 'dart:async';
import 'package:Ataa/Screens/Login_Signup/login.dart';
import 'package:Ataa/Services/auth.dart';
import 'package:Ataa/Screens/profile_page.dart';
import 'package:Ataa/Models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/Screens/navigation_page.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);
// var _currentIndex = 0;

// ignore: must_be_immutable
class CustomPage extends StatefulWidget {
  final AppUser user;

  @override
  CustomPage(this.user);

  @override
  _CustomPageState createState() => _CustomPageState(user);
}

class _CustomPageState extends State<CustomPage>
    with SingleTickerProviderStateMixin {
  void _update(int index) {
    // setState(() => _currentIndex = index);
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        pageName = 'Donate';
        isCharityStand = false;
      } else if (index == 1) {
        pageName = 'Receive';
        isCharityStand = false;
      } else {
        pageName = 'Charity Stand';
        isCharityStand = true;
      }
    });
  }

  double hieghtSize, widthSize;
  final AppUser user;
  final _auth = AuthService();
  // _DonorScreenState(this.user);
  bool isCollapsed = true;
  // double hieghtSize, widthSize;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  int _currentIndex = 0;
  String pageName = 'Donate';
  bool isCharityStand = false;

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
      backgroundColor: ataaGreen,
      body: customBody(context),
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
                                  FocusScope.of(context).unfocus();
                                  Timer(Duration(milliseconds: 300), () {
                                    setState(() {
                                      if (isCollapsed)
                                        _controller.forward();
                                      else
                                        _controller.reverse();
                                      isCollapsed = !isCollapsed;
                                    });
                                  });
                                },
                              ),
                            ),
                            isCharityStand
                                ? SizedBox(width: widthSize * 0.1)
                                : SizedBox(width: widthSize * 0.2),
                            Text(pageName,
                                style: TextStyle(
                                    color: ataaGreen,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      SizedBox(height: hieghtSize * 0.004),
                      message('Hi ' + user.fname, 30),
                      message('Welcome Back', 22),
                      SizedBox(height: hieghtSize * 0.02),
                      IndexedStack(index: _currentIndex, children: [
                        for (final tabItem in TabNavigationItem.items(user))
                          tabItem.page,
                      ]),
                      SizedBox(height: hieghtSize * 0.05),
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
                          user.fname[0] + user.lname[0],
                          style: TextStyle(color: ataaGreen),
                        ),
                      ),
                      SizedBox(height: hieghtSize * 0.02),
                      Text(
                        user.fname + " " + user.lname,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext bctx) => Profile(user)));
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
                  _auth.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext bctx) => Login()));
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
}
