import 'package:Ataa/Custom/Sheet.dart';
import 'package:Ataa/Custom/createButtons_2.dart';
import 'package:Ataa/Donor/Donation/CustomForm.dart';
import 'package:Ataa/Donor/Donation/scheduleSheet.dart';
import 'package:Ataa/appUser.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/NavigationPage.dart';
import 'package:Ataa/database.dart';
import 'package:flip_card/flip_card.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

// ignore: camel_case_types
class DonorPage_2 extends StatefulWidget {
  final AppUser user;
  DonorPage_2(this.user);
  @override
  _DonorPage_2State createState() => _DonorPage_2State(user);
}

// ignore: camel_case_types
class _DonorPage_2State extends State<DonorPage_2> {
  double hieghtSize, widthSize;
  bool visible = false;
  bool _subButtons = false;
  bool cardOpen = false;
  int _currentIndex = 0;
  final database = Database();
  final AppUser user;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  _DonorPage_2State(this.user);
  var charities;
  // void _update(int index) {
  //   print('from: ' + _currentIndex.toString());
  //   print('to: ' + index.toString());
  //   setState(() => _currentIndex = index);
  // }
  @override
  Widget build(BuildContext context) {
    AppUser user;
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Column(
      children: [
        searchBar(),
        SizedBox(height: hieghtSize * 0.02),
        donorButtons(),
        // TabNavigationItem.getNavBar(_currentIndex, user, _update),
      ],
    );
  }

  Widget donorButtons() {
    return !visible
        ? Container(
            // padding: EdgeInsets.all(50),
            // color: ataaGreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _subButtons = !_subButtons;
                          cardOpen = !cardOpen;
                        });
                      },
                      child: AnimatedCrossFade(
                          duration: Duration(milliseconds: 300),
                          // opacity: fadeAway ? 0 : 1,
                          // sizeCurve: Curves.easeIn,
                          crossFadeState: !cardOpen
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: CreateButtons(
                            height: hieghtSize * 0.3,
                            width: widthSize * 0.4,
                            icon: Icons.add,
                            cardName: 'Make A Donation',
                            space: true,
                            spike: true,
                            // context: context,
                            // sheetName: 'Donate',
                            // content: MakeAdonation(),
                          ),
                          secondChild: subButtons()),
                    ),
                    CreateButtons(
                      height: hieghtSize * 0.15,
                      width: widthSize * 0.4,
                      icon: Icons.delete_forever,
                      cardName: 'Cancel A Donation',
                      space: false,
                      spike: false,
                      // context: context,
                      // sheetName: 'Cancel',
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreateButtons(
                      height: hieghtSize * 0.15,
                      width: widthSize * 0.4,
                      icon: Icons.menu_book_rounded,
                      cardName: 'Donation History',
                      space: false,
                      spike: false,
                      // context: context,
                      // sheetName: 'Schedul',
                    ),
                    FlipCard(
                      key: cardKey,
                      front: CreateButtons(
                        height: hieghtSize * 0.3,
                        width: widthSize * 0.4,
                        icon: Icons.schedule,
                        cardName: 'Schedul A Donation',
                        space: true,
                        spike: false,
                        // context: context,
                        // sheetName: 'History',
                      ),
                      back: Column(
                        children: [subButtonsForSchedule()],
                      ),
                    ),
                  ],
                )
              ],
            ),
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
                          visible = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: hieghtSize * 0.45,
                width: widthSize * 0.9,
                child: Card(
                  color: ataaWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: listItems(),
                ),
              ),
            ],
            // ),
          );
  }

  Widget subButtonsForSchedule() {
    return Container(
      height: hieghtSize * 0.3,
      width: widthSize * 0.4,
      child: Container(
        height: hieghtSize * 0.07,
        // child: Card(
        //   color: ataaWhite,
        //   elevation: 8,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            donationButton('Schedule', Icons.schedule,
                ScheduleSheet('Schedule', user), true, 1),
            donationButton('Periodic Donations', Icons.all_inclusive,
                ScheduleSheet('Periodic donations', user), false, 1),
            donationButton('Pause Donations', Icons.pause,
                ScheduleSheet('Pause Donations', user), false, 1),
            donationButton('Terminate Donations ', Icons.stop_circle_outlined,
                ScheduleSheet('Terminate Donations', user), false, 1),
          ],
        ),
      ),
      // ),
    );
  }

  Widget subButtons() {
    return Container(
      height: hieghtSize * 0.3,
      width: widthSize * 0.4,
      child: Container(
        height: hieghtSize * 0.07,
        child: Column(
          children: [
            donationButton('Food', Icons.food_bank,
                CustomForm('Food', user, true), true, 0),
            donationButton('Clothes', Icons.accessibility_rounded,
                CustomForm('Clothes', user, false), false, 0),
            donationButton('Electronics', Icons.power,
                CustomForm('Electronics', user, false), false, 0),
            donationButton('Furniture', Icons.house_rounded,
                CustomForm('Furniture', user, false), false, 0)
          ],
        ),
      ),
    );
  }

  Widget donationButton(
      String name, IconData icon, Widget content, bool food, int index) {
    return GestureDetector(
      child: Container(
        height: hieghtSize * 0.075,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: ataaGreen,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 1),
            // leading: Icon(icon, size: 25, color: ataaGold),
            title: Transform(
                transform: Matrix4.translationValues(8, 0.0, 0.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    color: ataaGold,
                  ),
                )),
            trailing: Icon(icon, size: 25, color: ataaGold),
          ),
        ),
      ),
      onTap: () {
        showSheet(context, name, content, food);
        setState(() {
          if (index == 0)
            cardOpen = !cardOpen;
          else
            cardKey.currentState.toggleCard();
        });
      },
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
                  onChanged: (val) {
                    if (val != '') {
                      setState(() async {
                        charities = await database.searchForCharity(val);
                        setState(
                            () {}); //IDK why is has to be here but it's the only way I could find to make it work
                        print(charities.first.data());
                      });
                    } else {
                      setState(() {
                        charities = null;
                      });
                    }
                  },
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
      ),
    );
  }

  listItems() {
    if (charities == null) {
      return new ListView();
    }
    return ListView.builder(
      padding: EdgeInsets.all(2),
      itemCount: charities.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ataaGreen,
          ),
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.home, size: 27, color: ataaGold),
            title: Text(
              charities[index].data()['name'],
              style: TextStyle(
                  color: ataaGold, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                charities[index].data()['specialty'] == null
                    ? ' '
                    : charities[index].data()['specialty'],
                style: TextStyle(color: ataaGold, fontSize: 20)),
            trailing: Icon(
              Icons.navigate_next_outlined,
              color: ataaGold,
              size: 27,
            ),
            selected: true,
            onTap: () {
              print('Hello world!');
              // go to charity page here.
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // tileColor: Colors.white,
            // focusColor: Colors.white,
          ),
        );
      },
    );
  }
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
