import 'package:Ataa/Custom/Sheet.dart';
import 'package:Ataa/Custom/create_buttons.dart';
import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/screens/receiver/cancel_req.dart';
import 'package:Ataa/screens/receiver/reqForm.dart';
import 'package:Ataa/screens/receiver/reqHistory.dart';
import 'package:Ataa/screens/receiver/search_req.dart';
import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);

// ignore: must_be_immutable
class RecieverPage extends StatefulWidget {
  AppUser user;
  String type;

  @override
  _RecieverPageState createState() => _RecieverPageState(type, user);
}

class _RecieverPageState extends State<RecieverPage> {
  double hieghtSize, widthSize;
  final String type;
  final AppUser user;

  var changeLocation;

  _RecieverPageState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: hieghtSize * 0.07),
              GestureDetector(
                onTap: () {
                  showSheet(context, 'Request a Donation', ReqForm(), false);
                },
                child: CreateButtons(
                  height: hieghtSize * 0.3,
                  width: widthSize * 0.4,
                  icon: Icons.add,
                  cardName: 'Request A Donation',
                  space: true,
                  spike: true,
                ),
              ),
              GestureDetector(
                child: CreateButtons(
                  height: hieghtSize * 0.15,
                  width: widthSize * 0.4,
                  icon: Icons.delete_forever,
                  cardName: 'Cancel A Request',
                  space: false,
                  spike: false,
                ),
                onTap: () {
                  showSheet(context, 'Cancel a Request', CancelReq(type, user),
                      false);
                },
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: hieghtSize * 0.07),
              GestureDetector(
                onTap: () {
                  showSheet(context, 'Search', SearchReq(type, user), false);
                },
                child: CreateButtons(
                  height: hieghtSize * 0.15,
                  width: widthSize * 0.4,
                  icon: Icons.search,
                  cardName: 'Search Requests',
                  space: false,
                  spike: false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showSheet(context, 'History',
                      ReqHistorySheet('History', user), false);
                },
                child: CreateButtons(
                  height: hieghtSize * 0.3,
                  width: widthSize * 0.4,
                  icon: Icons.menu_book_rounded,
                  cardName: 'Request History',
                  space: true,
                  spike: false,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  showSheet(context, sheetName, content, padding) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 100,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Sheet(
            sheetName: sheetName,
            content: content,
            padding: padding,
          );
        });
  }
}
