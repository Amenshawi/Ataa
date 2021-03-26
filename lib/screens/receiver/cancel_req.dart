import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class CancelReq extends StatefulWidget {
  final String type;
  final AppUser user;
  CancelReq(this.type, this.user);
  @override
  _CancelReqState createState() => _CancelReqState(type, user);
}

class _CancelReqState extends State<CancelReq> {
  final database = Database();
  double heightSize, widthSize;
  final String type;
  final AppUser user;
  String title = 'Food';
  String subTitle = 'Date of Donation';
  bool isOpen = false;
  // final _slidableKey = GlobalKey<SlidableState>();

  _CancelReqState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    return Container(
      width: widthSize,
      height: heightSize * 0.65,
      child: Card(
        color: ataaWhite,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                color: ataaGreen,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Slidable(
                    key: ValueKey(index),
                    // key: _slidableKey,
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Cancel',
                        color: Colors.red,
                        icon: Icons.delete_forever_rounded,
                        closeOnTap: false,
                        onTap: () {
                          Toast.show('Cancel on $index', context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        },
                      )
                    ],
                    dismissal:
                        SlidableDismissal(child: SlidableDrawerDismissal()),
                    child: ListTile(
                      title: Text(
                        title,
                        style: TextStyle(color: ataaGold, fontSize: 20),
                      ),
                      subtitle: Text(
                        subTitle,
                        style: TextStyle(color: ataaGold),
                      ),
                      leading: Icon(Icons.edit, color: ataaGold, size: 25),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 25),
                        color: ataaGold,
                        // size: 25,

                        // this is for when the user press on the arrow icon it will open to him instead of doing nothing.
                        // but i had an issue with Multiple Widgets used the same GlobalKey

                        onPressed: () {
                          // setState(() {
                          //   if (isOpen) {
                          //     _slidableKey.currentState.close();
                          //     isOpen = !isOpen;
                          //   } else {
                          //     _slidableKey.currentState.open(
                          //         actionType:
                          //             SlideActionType.secondary);
                          //     isOpen = !isOpen;
                          //   }
                          // });
                          print('Hi');
                        },
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
