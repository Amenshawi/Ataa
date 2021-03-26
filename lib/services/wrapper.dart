import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Ataa/screens/login_signup/login.dart';
import 'package:Ataa/screens/home_page.dart';

class Wrapper extends StatelessWidget {
  GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
  static const PrimaryColor = const Color(0xFF1c664a);
  @override
  Widget build(BuildContext context) {
    User fuser = Provider.of<User>(context);
    if (fuser == null) {
      return LoginPage();
    } else {
      return StreamProvider.value(
        value: Database.user,
        child: MaterialApp(
          navigatorKey: _homeNavigatorKey,
          theme: ThemeData(
            primaryColor: PrimaryColor,
            primarySwatch: Colors.blueGrey,
          ),
          debugShowCheckedModeBanner: false,
          title: "Ata'a",
          home: Builder(
            builder: (context) {
              return HomePage();
            },
          ),
        ),
      );
    }
  }
}
