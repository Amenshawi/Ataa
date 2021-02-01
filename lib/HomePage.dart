import 'package:Ataa/HomePage.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page!"),
        backgroundColor: Color.fromRGBO(28, 102, 74, 1),
      ),
      body: Container(
        color: Colors.white70,
        child: Center(
          child: Text("Hi there!"),
        ),
      ),
    );
  }
}
