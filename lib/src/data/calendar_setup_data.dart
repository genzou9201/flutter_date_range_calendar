import 'package:date_range_calendar/src/data/types.dart';
import 'package:flutter/material.dart';

/// [DayOfTheWeekLabelsData] defines string of each day of the week.
/// Default is english.
class DayOfTheWeekLabelsData {
  const DayOfTheWeekLabelsData({
    this.mon = 'Mon',
    this.tue = 'Tue',
    this.wed = 'Wed',
    this.thu = 'Thu',
    this.fri = 'Fri',
    this.sat = 'Sat',
    this.sun = 'Sun',
  });

  final String mon;
  final String tue;
  final String wed;
  final String thu;
  final String fri;
  final String sat;
  final String sun;
}

/// [MonthLabelsData] defines string of each month.
/// Default is english.
class MonthLabelsData {
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

  final String jan;
  final String feb;
  final String mar;
  final String apr;
  final String may;
  final String jun;
  final String jul;
  final String aug;
  final String sep;
  final String oct;
  final String nov;
  final String dec;
}

/// [DayCellStyle] defines style of day cell in month.
/// You can define background color of a day etc.
class DayCellStyle {
  const DayCellStyle({
    this.backgroundColorOfEndDay = const Color(0xFF275c2c),
    this.backgroundColorOfBetweenDay = const Color(0xFFe1ede2),
    this.backgroundColorOfStartDay = const Color(0xFF275c2c),
    this.borderColorOfToday = const Color(0xFF275c2c),
    this.borderRadius = const Radius.circular(30),
  });

  final Color backgroundColorOfStartDay;
  final Color backgroundColorOfEndDay;
  final Color backgroundColorOfBetweenDay;
  final Color borderColorOfToday;
  final Radius borderRadius;
}

/// CalendarOutline style
class CalendarOutlineStyle {
  const CalendarOutlineStyle({
    required this.backgroundColor,
    required this.elevation,
    required this.margin,
    required this.padding,
    required this.width,
  });

  final Color backgroundColor;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;
}

/// Top level setup data
class CalendarSetupData {
  const CalendarSetupData({
    this.dayCellStyle = const DayCellStyle(),
    this.dayOfTheWeekLabelsData = const DayOfTheWeekLabelsData(),
    this.monthLabelsData = const MonthLabelsData(),
    this.monthLayoutType = MonthLayoutType.monthYear,
    this.monthTitleYearUnit = '',
    this.initialMonth,
  });

  final DayCellStyle dayCellStyle;
  final DayOfTheWeekLabelsData dayOfTheWeekLabelsData;
  final MonthLabelsData monthLabelsData;
  final MonthLayoutType monthLayoutType;

  /// You can define an unit of year.
  /// For example,
  /// when you define it as "年", then it displays such as "2023年"
  final String monthTitleYearUnit;

  final DateTime? initialMonth;
}
