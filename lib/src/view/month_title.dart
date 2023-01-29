import 'package:date_range_calendar/src/core/util.dart';
import 'package:date_range_calendar/src/data/calendar_setup_data.dart';
import 'package:date_range_calendar/src/data/types.dart';
import 'package:flutter/material.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    required this.baseDate,
    required this.setupData,
    Key? key,
  }) : super(key: key);

  final DateTime baseDate;
  final CalendarSetupData setupData;

  @override
  Widget build(BuildContext context) {
    final month = getMonthString(setupData, baseDate);
    final year = baseDate.year;
    final yearUnit = setupData.monthTitleYearUnit;

    var title = '';

    if (setupData.monthLayoutType == MonthLayoutType.monthYear) {
      title = '$month $year$yearUnit';
    }

    if (setupData.monthLayoutType == MonthLayoutType.yearMonth) {
      title = '$year$yearUnit $month';
    }

    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
