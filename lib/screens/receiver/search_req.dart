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
  var donations;
  var requests;
  var temp;
  int tab = 0;
  final TextEditingController searchController = TextEditingController();
  bool switched = false;
  // final _slidableKey = GlobalKey<SlidableState>();

  _SearchReqState(this.type, this.user);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;
    donations = Database.FetchActiveDonations();
    requests = Database.FetchActiveRequests();
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
                  switched = true;
                  temp = null;
                  tab = index;
                  searchController.text = '';
                });
              },
              tabs: [
                Text(
                  'Donations',
                  style: TextStyle(fontSize: 22),
                ),
                Text('Requests', style: TextStyle(fontSize: 22))
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
              controller: searchController,
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
              onChanged: ((input) {
                print('before change');
                print(temp.toString());
                if (input == '' || input == null) {
                  temp = null;
                  print('empty');
                  print(temp.toString());
                  setState(() {});
                } else if (tab == 0) {
                  temp = [];
                  donations.forEach((donation) {
                    if (donation.type.startsWith(input)) {
                      temp.add(donation);
                    }
                  });
                  setState(() {});
                } else {
                  temp = [];
                  requests.forEach((request) {
                    if (request.type.startsWith(input)) {
                      temp.add(request);
                    }
                  });
                  setState(() {});
                }
              }),
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
                  child: tab == 0
                      ? FutureBuilder(
                          future: donations,
                          builder: (context, snapshot) {
                            donations = snapshot.data;
                            print(switched);
                            print(temp.toString());
                            if (temp == null || switched) {
                              print('hi');
                              temp = snapshot.data;
                              switched = false;
                            }
                            // else if (temp.length == 0) temp = snapshot.data;

                            return temp == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(244, 234, 146, 1),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromRGBO(28, 102, 74, 1)),
                                    ),
                                  )
                                : new ListView.builder(
                                    itemCount: temp.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          color: ataaGreen,
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            title: Text(
                                              temp[index].type,
                                              style: TextStyle(
                                                  color: ataaGold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              temp[index]
                                                      .timeStamp
                                                      .year
                                                      .toString() +
                                                  '-' +
                                                  temp[index]
                                                      .timeStamp
                                                      .month
                                                      .toString() +
                                                  '-' +
                                                  temp[index]
                                                      .timeStamp
                                                      .day
                                                      .toString() +
                                                  ' ' +
                                                  temp[index]
                                                      .timeStamp
                                                      .hour
                                                      .toString() +
                                                  ':' +
                                                  temp[index]
                                                      .timeStamp
                                                      .minute
                                                      .toString(),
                                              style: TextStyle(color: ataaGold),
                                            ),
                                            leading: Icon(Icons.receipt,
                                                color: ataaGold, size: 25),
                                          ));
                                    });
                          })
                      : FutureBuilder(
                          future: requests,
                          builder: (context, snapshot) {
                            requests = snapshot.data;
                            print(switched);
                            print(temp.toString());
                            if (temp == null || switched) {
                              print('hi');
                              temp = snapshot.data;
                              switched = false;
                            }
                            // else if (temp.length == 0) temp = snapshot.data;
                            return temp == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(244, 234, 146, 1),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromRGBO(28, 102, 74, 1)),
                                    ),
                                  )
                                : new ListView.builder(
                                    itemCount: temp.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          color: ataaGreen,
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            title: Text(
                                              temp[index].type,
                                              style: TextStyle(
                                                  color: ataaGold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              temp[index]
                                                      .timeStamp
                                                      .year
                                                      .toString() +
                                                  '-' +
                                                  temp[index]
                                                      .timeStamp
                                                      .month
                                                      .toString() +
                                                  '-' +
                                                  temp[index]
                                                      .timeStamp
                                                      .day
                                                      .toString() +
                                                  ' ' +
                                                  temp[index]
                                                      .timeStamp
                                                      .hour
                                                      .toString() +
                                                  ':' +
                                                  temp[index]
                                                      .timeStamp
                                                      .minute
                                                      .toString(),
                                              style: TextStyle(color: ataaGold),
                                            ),
                                            leading: Icon(Icons.receipt,
                                                color: ataaGold, size: 25),
                                          ));
                                    });
                          })),
            ),
          ),
        ],
      ),
    );
  }
}
