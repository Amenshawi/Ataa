import 'package:Ataa/Custom/Sheet.dart';
import 'package:Ataa/screens/charity/add_location_sheet.dart';
import 'package:Ataa/screens/charity/locations_view.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/services/database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class CharityStandsPage extends StatefulWidget {
  @override
  _CharityStandsPageState createState() => _CharityStandsPageState();
}

class _CharityStandsPageState extends State<CharityStandsPage> {
  double hieghtSize, widthSize;
  bool search = false;
  Set<Marker> markers;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          searchBar(),
          SizedBox(height: hieghtSize * 0.01),
          !search
              ? Column(
                  children: [
                    longCard(
                        'Add a Location',
                        Icons.add_location_alt_outlined,
                        ['Water Tap', 'Clothes Box', 'Fridge'],
                        [
                          Icons.water_damage_outlined,
                          Icons.accessibility_new_sharp,
                          Icons.local_drink
                        ],
                        false),
                    longCard(
                        'Report a Location',
                        Icons.report,
                        ['Water Tap', 'Clothes Box', 'Fridge'],
                        [
                          Icons.water_damage_outlined,
                          Icons.accessibility_new_sharp,
                          Icons.local_drink
                        ],
                        true),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: widthSize * 0.04),
                            child: Text('Search Results...',
                                style: TextStyle(
                                    color: ataaGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: widthSize * 0.04),
                            child: IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: ataaGreen,
                                size: 27,
                              ),
                              onPressed: () {
                                setState(() {
                                  search = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: hieghtSize * 0.44,
                        width: widthSize * 0.9,
                        child: Card(
                          color: ataaWhite,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 8,
                          child: ListView.builder(
                              padding: EdgeInsets.all(2),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Card(
                                    color: ataaGreen,
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      title: Text(
                                        'Name',
                                        style: TextStyle(
                                            color: ataaGold,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        'Type',
                                        style: TextStyle(
                                            color: ataaGold, fontSize: 18),
                                      ),
                                      leading: Icon(Icons.receipt,
                                          color: ataaGold, size: 25),
                                    ));
                              }),
                        ),
                      ),
                    ])
        ],
      ),
    );
  }

  Widget longCard(String outerCardName, IconData icon, List inerCardNames,
      List inerCardIcons, bool color) {
    return Container(
      height: hieghtSize * 0.25,
      width: widthSize * 0.9,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: widthSize * 0.3,
              height: hieghtSize * 0.25,
              child: Card(
                color: color ? ataaGreen : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        icon,
                        color: color ? ataaGold : ataaGreen,
                        size: 30,
                      ),
                      SizedBox(height: hieghtSize * 0.02),
                      Text(
                        outerCardName,
                        style: TextStyle(
                            color: color ? ataaGold : ataaGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: sideButton(inerCardNames[0], inerCardIcons[0], color),
                  onTap: () async {
                    if (color) {
                      await Database.fetchStands().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocationView(true, customMarkers: value)));
                      });
                    } else
                      showSheet(context, inerCardNames[0],
                          AddLocationSheet('water'), false);
                  },
                ),
                GestureDetector(
                  child: sideButton(inerCardNames[1], inerCardIcons[1], color),
                  onTap: () async {
                    if (color) {
                      await Database.fetchStands().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocationView(true, customMarkers: value)));
                      });
                    } else
                      showSheet(context, inerCardNames[1],
                          AddLocationSheet('clothes'), false);
                  },
                ),
                GestureDetector(
                  child: sideButton(inerCardNames[2], inerCardIcons[2], color),
                  onTap: () async {
                    if (color) {
                      await Database.fetchStands().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocationView(true, customMarkers: value)));
                      });
                    } else
                      showSheet(context, inerCardNames[2],
                          AddLocationSheet('fridge'), false);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sideButton(String name, IconData icon, bool color) {
    return Container(
      width: widthSize * 0.55,
      height: hieghtSize * 0.065,
      decoration: BoxDecoration(
          color: color ? ataaWhite : ataaGreen,
          borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(name,
            style: TextStyle(
                color: color ? ataaGreen : ataaGold,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: Icon(
          icon,
          color: color ? ataaGreen : ataaGold,
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: EdgeInsets.only(left: widthSize * 0.04, right: widthSize * 0.04),
      child: Container(
        height: hieghtSize * 0.08,
        child: Card(
          elevation: 100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(widthSize * 0.02),
                child: Card(
                  elevation: 8,
                  color: ataaGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    Icons.search,
                    color: ataaGold,
                    size: 35,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.grey,
                  color: Colors.white70,
                  elevation: 100.0,
                  child: GestureDetector(
                    onTap: () async {
                      await Database.fetchStands().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocationView(false, customMarkers: value)));
                      });
                    },
                    child: Center(
                      heightFactor: 3.0,
                      child: Text(
                        "Find Stands",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(28, 102, 74, 1)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSheet(context, sheetName, content, padding) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        elevation: 100,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Sheet(
            sheetName: sheetName,
            content: content,
            padding: padding,
          );
        });
  }
}
