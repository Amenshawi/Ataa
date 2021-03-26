import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/screens/home_page.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonHistorySheet extends StatefulWidget {
  final String type;

  DonHistorySheet(this.type);
  @override
  _DonHistorySheetState createState() => _DonHistorySheetState(type);
}

class _DonHistorySheetState extends State<DonHistorySheet> {
  double hieghtSize, widthSize;
  final String type;
  var donations;
  _DonHistorySheetState(this.type);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    donations = Database.fetchDonations(Provider.of<AppUser>(context));
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;

    return Expanded(
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
                : GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    children: List<Widget>.generate(donations.length, (index) {
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
                                  Image.network(
                                    donations[index].imageURL,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: hieghtSize * 0.04),
                                  Text(donations[index].type,
                                      style: TextStyle(
                                          color: ataaGreen,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      donations[index]
                                              .timeStamp
                                              .year
                                              .toString() +
                                          '-' +
                                          donations[index]
                                              .timeStamp
                                              .month
                                              .toString() +
                                          '-' +
                                          donations[index]
                                              .timeStamp
                                              .day
                                              .toString() +
                                          ' ' +
                                          donations[index]
                                              .timeStamp
                                              .hour
                                              .toString() +
                                          ':' +
                                          donations[index]
                                              .timeStamp
                                              .minute
                                              .toString(),
                                      style: TextStyle(
                                          color: ataaGreen,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  Text(donations[index].status,
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
