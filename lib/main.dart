import 'package:Ataa/Screens/Login_Signup/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:Ataa/services/auth.dart';
import 'package:Ataa/services/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Ataa());
}
class Ataa extends StatelessWidget{
  GlobalKey<NavigatorState> _mainNavigatorKey = GlobalKey<NavigatorState>();
  static const PrimaryColor = const Color(0xFF1c664a);
  @override
  Widget build(BuildContext context){
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        navigatorKey: _mainNavigatorKey,
        theme: ThemeData(
        primaryColor: PrimaryColor,
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      title: "Ata'a",
        home:Builder(
          builder:(context){
            return Wrapper();
            }
          ),
      )
    );  
  }
}
