import 'package:calendarro/calendarro.dart';
import 'package:flutter/material.dart';
import 'custom_daytile.dart';

class CustomDayTileBuilder extends DayTileBuilder {
  CustomDayTileBuilder();

  @override
  Widget build(BuildContext context, DateTime date, DateTimeCallback onTap) {
    return CustomCalendarroDayItem(
        date: date, calendarroState: Calendarro.of(context), onTap: onTap);
  }
}
