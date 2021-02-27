import 'package:Ataa/Models/app_user.dart';
import 'package:Ataa/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class EditSheet extends StatefulWidget {
  final String type;
  final AppUser user;
  EditSheet(this.type, this.user);
  @override
  _EditSheetState createState() => _EditSheetState(type, user);
}

class _EditSheetState extends State<EditSheet> {
  final database = Database();
  double heightSize, widthSize;
  final String type;
  final AppUser user;
  _EditSheetState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    return Container(
      width: widthSize,
      height: heightSize * 0.7,
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
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Pause',
                        color: ataaWhite,
                        icon: Icons.pause,
                        closeOnTap: false,
                        onTap: () {
                          Toast.show(
                            'Pause on $index',
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM,
                          );
                        },
                      ),
                      IconSlideAction(
                        caption: 'Terminate',
                        color: Colors.red,
                        icon: Icons.delete_forever_rounded,
                        closeOnTap: false,
                        onTap: () {
                          Toast.show('Terminate on $index', context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        },
                      )
                    ],
                    dismissal:
                        SlidableDismissal(child: SlidableDrawerDismissal()),
                    child: ListTile(
                      title: Text(
                        "Food",
                        style: TextStyle(color: ataaGold, fontSize: 20),
                      ),
                      subtitle: Text(
                        'Date of donation',
                        style: TextStyle(color: ataaGold),
                      ),
                      leading: Icon(Icons.edit, color: ataaGold, size: 25),
                      trailing: Icon(
                        Icons.arrow_back_ios,
                        color: ataaGold,
                        size: 25,
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
