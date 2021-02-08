import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

// ignore: must_be_immutable
class CreateButtons extends StatefulWidget {
  double height, width;
  IconData icon;
  String cardName;
  bool space;

  CreateButtons(
      {Key key, this.height, this.width, this.icon, this.cardName, this.space})
      : super(key: key);

  @override
  _CreateButtonsState createState() => _CreateButtonsState();
}

class _CreateButtonsState extends State<CreateButtons> {
  double hieghtSize, widthSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return customCard(widget.height, widget.width, widget.icon, widget.cardName,
        widget.space);
  }

  Widget customCard(
      double height, double width, IconData icon, String cardName, bool space) {
    return GestureDetector(
      onTap: () {
        print('Hi there!');
      },
      child: Container(
        height: height,
        width: width,
        child: Card(
          color: ataaWhite,
          elevation: 100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: hieghtSize * 0.01, right: widthSize * 0.03),
                // child: Expanded(
                // child: Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)),
                //   // color: ataaGreen,
                //   // elevation: 8,
                //   child:
                child: Icon(
                  icon,
                  color: ataaGreen,
                  size: 30,
                ),
                // ),
              ),
              // ),
              space ? SizedBox(height: hieghtSize * 0.15) : SizedBox(height: 0),
              Padding(
                padding: EdgeInsets.all(widthSize * 0.02),
                child: Text(cardName,
                    style: TextStyle(
                        color: ataaGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
