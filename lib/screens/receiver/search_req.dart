import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class SearchReq extends StatefulWidget {
  final String type;
  final AppUser user;
  SearchReq(this.type, this.user);
  @override
  _SearchReqState createState() => _SearchReqState(type, user);
}

class _SearchReqState extends State<SearchReq> {
  final database = Database();
  double heightSize, widthSize;
  final String type;
  final AppUser user;
  String title = 'Food';
  String subTitle = 'Date of Donation';
  bool isOpen = false;
  // final _slidableKey = GlobalKey<SlidableState>();

  _SearchReqState(this.type, this.user);

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
                  if (index == 0) {
                    title = 'Food';
                    subTitle = 'Date of Donation';
                  } else {
                    title = 'Clothes';
                    subTitle = 'Date of Donation';
                  }
                });
              },
              tabs: [
                Text(
                  'Requests',
                  style: TextStyle(fontSize: 22),
                ),
                Text('Donations', style: TextStyle(fontSize: 22))
              ],
            ),
          ),
          SizedBox(height: heightSize * 0.01),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 50,
            color: ataaWhite,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: ataaGreenField, fontSize: 18),
                prefixIcon: Icon(
                  Icons.search,
                  color: ataaGreenField,
                  size: 25,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              width: widthSize,
              height: heightSize * 0.54,
              child: Card(
                color: ataaWhite,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                          color: ataaGreen,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Text(
                              title,
                              style: TextStyle(color: ataaGold, fontSize: 20),
                            ),
                            subtitle: Text(
                              subTitle,
                              style: TextStyle(color: ataaGold),
                            ),
                            leading:
                                Icon(Icons.receipt, color: ataaGold, size: 25),
                            // trailing: IconButton(
                            //   icon: Icon(Icons.arrow_back_ios, size: 25),
                            //   color: ataaGold,
                            // size: 25,

                            // this is for when the user press on the arrow icon it will open to him instead of doing nothing.
                            // but i had an issue with Multiple Widgets used the same GlobalKey

                            // onPressed: () {
                            //   // setState(() {
                            //   //   if (isOpen) {
                            //   //     _slidableKey.currentState.close();
                            //   //     isOpen = !isOpen;
                            //   //   } else {
                            //   //     _slidableKey.currentState.open(
                            //   //         actionType:
                            //   //             SlideActionType.secondary);
                            //   //     isOpen = !isOpen;
                            //   //   }
                            //   // });
                            //   print('Hi');
                            // },
                          ));
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
