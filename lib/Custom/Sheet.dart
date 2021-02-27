import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);

// ignore: must_be_immutable
class Sheet extends StatefulWidget {
  String sheetName;
  Widget content;
  bool padding = false;

  Sheet({Key key, this.sheetName, this.content, this.padding})
      : super(key: key);

  @override
  _SheetState createState() => _SheetState();
}

class _SheetState extends State<Sheet> {
  var charities;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        margin: EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: widget.padding
                      ? MediaQuery.of(context).size.height * 0.02
                      : MediaQuery.of(context).size.height * 0.05),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.sheetName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: ataaGreen),
                    ),
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

            widget.content
          ],
        ));
  }
}
