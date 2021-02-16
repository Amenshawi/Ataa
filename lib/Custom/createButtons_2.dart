import 'package:flutter/material.dart';
import 'Sheet.dart';

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
  bool spike;
  // BuildContext context;
  // String sheetName;
  // Widget content;

  CreateButtons({
    Key key,
    this.height,
    this.width,
    this.icon,
    this.cardName,
    this.space,
    this.spike,
    // this.context,
    // this.sheetName,
    // this.content
  }) : super(key: key);

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
        widget.space, widget.spike);
  }

  Widget customCard(double height, double width, IconData icon, String cardName,
      bool space, bool spike) {
    return
        // GestureDetector(
        //     onTap: () {
        //       print('Hi there!');
        //       // showSheet(context, sheetName, content);
        //       setState(() {
        //         _subButtons = !_subButtons;
        //       });
        //     },
        //     child: !_subButtons
        //         ?
        Container(
            height: height,
            width: width,
            child: Card(
              color: space ? ataaGreen : ataaWhite,
              elevation: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                      color: space ? ataaGold : ataaGreen,
                      size: 30,
                    ),
                    // ),
                  ),
                  // ),
                  space
                      ? Column(
                          children: [
                            Center(
                              child: Image.asset(
                                spike
                                    ? 'assets/Images/spike_3.png'
                                    : 'assets/Images/history_4.png',
                                height: 100,
                                width: 80,
                                // color: Colors.yellow.shade800,
                                color: ataaGold,
                              ),
                            ),
                            SizedBox(height: hieghtSize * 0.03)
                          ],
                        )
                      : SizedBox(height: 0),
                  Padding(
                    padding: EdgeInsets.all(widthSize * 0.02),
                    child: Text(cardName,
                        style: TextStyle(
                            color: space ? ataaGold : ataaGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ));
    //   )
    // : subButtons());
  }

// ignore: missing_return
  // showSheet(context, sheetName, content) {
  //   showModalBottomSheet(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  //       ),
  //       elevation: 100,
  //       isScrollControlled: true,
  //       builder: (BuildContext bc) {
  //         return Sheet(
  //           sheetName: sheetName,
  //           content: content,
  //         );
  //       });
  // }
}
