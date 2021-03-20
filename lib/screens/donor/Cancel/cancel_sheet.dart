import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/models/donation.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class CancelSheet extends StatefulWidget {
  final String type;
  final AppUser user;
  CancelSheet(this.type, this.user);
  @override
  _CancelSheetState createState() => _CancelSheetState(type, user);
}

class _CancelSheetState extends State<CancelSheet> {
  final database = Database();
  double heightSize, widthSize;
  final String type;
  final AppUser user;
  var donations = [];
  var scheduled = [];
  var allDonations;
  var currentList;
  bool isOpen = false;
  // final _slidableKey = GlobalKey<SlidableState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allDonations = database.fetchDonations(user);
  }

  void devideLists(list) {
    if (list == null) return;
    donations = [];
    scheduled = [];
    list.forEach((donation) {
      if (donation.status == 'scheduled') {
        if (scheduled == null)
          scheduled = [donation];
        else
          scheduled.add(donation);
      } else if (donation.status == 'active') {
        if (donations == null)
          donations.add(donation);
        else
          donations.add(donation);
      }
    });
    if (currentList == null) currentList = donations;
  }

  _CancelSheetState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: TabBar(
              indicatorColor: ataaGreen,
              unselectedLabelColor: ataaGreenField,
              labelColor: ataaGreen,
              onTap: (index) {
                setState(() {
                  if (index == 0)
                    currentList = donations;
                  else
                    currentList = scheduled;
                });
              },
              tabs: [
                Text(
                  'Donation',
                  style: TextStyle(fontSize: 22),
                ),
                Text('Scheduled', style: TextStyle(fontSize: 22))
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              width: widthSize,
              height: heightSize * 0.65,
              child: Card(
                color: ataaWhite,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: FutureBuilder(
                    future: allDonations,
                    builder: (context, snapshot) {
                      devideLists(snapshot.data);
                      return currentList == null
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromRGBO(244, 234, 146, 1),
                                valueColor: AlwaysStoppedAnimation(
                                    Color.fromRGBO(28, 102, 74, 1)),
                              ),
                            )
                          : ListView.builder(
                              itemCount: currentList.length,
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
                                            Toast.show(
                                                'Cancel on $index', context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                          },
                                        )
                                      ],
                                      dismissal: SlidableDismissal(
                                          child: SlidableDrawerDismissal()),
                                      child: ListTile(
                                        title: Text(
                                          currentList[index].type,
                                          style: TextStyle(
                                              color: ataaGold, fontSize: 20),
                                        ),
                                        subtitle: Text(
                                          currentList[index]
                                                  .timeStamp
                                                  .year
                                                  .toString() +
                                              '-' +
                                              currentList[index]
                                                  .timeStamp
                                                  .month
                                                  .toString() +
                                              '-' +
                                              currentList[index]
                                                  .timeStamp
                                                  .day
                                                  .toString() +
                                              ' ' +
                                              currentList[index]
                                                  .timeStamp
                                                  .hour
                                                  .toString() +
                                              ':' +
                                              currentList[index]
                                                  .timeStamp
                                                  .minute
                                                  .toString(),
                                          style: TextStyle(color: ataaGold),
                                        ),
                                        leading: Icon(Icons.edit,
                                            color: ataaGold, size: 25),
                                        trailing: IconButton(
                                          icon: Icon(Icons.arrow_back_ios,
                                              size: 25),
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
                              });
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
