import 'package:Ataa/custom/Sheet.dart';
import 'package:Ataa/Custom/custom_daytile_builder.dart';
import 'package:Ataa/screens/donor/donation_form.dart';
import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class PeriodcSheet extends StatefulWidget {
  final String type;
  final AppUser user;
  PeriodcSheet(this.type, this.user);
  @override
  _PeriodcSheetState createState() => _PeriodcSheetState(type, user);
}

class _PeriodcSheetState extends State<PeriodcSheet> {
  final database = Database();
  double heightSize, widthSize;
  final AppUser user;
  String type;
  TimeOfDay _timeOfDay;
  String period = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  _PeriodcSheetState(this.type, this.user);
  int _periodType;
  List<bool> weekdays;
  List<int> monthDays = [];
  Calendarro monthCalendarro;
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    _timeOfDay = TimeOfDay.now();
    period = _timeOfDay.period.index == 0 ? 'AM' : 'PM';
    _periodType = 1;
    type = 'Food';
    //Sunday is index 0 ,Monday is index 1,..., Saturday is index 6
    weekdays = [false, false, false, false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    var startDate = DateUtils.getFirstDayOfCurrentMonth();
    var endDate = DateUtils.getLastDayOfNextMonth();
    monthCalendarro = Calendarro(
        dayTileBuilder: CustomDayTileBuilder(),
        startDate: startDate,
        endDate: endDate,
        displayMode: DisplayMode.MONTHS,
        selectionMode: SelectionMode.MULTI,
        weekdayLabelsRow: CustomWeekdayLabelsRow(),
        onTap: (date) {
          // add functionality on date selection here
          if (monthDays == null)
            monthDays = [date.day];
          else
            monthDays.add(date.day);
        });

    return Container(
      width: widthSize,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ataaWhite,
        child: Padding(
          padding: EdgeInsets.only(
              top: heightSize * 0.02, bottom: heightSize * 0.02),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: heightSize * 0.07,
                width: widthSize * 0.75,
                child: Card(
                  color: ataaWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Donation Type:  ',
                          style: TextStyle(fontSize: 18, color: ataaGreen),
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          value: type,
                          icon: Icon(
                            Icons.arrow_downward,
                            color: ataaGreen,
                          ),
                          iconSize: 20,
                          style: TextStyle(
                              color: ataaGreen,
                              // fontSize: 22,
                              fontWeight: FontWeight.bold),
                          // underline: Container(height: 2, color: ataaWhite),
                          onChanged: (String newValue) {
                            setState(() {
                              type = newValue;
                            });
                            // if (newValue == 'Food')
                            //   showSheet(context, newValue,
                            //       DonationForm(newValue, user, true), true);
                            // else
                            //   showSheet(context, newValue,
                            //       DonationForm(newValue, user, false), false);
                          },
                          items: <String>[
                            'Food',
                            'Clothes',
                            'Electronics',
                            'Furniture'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(
                                      color: ataaGreen,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              /*Card(
                color: ataaGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: ListTile(
                    title: Text(
                      'From: ${_startDate.year}/${_startDate.month}/${_startDate.day} \nTo: ${_endDate.year}/${_endDate.month}/${_endDate.day}',
                      style: TextStyle(color: ataaGold, fontSize: 20),
                    ),
                    trailing: Icon(Icons.date_range_rounded, color: ataaGold),
                    onTap: _pickDate),
              ),*/
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Color.fromRGBO(28, 102, 74, 1.0),
                        width: 3.0,
                        style: BorderStyle.solid)),
                color: Color.fromRGBO(255, 255, 255, 1.0),
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    SizedBox(
                      height: heightSize * 0.01,
                    ),
                    Text(
                      'Start Date',
                      style: TextStyle(
                        color: Color.fromRGBO(28, 102, 74, 1.0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: heightSize * 0.01,
                    ),
                    SizedBox(
                      height: heightSize * 0.07,
                      child: CupertinoTheme(
                        child: CupertinoDatePicker(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                          mode: CupertinoDatePickerMode.date,
                          minimumDate: DateTime.now(),
                          initialDateTime: DateTime.now(),
                          maximumDate: DateTime(DateTime.now().year + 2),
                          onDateTimeChanged: (DateTime newDateTime) {
                            date = newDateTime;
                          },
                        ),
                        data: CupertinoThemeData(
                          textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(28, 102, 74, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightSize * 0.01),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Weekly',
                      style: TextStyle(
                          color: ataaGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Radio(
                        focusColor: ataaGreen,
                        groupValue: _periodType,
                        value: 1,
                        onChanged: (value) {
                          _radioChanged(value);
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      'Monthly',
                      style: TextStyle(
                          color: ataaGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Radio(
                        focusColor: ataaGreen,
                        groupValue: _periodType,
                        value: 2,
                        onChanged: (value) {
                          _radioChanged(value);
                        })
                  ],
                ),
              ),
              SizedBox(
                height: heightSize * 0.01,
              ),
              _periodType == 1
                  ? Container(
                      child: WeekdaySelector(
                        values: weekdays,
                        onChanged: (value) {
                          print(value);
                          _weekdayChanged(value);
                        },
                        firstDayOfWeek: 7,
                        selectedFillColor: ataaGreen,
                        selectedColor: ataaGold,
                      ),
                    )
                  : Container(
                      height: heightSize * 0.3,
                      child: monthCalendarro,
                    ),

              /* Card(
                color: ataaGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: ListTile(
                    title: Text(
                      'Time: ${_timeOfDay.hour}: ${_timeOfDay.minute} ${period}',
                      style: TextStyle(color: ataaGold, fontSize: 20),
                    ),
                    trailing: Icon(Icons.timer, color: ataaGold),
                    onTap: _pickTime),
              ),*/
              // ),
              Container(
                  height: heightSize * 0.05,
                  width: widthSize * 0.2,
                  child: FloatingActionButton(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: ataaGreen,
                    child: Icon(Icons.done, color: ataaGold, size: 30),
                    onPressed: () {
                      if (_periodType == 1) //weekly
                        database.addWeekly(user, type, date, weekdays);
                      else
                        database.addMonthly(user, type, date, monthDays);
                      // database.addDonation(user, type, _image,
                      //     descController.text, anonymous, location);
                      Navigator.pop(context);
                      // call db.addDonation here
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    // i couldn't change the color of the dates, however, in the login page there is a themdate where it should take the primary color and the primaryswatch.
    // i changes the primaryswatch but the two button (cancel and ok) dissapered :(
    // if it was too much just ignore it.
    List<DateTime> date = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: _startDate,
      initialLastDate: _endDate,
      firstDate: new DateTime(DateTime.now().year),
      lastDate: new DateTime(DateTime.now().year + 5),
    );
    if (date != null && date.length == 2)
      setState(() {
        _startDate = date[0];
        _endDate = date[1];
        print(date);
      });
  }

  void _pickTime() async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _timeOfDay,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light().copyWith(
                primary: ataaGreen,
                onPrimary: ataaGold,
              ),
            ),
            child: child,
          );
        });

    if (time != null)
      setState(() {
        period = time.period.index == 0 ? 'AM' : 'PM';
        _timeOfDay = time;
      });
  }

  void showSheet(context, sheetName, content, padding) {
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

  void _radioChanged(dynamic value) {
    setState(() {
      _periodType = value;
    });
  }

  void _weekdayChanged(int day) {
    setState(() {
      if (day == 7)
        weekdays[0] = !weekdays[0];
      else
        weekdays[day] = !weekdays[day];
    });
    print(weekdays.toString());
  }
}

class CustomWeekdayLabelsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text("Days of The Month",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ataaGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
