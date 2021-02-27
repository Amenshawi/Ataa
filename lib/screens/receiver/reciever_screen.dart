import 'package:flutter/material.dart';

class RecieverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          SizedBox(height: 250),
          Center(
            child: Text("Hi there!"),
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}
