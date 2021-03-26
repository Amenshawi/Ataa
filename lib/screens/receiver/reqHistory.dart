import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/screens/home_page.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReqHistorySheet extends StatefulWidget {
  final String type;
  final AppUser user;

  ReqHistorySheet(this.type, this.user);

  @override
  _ReqHistorySheetState createState() => _ReqHistorySheetState(type);
}

class _ReqHistorySheetState extends State<ReqHistorySheet> {
  double hieghtSize, widthSize;
  final String type;
  final database = Database();
  var requests;
  _ReqHistorySheetState(this.type);
  @override
  Widget build(BuildContext context) {
    requests = database.fetchDonationRequests(Provider.of<AppUser>(context));
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;

    return Expanded(
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
                : GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    children: List<Widget>.generate(requests.length, (index) {
                      return GridTile(
                        child: new Card(
                            color: ataaWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/Images/hand_give.png', // if u have a bteer idea change the icon.
                                    fit: BoxFit.contain,
                                    color: ataaGreen,
                                  ),
                                  SizedBox(height: hieghtSize * 0.04),
                                  Text(requests[index].type,
                                      style: TextStyle(
                                          color: ataaGreen,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      requests[index]
                                              .timeStamp
                                              .year
                                              .toString() +
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
                                      style: TextStyle(
                                          color: ataaGreen,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(requests[index].status,
                                      style: TextStyle(
                                          color: ataaGreen,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )),
                      );
                    }));
          }),
    );
  }
}
