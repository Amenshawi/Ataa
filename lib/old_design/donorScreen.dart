// ignore: non_constant_identifier_names
import 'package:Ataa/auth.dart';
import 'package:Ataa/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Ataa/searchSheet.dart';
import 'package:Ataa/appUser.dart';
import 'package:Ataa/profilePage.dart';
import 'package:Ataa/Login_Signup/login.dart';

final Color backgroundColor = Colors.white;
final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);

class DonorScreen extends StatefulWidget {
  final AppUser user;
  DonorScreen(this.user);
  @override
  _DonorScreenState createState() => _DonorScreenState(user);
}

class _DonorScreenState extends State<DonorScreen>
    with SingleTickerProviderStateMixin {
  final AppUser user;
  final _auth = AuthService();
  _DonorScreenState(this.user);
  bool isCollapsed = true;
  double hieghtSize, widthSize;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
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
      backgroundColor: backgroundColor,
      body: Stack(
        children: [menu(context, user), donorPage(context)],
      ),
    );
  }

  Widget donorPage(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * widthSize,
      right: isCollapsed ? 0 : -0.6 * widthSize,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: Container(
            padding: EdgeInsets.only(top: 35),
            width: double.infinity,
            color: ataaGreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [menuIcon(), barName(), search(context)],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: welcomeMessage(),
                ),
                SizedBox(height: 20),
                donorButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hello ' + user.fname,
            style: TextStyle(
                color: Color.fromRGBO(244, 234, 146, 1), fontSize: 40)),
        SizedBox(height: 10),
        Text('welcome back :)',
            style: TextStyle(
                color: Color.fromRGBO(244, 234, 146, 1), fontSize: 20)),
      ],
    );
  }

  Widget barName() {
    return Text(
      "Donate Page",
      style: TextStyle(
          color: Color.fromRGBO(244, 234, 146, 1),
          fontWeight: FontWeight.bold,
          fontSize: 25),
    );
  }

  Widget search(context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Color.fromRGBO(244, 234, 146, 1),
              size: 30,
            ),
            onPressed: () {
              // print('Hi there');
              searchSheet(context);
              // print('Hi there 2');
            },
          ),
        ));
  }

  button(String name, IconData icon) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: ataaGreen),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(10),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Column(
              children: [
                Icon(icon, color: ataaGreen, size: 60),
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ataaGreen),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            onTap: () {
              print("See you next week :)");
            },
          ),
        ));
  }

  void searchSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 100,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SearchSheet();
        });
  }

  Widget menuIcon() {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: Color.fromRGBO(244, 234, 146, 1),
        size: 35,
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
    );
  }

  Widget menu(context, user) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding:
              EdgeInsets.only(left: widthSize * 0.05, top: hieghtSize * 0.1),
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
                        backgroundColor: ataaGreen,
                        child: Text(
                          user.fname[0] + user.lname[0],
                          style: TextStyle(
                              color: Color.fromRGBO(244, 234, 146, 1)),
                        ),
                      ),
                      SizedBox(height: hieghtSize * 0.02),
                      Text(
                        user.fname + ' ' + user.lname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ataaGreen),
                      ),
                    ],
                  ),
                ),
                category('Profile', Icons.person, () {
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
                  try {
                    final result = _auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  } catch (error) {}
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
          color: ataaGreen,
          size: 30,
        ),
        SizedBox(width: hieghtSize * 0.02),
        Text(name, style: TextStyle(color: ataaGreen, fontSize: 22)),
      ]),
      onTap: () {
        function();
      },
    );
  }

  Widget donorButtons() {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: Column(
              children: [
                SizedBox(height: 10),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: [
                            button("Make a donation", Icons.add),
                            button("Schedul a donation", Icons.timer),
                            button("Donations History", Icons.menu_book),
                            button("Cancel Donation", Icons.cancel),
                          ],
                        )))
              ],
            )));
  }
}
