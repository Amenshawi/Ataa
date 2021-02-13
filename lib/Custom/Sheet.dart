// import 'donorPage_2.dart';
import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);

// ignore: must_be_immutable
class Sheet extends StatefulWidget {
  String sheetName;
  Widget content;

  Sheet({Key key, this.sheetName, this.content}) : super(key: key);

  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  // var emailController = TextEditingController();
  var charities;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // child: Align(
                    //   alignment: Alignment.topLeft,
                    Text(
                      widget.sheetName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: ataaGreen),
                    ),
                    // ),
                    // ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel_rounded,
                        size: 30,
                        color: ataaGreen,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),

            // should be implemented with the future function to keep changing with the input

            // SizedBox(height: 1),
            widget.content
          ],
        ));
  }
}
