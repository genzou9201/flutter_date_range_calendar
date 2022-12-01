library date_range_calendar;

import 'package:date_range_calendar/src/data/types.dart';
import 'package:date_range_calendar/src/view/calendar_outline.dart';
import 'package:flutter/material.dart';

class DateRangeCalendar extends StatelessWidget {
  const DateRangeCalendar({
    required this.onTappedDay,
    this.calendarType = CalendarType.singleMonth,
    Key? key,
  }) : super(key: key);

  final CalendarType calendarType;
  final Function(DateTime?, DateTime?) onTappedDay;

  @override
  Widget build(BuildContext context) {
    return CalendarOutline(
      onTappedDay: onTappedDay,
    );
  }
}