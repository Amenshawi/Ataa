import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/models/donation.dart';
import 'package:Ataa/models/donation_request.dart';
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
  var shownDonations;
  var shownRequests;
  bool searching = false;
  int tab = 0;
  final TextEditingController searchController = TextEditingController();
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
                this.setState(() {});
                setState(() {
                  tab = index;
                  searching = false;
                  searchController.clear();
                  if (shownDonations != null) shownDonations.clear();
                  if (shownRequests != null) shownRequests.clear();
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
                searching = true;
                if (tab == 0) {
                  shownDonations.clear();
                  if (input == '' || input == null) {
                    if (shownDonations != null) shownDonations.clear();
                    if (shownRequests != null) shownRequests.clear();
                    searching = false;
                    setState(() {});
                  } else {
                    searching = true;
                    donations.forEach((donation) {
                      if (donation.type.startsWith(input)) {
                        shownDonations.add(donation);
                      }
                    });
                    setState(() {});
                  }
                } else {
                  if (input == '' || input == null) {
                    if (shownDonations != null) shownDonations.clear();
                    if (shownRequests != null) shownRequests.clear();
                    searching = false;
                    setState(() {});
                  } else {
                    searching = true;
                    shownRequests.clear();
                    requests.forEach((request) {
                      if (request.type.startsWith(input)) {
                        shownRequests.add(request);
                      }
                    });
                    setState(() {});
                  }
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
                            if (shownDonations == null) {
                              shownDonations = snapshot.data;
                            } else if (shownDonations.length == 0 &&
                                !searching) {
                              shownDonations = snapshot.data;
                            } else if (shownDonations.length != 0 &&
                                shownDonations[0] is DonationRequest) {
                              shownDonations = snapshot.data;
                            }

                            return shownDonations == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(244, 234, 146, 1),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromRGBO(28, 102, 74, 1)),
                                    ),
                                  )
                                : new ListView.builder(
                                    itemCount: shownDonations.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          color: ataaGreen,
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            title: Text(
                                              shownDonations[index].type,
                                              style: TextStyle(
                                                  color: ataaGold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              shownDonations[index]
                                                      .timeStamp
                                                      .year
                                                      .toString() +
                                                  '-' +
                                                  shownDonations[index]
                                                      .timeStamp
                                                      .month
                                                      .toString() +
                                                  '-' +
                                                  shownDonations[index]
                                                      .timeStamp
                                                      .day
                                                      .toString() +
                                                  ' ' +
                                                  shownDonations[index]
                                                      .timeStamp
                                                      .hour
                                                      .toString() +
                                                  ':' +
                                                  shownDonations[index]
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
                          builder: (context, snapshot2) {
                            requests = snapshot2.data;
                            if (shownRequests == null) {
                              shownRequests = snapshot2.data;
                            } else if (shownRequests.length == 0 &&
                                !searching) {
                              shownRequests = snapshot2.data;
                            } else if (shownRequests.length != 0 &&
                                shownRequests[0] is Donation) {
                              shownRequests = snapshot2.data;
                            }
                            return shownRequests == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(244, 234, 146, 1),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromRGBO(28, 102, 74, 1)),
                                    ),
                                  )
                                : new ListView.builder(
                                    itemCount: shownRequests.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          color: ataaGreen,
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ListTile(
                                            title: Text(
                                              shownRequests[index].type,
                                              style: TextStyle(
                                                  color: ataaGold,
                                                  fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              shownRequests[index]
                                                      .timeStamp
                                                      .year
                                                      .toString() +
                                                  '-' +
                                                  shownRequests[index]
                                                      .timeStamp
                                                      .month
                                                      .toString() +
                                                  '-' +
                                                  shownRequests[index]
                                                      .timeStamp
                                                      .day
                                                      .toString() +
                                                  ' ' +
                                                  shownRequests[index]
                                                      .timeStamp
                                                      .hour
                                                      .toString() +
                                                  ':' +
                                                  shownRequests[index]
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
