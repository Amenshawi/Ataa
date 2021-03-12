import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/models/periodic_donation.dart';
import 'package:Ataa/services/database.dart';
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
  var donations;
  _EditSheetState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;
    donations = database.fetchPeriodcDonations(user).whenComplete(() {
      setState(() {});
    });
    return Container(
        width: widthSize,
        height: heightSize * 0.7,
        child: Card(
          color: ataaWhite,
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: FutureBuilder(
              future: donations,
              builder: (context, snapshot) {
                donations = snapshot.data;
                return donations == null
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(244, 234, 146, 1),
                          valueColor: AlwaysStoppedAnimation(
                              Color.fromRGBO(28, 102, 74, 1)),
                        ),
                      )
                    : ListView.builder(
                        itemCount: donations.length,
                        itemBuilder: (context, int index) {
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
                                      database.PauseDonation(
                                          donations[index].pdid);
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
                                dismissal: SlidableDismissal(
                                    child: SlidableDrawerDismissal()),
                                child: ListTile(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          donations[index].type,
                                          style: TextStyle(
                                              color: ataaGold, fontSize: 20),
                                        ),
                                        Text(
                                          donations[index].status,
                                          style: TextStyle(
                                              color: ataaGold, fontSize: 20),
                                        )
                                      ]),
                                  subtitle: Text(
                                    donations[index].date.toString(),
                                    style: TextStyle(color: ataaGold),
                                  ),
                                  leading: Icon(Icons.edit,
                                      color: ataaGold, size: 25),
                                  trailing: Icon(
                                    Icons.arrow_back_ios,
                                    color: ataaGold,
                                    size: 25,
                                  ),
                                )),
                          );
                        });
              }),
        ));
  }
}
