import 'package:Ataa/appUser.dart';
import 'package:Ataa/database.dart';
import 'package:flutter/material.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

class ScheduleSheet extends StatefulWidget {
  final String type;
  final AppUser user;
  ScheduleSheet(this.type, this.user);
  @override
  _ScheduleSheetState createState() => _ScheduleSheetState(type, user);
}

class _ScheduleSheetState extends State<ScheduleSheet> {
  final database = Database();
  double heightSize, widthSize;
  TextEditingController descController = TextEditingController();
  final String type;
  final AppUser user;
  DateTime _pickedDate;
  TimeOfDay _timeOfDay;
  String period = '';
  String placeHolder = 'Food';
  _ScheduleSheetState(this.type, this.user);

  @override
  void initState() {
    super.initState();
    _pickedDate = DateTime.now();
    _timeOfDay = TimeOfDay.now();
    period = _timeOfDay.period.index == 0 ? 'AM' : 'PM';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    heightSize = size.height;
    widthSize = size.width;

    return Container(
      width: widthSize,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ataaWhite,
        child: Padding(
          padding: EdgeInsets.only(
              top: heightSize * 0.04, bottom: heightSize * 0.04),
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
                          value: placeHolder,
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
                              placeHolder = newValue;
                            });
                          },
                          items: <String>[
                            'Food',
                            'Clothes',
                            'Electronics',
                            'Devices'
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
              SizedBox(height: heightSize * 0.02),
              Card(
                color: ataaGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: ListTile(
                    title: Text(
                      'Date: ${_pickedDate.year}, ${_pickedDate.month}, ${_pickedDate.day}',
                      style: TextStyle(color: ataaGold, fontSize: 20),
                    ),
                    trailing: Icon(Icons.date_range_rounded, color: ataaGold),
                    onTap: _pickDate),
              ),
              SizedBox(height: heightSize * 0.01),
              Card(
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
              ),
              SizedBox(height: heightSize * 0.02),
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
                      print('Hi there!');
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
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: _pickedDate,
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

    if (date != null)
      setState(() {
        _pickedDate = date;
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
}