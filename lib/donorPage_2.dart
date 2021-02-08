import 'package:flutter/material.dart';
import 'createButtons_2.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

// ignore: camel_case_types
class DonorPage_2 extends StatefulWidget {
  @override
  _DonorPage_2State createState() => _DonorPage_2State();
}

// ignore: camel_case_types
class _DonorPage_2State extends State<DonorPage_2> {
  double hieghtSize, widthSize;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Column(
      children: [
        searchBar(),
        SizedBox(height: hieghtSize * 0.04),
        donorButtons(),
      ],
    );
  }

  Widget donorButtons() {
    return Padding(
      padding: EdgeInsets.only(left: widthSize * 0.07, right: widthSize * 0.07),
      child: !visible
          ? Container(
              // padding: EdgeInsets.all(50),
              // color: ataaGreen,
              child: Row(
                children: [
                  Column(
                    children: [
                      CreateButtons(
                          height: hieghtSize * 0.3,
                          width: widthSize * 0.4,
                          icon: Icons.add,
                          cardName: 'Make A Donation',
                          space: true),
                      CreateButtons(
                          height: hieghtSize * 0.15,
                          width: widthSize * 0.4,
                          icon: Icons.delete_forever,
                          cardName: 'Cancel A Donation',
                          space: false),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CreateButtons(
                          height: hieghtSize * 0.15,
                          width: widthSize * 0.4,
                          icon: Icons.schedule,
                          cardName: 'Schedul A Donation',
                          space: false),
                      CreateButtons(
                          height: hieghtSize * 0.3,
                          width: widthSize * 0.4,
                          icon: Icons.menu_book_rounded,
                          cardName: 'Donations History',
                          space: true),
                    ],
                  )
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            visible = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  height: hieghtSize * 0.45,
                  width: widthSize * 0.8,
                  child: Card(
                    color: ataaWhite,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ataaGreen,
                          ),
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            leading:
                                Icon(Icons.home, size: 27, color: ataaGold),
                            title: Text(
                              'Abadi Is here',
                              style: TextStyle(
                                  color: ataaGold,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Hi',
                                style:
                                    TextStyle(color: ataaGold, fontSize: 20)),
                            trailing: Icon(
                              Icons.navigate_next_outlined,
                              color: ataaGold,
                              size: 27,
                            ),
                            selected: true,
                            onTap: () {
                              print('Hello world!');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // tileColor: Colors.white,
                            // focusColor: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: EdgeInsets.only(left: widthSize * 0.04, right: widthSize * 0.04),
      child: Card(
        elevation: 100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
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
              child: TextField(
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: ataaGreen),
                decoration: InputDecoration(
                  fillColor: ataaWhite,
                  filled: true,
                  hintText: 'Search for charities...',
                  hintStyle: TextStyle(
                      color: ataaGreen,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none),
                ),
                onChanged: (val) {},
                onTap: () {
                  setState(() {
                    visible = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
