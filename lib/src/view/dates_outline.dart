import 'package:date_range_calendar/src/data/calendar_setup_data.dart';
import 'package:flutter/material.dart';
import 'package:date_range_calendar/src/view/dates_in_month.dart';
import 'package:date_range_calendar/src/view/day_of_the_week.dart';

class DatesOutline extends StatelessWidget {
  const DatesOutline({
    required this.year,
    required this.month,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onTapDay,
    required this.setupData,
    Key? key,
  }) : super(key: key);

  final int year;
  final int month;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime) onTapDay;
  final CalendarSetupData setupData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.mon),
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.tue),
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.wed),
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.thu),
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.fri),
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.sat),
              DayOfTheWeek(label: setupData.dayOfTheWeekLabelsData.sun),
            ],
          ),
          const Divider(indent: 9, endIndent: 9, height: 9),

          DatesInMonth(
            targetYear: year,
            targetMonth: month,
            selectedStartDate: selectedStartDate,
            selectedEndDate: selectedEndDate,
            onTapDay: onTapDay,
            setupData: setupData,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
