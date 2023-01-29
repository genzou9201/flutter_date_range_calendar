library date_range_calendar;

import 'package:date_range_calendar/src/data/calendar_setup_data.dart';
import 'package:date_range_calendar/src/data/types.dart';
import 'package:date_range_calendar/src/view/calendar_outline.dart';
import 'package:flutter/material.dart';

export 'package:date_range_calendar/src/data/types.dart';
export 'package:date_range_calendar/src/data/calendar_setup_data.dart';

class DateRangeCalendar extends StatelessWidget {
  /// CalendarType property defines how many months does DateRangeCalender show.
  /// If CalendarType.singleMonth is passed then single month will be shown.
  final CalendarType calendarType;

  /// This is callback when user taps any date.
  /// If user taps only start date, then end date will be [null].
  final Function(DateTime?, DateTime?) onTappedDay;

  final CalendarSetupData setupData;

  const DateRangeCalendar({
    required this.onTappedDay,
    this.calendarType = CalendarType.singleMonth,
    this.setupData = const CalendarSetupData(),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalendarOutline(
      calendarType: calendarType,
      onTappedDay: onTappedDay,
      setupData: setupData,
    );
  }
}

