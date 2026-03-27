import 'package:date_range_calendar/src/data/types.dart';
import 'package:flutter/material.dart';

/// Labels for each day of the week.
///
/// Defaults to English abbreviations. Override individual fields
/// to localize (e.g. Japanese: `mon: '月'`).
class DayOfTheWeekLabelsData {
  /// Creates day-of-the-week labels with the given strings.
  const DayOfTheWeekLabelsData({
    this.mon = 'Mon',
    this.tue = 'Tue',
    this.wed = 'Wed',
    this.thu = 'Thu',
    this.fri = 'Fri',
    this.sat = 'Sat',
    this.sun = 'Sun',
  });

  /// Label for Monday.
  final String mon;

  /// Label for Tuesday.
  final String tue;

  /// Label for Wednesday.
  final String wed;

  /// Label for Thursday.
  final String thu;

  /// Label for Friday.
  final String fri;

  /// Label for Saturday.
  final String sat;

  /// Label for Sunday.
  final String sun;
}

/// Labels for each month of the year.
///
/// Defaults to English full names. Override individual fields
/// to localize (e.g. Japanese: `jan: '1月'`).
class MonthLabelsData {
  /// Creates month labels with the given strings.
  const MonthLabelsData({
    this.jan = 'January',
    this.feb = 'February',
    this.mar = 'March',
    this.apr = 'April',
    this.may = 'May',
    this.jun = 'June',
    this.jul = 'July',
    this.aug = 'August',
    this.sep = 'September',
    this.oct = 'October',
    this.nov = 'November',
    this.dec = 'December',
  });

  /// Label for January.
  final String jan;

  /// Label for February.
  final String feb;

  /// Label for March.
  final String mar;

  /// Label for April.
  final String apr;

  /// Label for May.
  final String may;

  /// Label for June.
  final String jun;

  /// Label for July.
  final String jul;

  /// Label for August.
  final String aug;

  /// Label for September.
  final String sep;

  /// Label for October.
  final String oct;

  /// Label for November.
  final String nov;

  /// Label for December.
  final String dec;
}

/// Visual style configuration for individual day cells in the calendar.
class DayCellStyle {
  /// Creates a [DayCellStyle] with the given colors and border radius.
  const DayCellStyle({
    this.backgroundColorOfEndDay = const Color(0xFF275c2c),
    this.backgroundColorOfBetweenDay = const Color(0xFFe1ede2),
    this.backgroundColorOfStartDay = const Color(0xFF275c2c),
    this.borderColorOfToday = const Color(0xFF275c2c),
    this.borderRadius = const Radius.circular(30),
  });

  /// Background color of the selected start date.
  final Color backgroundColorOfStartDay;

  /// Background color of the selected end date.
  final Color backgroundColorOfEndDay;

  /// Background color of dates between the start and end dates.
  final Color backgroundColorOfBetweenDay;

  /// Border color used to highlight today's date.
  final Color borderColorOfToday;

  /// Border radius applied to start/end day cells and week boundaries.
  final Radius borderRadius;
}

/// Top-level configuration for [DateRangeCalendar] appearance and behavior.
///
/// Pass an instance to `DateRangeCalendar.setupData` to customize
/// day cell styles, month/weekday labels, title layout, and initial month.
class CalendarSetupData {
  /// Creates a [CalendarSetupData] with the given configuration.
  const CalendarSetupData({
    this.dayCellStyle = const DayCellStyle(),
    this.dayOfTheWeekLabelsData = const DayOfTheWeekLabelsData(),
    this.monthLabelsData = const MonthLabelsData(),
    this.monthLayoutType = MonthLayoutType.monthYear,
    this.monthTitleYearUnit = '',
    this.initialMonth,
  });

  /// Style configuration for day cells.
  final DayCellStyle dayCellStyle;

  /// Labels for each day of the week.
  final DayOfTheWeekLabelsData dayOfTheWeekLabelsData;

  /// Labels for each month.
  final MonthLabelsData monthLabelsData;

  /// The order in which year and month appear in the title.
  final MonthLayoutType monthLayoutType;

  /// Unit string appended after the year in the title.
  ///
  /// For example, setting this to `'年'` displays `'2023年'`.
  final String monthTitleYearUnit;

  /// The initial month to display when the calendar is first shown.
  ///
  /// Defaults to the current month if not specified.
  final DateTime? initialMonth;
}
