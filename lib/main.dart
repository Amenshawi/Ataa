import 'package:Ataa/SignupWidget.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/signup.dart';
import 'package:Ataa/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(Login());
}
