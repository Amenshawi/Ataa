import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  var emailController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .65,
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  labelText: 'Enter Your Email',
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(28, 102, 74, 1))),
            ),
            SizedBox(height: 25),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color.fromRGBO(28, 102, 74, 1),
                      height: 40,
                      minWidth: 80,
                      child: Icon(
                        Icons.navigate_next,
                        color: Color.fromRGBO(244, 234, 146, 1),
                      ),
                      onPressed: () {},
                    ))),
          ],
        ));
  }
}
