import 'package:Ataa/custom/sheet.dart';
import 'package:Ataa/custom/create_buttons.dart';
import 'package:Ataa/screens/donor/Cancel/cancel_sheet.dart';
import 'package:Ataa/screens/donor/donation_form.dart';
import 'package:Ataa/screens/donor/donHistory.dart';
import 'package:Ataa/screens/donor/schedul/periodc_sheet.dart';
import 'package:Ataa/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/Services/database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:Ataa/screens/donor/schedul/edit_sheet.dart';
import 'package:Ataa/screens/donor/schedul/schedule_sheet.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

// ignore: camel_case_types
class DonorPage extends StatefulWidget {
  final AppUser user;
  DonorPage(this.user);
  @override
  _DonorPageState createState() => _DonorPageState(user);
}

// ignore: camel_case_types
class _DonorPageState extends State<DonorPage> {
  double hieghtSize, widthSize;
  bool visible = false;
  bool _subButtons = false;
  bool cardOpen = false;
  final database = Database();
  final AppUser user;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  _DonorPageState(this.user);
  var charities;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return Column(
      children: [
        searchBar(),
        SizedBox(height: hieghtSize * 0.02),
        donorButtons(),
      ],
    );
  }

  Widget donorButtons() {
    return !visible
        ? Container(
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
                          ),
                          secondChild: subButtons()),
                    ),
                    GestureDetector(
                      child: CreateButtons(
                        height: hieghtSize * 0.15,
                        width: widthSize * 0.4,
                        icon: Icons.delete_forever,
                        cardName: 'Cancel A Donation',
                        space: false,
                        spike: false,
                      ),
                      onTap: () {
                        showSheet(context, 'Cancel',
                            CancelSheet('Cancel', user), false);
                        setState(() {
                          if (cardOpen) {
                            if (!cardKey.currentState.isFront) {
                              cardKey.currentState.toggleCard();
                              cardOpen = !cardOpen;
                              _subButtons = !_subButtons;
                            } else
                              cardOpen = !cardOpen;
                          } else {
                            if (cardOpen) {
                              cardKey.currentState.toggleCard();
                              cardOpen = !cardOpen;
                              _subButtons = !_subButtons;
                            } else {
                              cardKey.currentState.toggleCard();
                              _subButtons = !_subButtons;
                            }
                          }
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showSheet(context, 'History',
                            DonHistorySheet('History', user), false);
                      },
                      child: CreateButtons(
                        height: hieghtSize * 0.15,
                        width: widthSize * 0.4,
                        icon: Icons.menu_book_rounded,
                        cardName: 'Donation History',
                        space: false,
                        spike: false,
                        // context: context,
                        // sheetName: 'Schedul',
                      ),
                    ),
                    FlipCard(
                        key: cardKey,
                        speed: 800,
                        front: CreateButtons(
                          height: hieghtSize * 0.3,
                          width: widthSize * 0.4,
                          icon: Icons.schedule,
                          cardName: 'Schedul A Donation',
                          space: true,
                          spike: false,
                        ),
                        back: subButtonsForSchedule()),
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
          );
  }

  Widget subButtonsForSchedule() {
    return Container(
      height: hieghtSize * 0.3,
      width: widthSize * 0.4,
      child: Container(
        height: hieghtSize * 0.07,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            donationButton(
                'Schedule', Icons.schedule, ScheduleSheet(user), true, 1),
            donationButton('Periodic Donations', Icons.all_inclusive,
                PeriodcSheet('Periodic donations', user), false, 1),
            donationButton('Edit Periodic', Icons.edit,
                EditSheet('Edit Periodic ', user), false, 1),
          ],
        ),
      ),
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
                DonationForm('Food', user, true), true, 0),
            donationButton('Clothes', Icons.accessibility_rounded,
                DonationForm('Clothes', user, false), false, 0),
            donationButton('Electronics', Icons.power,
                DonationForm('Electronics', user, false), false, 0),
            donationButton('Furniture', Icons.house_rounded,
                DonationForm('Furniture', user, false), false, 0)
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
          if (index == 0) {
            if (!cardKey.currentState.isFront) {
              cardKey.currentState.toggleCard();
              cardOpen = !cardOpen;
              _subButtons = !_subButtons;
            } else
              cardOpen = !cardOpen;
          } else {
            if (cardOpen) {
              cardKey.currentState.toggleCard();
              cardOpen = !cardOpen;
              _subButtons = !_subButtons;
            } else {
              cardKey.currentState.toggleCard();
              _subButtons = !_subButtons;
            }
          }
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
