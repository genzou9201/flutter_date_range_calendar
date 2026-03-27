import 'package:date_range_calendar/src/data/calendar_setup_data.dart';
import 'package:date_range_calendar/src/data/types.dart';
import 'package:date_range_calendar/src/view/calendar_outline.dart';
import 'package:flutter/material.dart';

export 'package:date_range_calendar/src/data/types.dart';
export 'package:date_range_calendar/src/data/calendar_setup_data.dart';

/// A calendar widget that allows users to select a range of dates.
///
/// Place this widget in your widget tree and provide an [onTappedDay] callback
/// to receive the selected start and end dates.
class DateRangeCalendar extends StatelessWidget {
  /// Defines how many months the calendar displays.
  ///
  /// Defaults to [CalendarType.singleMonth].
  final CalendarType calendarType;

  /// Called when the user taps a date.
  ///
  /// The first parameter is the selected start date, and the second is
  /// the selected end date. The end date is `null` until the user taps
  /// a second date after the start date.
  final Function(DateTime?, DateTime?) onTappedDay;

  /// Configuration for calendar appearance and localization.
  final CalendarSetupData setupData;

  /// Creates a [DateRangeCalendar] widget.
  const DateRangeCalendar({
    required this.onTappedDay,
    this.calendarType = CalendarType.singleMonth,
    this.setupData = const CalendarSetupData(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CalendarOutline(
      calendarType: calendarType,
      onTappedDay: onTappedDay,
      setupData: setupData,
    );
  }
}