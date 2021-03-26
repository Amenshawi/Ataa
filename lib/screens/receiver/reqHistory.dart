import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/screens/home_page.dart';
import 'package:flutter/material.dart';

class ReqHistorySheet extends StatefulWidget {
  final String type;
  final AppUser user;

  ReqHistorySheet(this.type, this.user);

  @override
  _ReqHistorySheetState createState() => _ReqHistorySheetState(type, user);
}

class _ReqHistorySheetState extends State<ReqHistorySheet> {
  double hieghtSize, widthSize;
  final String type;
  final AppUser user;

  _ReqHistorySheetState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Expanded(
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          children: List<Widget>.generate(16, (index) {
            return GridTile(
              child: new Card(
                  color: ataaGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/Images/hand_give.png', // this is only a placeHolder.
                          fit: BoxFit.contain,
                          color: ataaGold,
                        ),
                        SizedBox(height: hieghtSize * 0.04),
                        Text('Food',
                            style: TextStyle(
                                color: ataaGold,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text('Date of Donation',
                            style: TextStyle(
                                color: ataaGold,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )),
            );
          })),
    );
  }
}
