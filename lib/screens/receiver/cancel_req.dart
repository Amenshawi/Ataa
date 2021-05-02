import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
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
  double heightSize, widthSize;
  final String type;
  final AppUser user;
  bool isOpen = false;
  var requests;

  _CancelReqState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;
    requests = Database.fetchDonationRequests(Provider.of<AppUser>(context));
    return Container(
      width: widthSize,
      height: heightSize * 0.65,
      child: Card(
          color: ataaWhite,
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: FutureBuilder(
              future: requests,
              builder: (context, snapshot) {
                requests = snapshot.data;
                return requests == null
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(244, 234, 146, 1),
                          valueColor: AlwaysStoppedAnimation(
                              Color.fromRGBO(28, 102, 74, 1)),
                        ),
                      )
                    : ListView.builder(
                        itemCount: requests.length,
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
                                    caption: 'Cancel',
                                    color: Colors.red,
                                    icon: Icons.delete_forever_rounded,
                                    closeOnTap: true,
                                    onTap: () {
                                      Database.cancelDonationRequest(
                                          requests[index].rid);
                                      setState(() {
                                        requests.remove(requests[index]);
                                      });
                                      Toast.show(
                                          'Donation Request Canceled Successfully',
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                    },
                                  )
                                ],
                                dismissal: SlidableDismissal(
                                    child: SlidableDrawerDismissal()),
                                child: ListTile(
                                  title: Text(
                                    requests[index].type,
                                    style: TextStyle(
                                        color: ataaGold, fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    requests[index].timeStamp.year.toString() +
                                        '-' +
                                        requests[index]
                                            .timeStamp
                                            .month
                                            .toString() +
                                        '-' +
                                        requests[index]
                                            .timeStamp
                                            .day
                                            .toString() +
                                        ' ' +
                                        requests[index]
                                            .timeStamp
                                            .hour
                                            .toString() +
                                        ':' +
                                        requests[index]
                                            .timeStamp
                                            .minute
                                            .toString(),
                                    style: TextStyle(color: ataaGold),
                                  ),
                                  leading: Icon(Icons.edit,
                                      color: ataaGold, size: 25),
                                  trailing: IconButton(
                                    icon: Icon(Icons.arrow_back_ios, size: 25),
                                    color: ataaGold,

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
                        });
              })),
    );
  }
}
